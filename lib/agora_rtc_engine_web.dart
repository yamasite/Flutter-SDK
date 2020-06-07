@JS()
library agora_rtc_engine;

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'package:js/js.dart';


@JS()
@anonymous
class ClientOptions {
  external factory ClientOptions({mode, codec});
  external String get mode;
  external String get codec;
}
@JS()
@anonymous
class StreamSpec {
  external factory StreamSpec({streamID, video, audio, screen});
  external int get streamID;
  external bool get video;
  external bool get audio;
  external bool get screen;
}
@JS()
@anonymous
class ResolutionJS {
  external factory ResolutionJS({width, height});
  external int get width;
  external int get height;
}
@JS()
@anonymous
class VideoEncoderConfigurationJS {
  external factory VideoEncoderConfigurationJS({resolution, frameRate});
  external ResolutionJS get resolution;
  external int get frameRate;
}


@JS()
class AgoraRTC {
  external static createClient(ClientOptions config);
  external static createStream(StreamSpec spec);
  external void init(String appid);
}

@JS()
class Stream {
  external void init(Function success, Function failure);
}

@JS('console.log')
external void log(dynamic content);

class AgoraRtcEnginePlugin {
  dynamic engine;
  StreamSpec streamSpec;
  VideoEncoderConfigurationJS videoEncoderConfiguration;
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
        'agora_rtc_engine',
        const StandardMethodCodec(),
        registrar.messenger);
    final AgoraRtcEnginePlugin instance = AgoraRtcEnginePlugin();
    channel.setMethodCallHandler(instance.handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'create':
        final String appid = call.arguments['appId'];
        return _create(appid);
      case 'setVideoEncoderConfiguration':
        Map<dynamic, dynamic> config = call.arguments['config'];
        this.videoEncoderConfiguration = VideoEncoderConfigurationJS(
          resolution: ResolutionJS(
            width: config["width"], height: config["height"]), frameRate: config["frameRate"]);
        return true;
      case 'joinChannel':
        _joinChannel(call.arguments["token"], call.arguments["channelId"], call.arguments["info"], call.arguments["uid"]);
        return true;
      default:
        // throw PlatformException(
        //     code: 'Unimplemented',
        //     details: "The agora_rtc_engine plugin for web doesn't implement "
        //         "the method '${call.method}'");
        log("The agora_rtc_engine plugin for web does not implement the method '${call.method}'");
        return true;
    }
  }

  dynamic _create(String appid) {
    this.engine = AgoraRTC.createClient(ClientOptions(codec: "vp8", mode:"live"));
    this.engine.init(appid);
    return true;
  }

  bool _joinChannel(String token, String channelId, String info, int uid) {
    var streamSpec = StreamSpec(streamID: uid, video: true, audio: true, screen: false);
    var stream = AgoraRTC.createStream(streamSpec);
    stream.init(allowInterop((res){
      log('stream init success');
    }), allowInterop((e){
      log('stream init failure');
    }));
    return true;
  }
}