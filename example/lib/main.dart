import 'package:flutter/material.dart';
import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_audio_engine.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isInChannel = false;
  final _infoStrings = <String>[];

  @override
  void initState() {
    super.initState();

    _initAgoraRtcEngine();
    _addAgoraEventHandlers();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Agora Flutter Audio SDK'),
        ),
        body: Container(
          child: Column(
            children: [
              OutlineButton(
                child: Text(_isInChannel ? 'Leave Channel' : 'Join Channel',
                    style: textStyle),
                onPressed: _toggleChannel,
              ),
              Expanded(child: Container(child: _buildInfoList())),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _initAgoraRtcEngine() async {
    AgoraRtcEngine.create('YOUR APP ID');
    AgoraRtcEngine.setChannelProfile(ChannelProfile.Communication);
  }

  void _addAgoraEventHandlers() {
    AgoraRtcEngine.onJoinChannelSuccess =
        (String channel, int uid, int elapsed) {
      setState(() {
        String info = 'onJoinChannel: ' + channel + ', uid: ' + uid.toString();
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onLeaveChannel = () {
      setState(() {
        _infoStrings.add('onLeaveChannel');
      });
    };

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
      setState(() {
        String info = 'userJoined: ' + uid.toString();
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
      setState(() {
        String info = 'userOffline: ' + uid.toString();
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onFirstRemoteAudioFrame = (int uid, int elapsed) {
      setState(() {
        String info = 'firstRemoteAudio: ' + uid.toString();
        _infoStrings.add(info);
      });
    };
  }

  void _toggleChannel() {
    setState(() {
      if (_isInChannel) {
        _isInChannel = false;
        AgoraRtcEngine.leaveChannel();
      } else {
        _isInChannel = true;
        AgoraRtcEngine.joinChannel(null, 'flutter', null, 0);
      }
    });
  }

  static TextStyle textStyle = TextStyle(fontSize: 18, color: Colors.blue);

  Widget _buildInfoList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemExtent: 24,
      itemBuilder: (context, i) {
        return ListTile(
          title: Text(_infoStrings[i]),
        );
      },
      itemCount: _infoStrings.length,
    );
  }
}
