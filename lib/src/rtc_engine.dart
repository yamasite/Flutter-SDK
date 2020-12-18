import 'dart:async';

import 'package:flutter/services.dart';

import '../rtc_local_view.dart';
import 'classes.dart';
import 'enum_converter.dart';
import 'enums.dart';
import 'events.dart';
import 'rtc_channel.dart';

/// `RtcEngine` 类提供了供 App 调用的主要接口方法。
class RtcEngine with RtcEngineInterface {
  static const MethodChannel _methodChannel = MethodChannel('agora_rtc_engine');
  static const EventChannel _eventChannel =
      EventChannel('agora_rtc_engine/events');

 /// Exposing methodChannel to other files
  static MethodChannel get methodChannel => _methodChannel;

  static RtcEngine _engine;

  RtcEngineEventHandler _handler;

  RtcEngine._() {
    _eventChannel.receiveBroadcastStream().listen((event) {
      final eventMap = Map<dynamic, dynamic>.from(event);
      final methodName = eventMap['methodName'] as String;
      final data = List<dynamic>.from(eventMap['data']);
      _handler?.process(methodName, data);
    });
  }

  Future<T> _invokeMethod<T>(String method, [Map<String, dynamic> arguments]) {
    return _methodChannel.invokeMethod(method, arguments);
  }

  /// 创建 [RtcEngine] 实例。
  ///
  /// [RtcEngine] 类的所有接口函数，如无特殊说明，都是异步调用，对接口的调用建议在同一个线程进行。
  ///
  /// **Note**
  /// - 请确保在调用其他 API 前先调用该方法创建并初始化 [RtcEngine]。
  /// - You can create an [RtcEngine] instance either by calling this method or by calling [RtcEngine.createWithAreaCode]. The difference between [RtcEngine.createWithAreaCode] and this method is that [RtcEngine.createWithAreaCode] enables you to specify the connection area.
  /// - 调用该方法和 [RtcEngine.createWithAreaCode] 均能创建 [RtcEngine] 实例。
  /// - 目前 Agora Flutter SDK 只支持每个 app 创建一个 [RtcEngine] 实例。
  ///
  /// **Parameter** [appId] Agora 为 app 开发者签发的 App ID，详见[获取 App ID](https://docs.agora.io/cn/Agora%20Platform/token#get-an-app-id)。使用同一个 App ID 的 app 才能进入同一个频道进行通话或直播。一个 App ID 只能用于创建一个 [RtcEngine]。
  /// 如需更换 App ID，必须先调用 [destroy] 销毁当前 [RtcEngine]，再调用 [create] 重新创建 [RtcEngine]。
  ///
  /// **Returns**
  /// - 方法调用成功，则返回一个 [RtcEngine] 对象。
  /// - 方法调用失败，则返回错误码。
  static Future<RtcEngine> create(String appId) async {
    return createWithAreaCode(appId, AreaCode.GLOB);
  }

  /// 创建 [RtcEngine] 实例。
  ///
  /// [RtcEngine] 类的所有接口函数，如无特殊说明，都是异步调用，对接口的调用建议在同一个线程进行。
  ///
  /// **Note**
  /// - 请确保在调用其他 API 前先调用该方法创建并初始化 [RtcEngine]。
  /// - 调用该方法和 [create] 均能创建 [RtcEngine] 实例。
  /// - 该方法与 [create] 的区别在于，[createWithAreaCode] 支持在创建 [RtcEngine] 实例时指定访问区域。
  /// 时指定访问区域。
  /// - 目前 Agora Flutter SDK 只支持每个 app 创建一个 [RtcEngine] 实例。
  ///
  /// **Parameter** [appId] Agora 为 app 开发者签发的 App ID，详见[获取 App ID](https://docs.agora.io/cn/Agora%20Platform/token#get-an-app-id)。
  /// 使用同一个 App ID 的 app 才能进入同一个频道进行通话或直播。一个 App ID 只能用于创建一个 [RtcEngine]。
  /// 如需更换 App ID，必须先调用 [destroy] 销毁当前 [RtcEngine]，再调用 `create` 重新创建 [RtcEngine]。
  ///
  /// **Parameter** [areaCode] 服务器的访问区域。该功能为高级设置，适用于有访问安全限制的场景。
  ///
  /// 支持的区域详见 `AreaCode`。
  /// 指定访问区域后，集成了 Agora SDK 的 app 会连接指定区域内的 Agora 服务器。
  ///
  /// **Returns**
  /// - 方法调用成功，则返回一个 [RtcEngine] 对象。
  /// - 方法调用失败，则返回错误码。
  ///   - [ErrorCode.InvalidAppId]
  static Future<RtcEngine> createWithAreaCode(
      String appId, AreaCode areaCode) async {
    if (_engine != null) return _engine;
    await _methodChannel.invokeMethod('create', {
      'appId': appId,
      'areaCode': AreaCodeConverter(areaCode).value(),
      'appType': 4
    });
    _engine = RtcEngine._();
    return _engine;
  }

  @override
  Future<void> destroy() {
    RtcChannel.destroyAll();
    _handler = null;
    _engine = null;
    return _invokeMethod('destroy');
  }

  /// 添加 [RtcEngineEventHandler] 回调事件。
  ///
  /// 设置后，你可以通过 [RtcEngineEventHandler] 回调监听对应 [RtcEngine] 对象的事件、获取数据。
  ///
  /// **Parameter** [handler] [RtcEngineEventHandler] 回调句柄。
  void setEventHandler(RtcEngineEventHandler handler) {
    _handler = handler;
  }

  @override
  Future<void> setChannelProfile(ChannelProfile profile) {
    return _invokeMethod('setChannelProfile',
        {'profile': ChannelProfileConverter(profile).value()});
  }

   @override
  Future<void> setClientRole(ClientRole role, [ClientRoleOptions options]) {
    return _invokeMethod('setClientRole', {
      'role': ClientRoleConverter(role).value(),
      'options': options?.toJson()
    });
  }

  @override
  Future<void> joinChannel(
      String token, String channelName, String optionalInfo, int optionalUid) {
    return _invokeMethod('joinChannel', {
      'token': token,
      'channelName': channelName,
      'optionalInfo': optionalInfo,
      'optionalUid': optionalUid
    });
  }

  @override
  Future<void> switchChannel(String token, String channelName) {
    return _invokeMethod(
        'switchChannel', {'token': token, 'channelName': channelName});
  }

  @override
  Future<void> leaveChannel() {
    return _invokeMethod('leaveChannel');
  }

  @override
  Future<void> renewToken(String token) {
    return _invokeMethod('renewToken', {'token': token});
  }

  @override
  @deprecated
  Future<void> enableWebSdkInteroperability(bool enabled) {
    return _invokeMethod('enableWebSdkInteroperability', {'enabled': enabled});
  }

  @override
  Future<ConnectionStateType> getConnectionState() {
    return _invokeMethod('getConnectionState').then((value) {
      return ConnectionStateTypeConverter.fromValue(value).e;
    });
  }

  @override
  Future<String> getCallId() {
    return _invokeMethod('getCallId');
  }

  @override
  Future<void> rate(String callId, int rating, {String description}) {
    return _invokeMethod('rate',
        {'callId': callId, 'rating': rating, 'description': description});
  }

  @override
  Future<void> complain(String callId, String description) {
    return _invokeMethod(
        'complain', {'callId': callId, 'description': description});
  }

  @override
  Future<void> setLogFile(String filePath) {
    return _invokeMethod('setLogFile', {'filePath': filePath});
  }

  @override
  Future<void> setLogFilter(LogFilter filter) {
    return _invokeMethod(
        'setLogFilter', {'filter': LogFilterConverter(filter).value()});
  }

  @override
  Future<void> setLogFileSize(int fileSizeInKBytes) {
    return _invokeMethod(
        'setLogFileSize', {'fileSizeInKBytes': fileSizeInKBytes});
  }

  @override
  Future<void> setParameters(String parameters) {
    return _invokeMethod('setParameters', {'parameters': parameters});
  }

  @override
  Future<UserInfo> getUserInfoByUid(int uid) {
    return _invokeMethod('getUserInfoByUid', {'uid': uid}).then((value) {
      return UserInfo.fromJson(Map<String, dynamic>.from(value));
    });
  }

  @override
  Future<UserInfo> getUserInfoByUserAccount(String userAccount) {
    return _invokeMethod(
        'getUserInfoByUserAccount', {'userAccount': userAccount}).then((value) {
      return UserInfo.fromJson(Map<String, dynamic>.from(value));
    });
  }

  @override
  Future<void> joinChannelWithUserAccount(
      String token, String channelName, String userAccount) {
    return _invokeMethod('joinChannelWithUserAccount', {
      'token': token,
      'channelName': channelName,
      'userAccount': userAccount
    });
  }

  @override
  Future<void> registerLocalUserAccount(String appId, String userAccount) {
    return _invokeMethod('registerLocalUserAccount',
        {'appId': appId, 'userAccount': userAccount});
  }

  @override
  Future<void> adjustPlaybackSignalVolume(int volume) {
    return _invokeMethod('adjustPlaybackSignalVolume', {'volume': volume});
  }

  @override
  Future<void> adjustRecordingSignalVolume(int volume) {
    return _invokeMethod('adjustRecordingSignalVolume', {'volume': volume});
  }

  @override
  Future<void> adjustUserPlaybackSignalVolume(int uid, int volume) {
    return _invokeMethod(
        'adjustUserPlaybackSignalVolume', {'uid': uid, 'volume': volume});
  }

  @override
  Future<void> disableAudio() {
    return _invokeMethod('disableAudio');
  }

  @override
  Future<void> enableAudio() {
    return _invokeMethod('enableAudio');
  }

  @override
  Future<void> enableAudioVolumeIndication(
      int interval, int smooth, bool report_vad) {
    return _invokeMethod('enableAudioVolumeIndication',
        {'interval': interval, 'smooth': smooth, 'report_vad': report_vad});
  }

  @override
  Future<void> enableLocalAudio(bool enabled) {
    return _invokeMethod('enableLocalAudio', {'enabled': enabled});
  }

  @override
  Future<void> muteAllRemoteAudioStreams(bool muted) {
    return _invokeMethod('muteAllRemoteAudioStreams', {'muted': muted});
  }

  @override
  Future<void> muteLocalAudioStream(bool muted) {
    return _invokeMethod('muteLocalAudioStream', {'muted': muted});
  }

  @override
  Future<void> muteRemoteAudioStream(int uid, bool muted) {
    return _invokeMethod('muteRemoteAudioStream', {'uid': uid, 'muted': muted});
  }

  @override
  Future<void> setAudioProfile(AudioProfile profile, AudioScenario scenario) {
    return _invokeMethod('setAudioProfile', {
      'profile': AudioProfileConverter(profile).value(),
      'scenario': AudioScenarioConverter(scenario).value()
    });
  }

  @override
  Future<void> setDefaultMuteAllRemoteAudioStreams(bool muted) {
    return _invokeMethod(
        'setDefaultMuteAllRemoteAudioStreams', {'muted': muted});
  }

  @override
  Future<void> disableVideo() {
    return _invokeMethod('disableVideo');
  }

  @override
  Future<void> enableLocalVideo(bool enabled) {
    return _invokeMethod('enableLocalVideo', {'enabled': enabled});
  }

  @override
  Future<void> enableVideo() {
    return _invokeMethod('enableVideo');
  }

  @override
  Future<void> muteAllRemoteVideoStreams(bool muted) {
    return _invokeMethod('muteAllRemoteVideoStreams', {'muted': muted});
  }

  @override
  Future<void> muteLocalVideoStream(bool muted) {
    return _invokeMethod('muteLocalVideoStream', {'muted': muted});
  }

  @override
  Future<void> muteRemoteVideoStream(int uid, bool muted) {
    return _invokeMethod('muteRemoteVideoStream', {'uid': uid, 'muted': muted});
  }

  @override
  Future<void> setBeautyEffectOptions(bool enabled, BeautyOptions options) {
    return _invokeMethod('setBeautyEffectOptions',
        {'enabled': enabled, 'options': options.toJson()});
  }

  @override
  Future<void> setDefaultMuteAllRemoteVideoStreams(bool muted) {
    return _invokeMethod(
        'setDefaultMuteAllRemoteVideoStreams', {'muted': muted});
  }

  @override
  Future<void> setVideoEncoderConfiguration(VideoEncoderConfiguration config) {
    return _invokeMethod(
        'setVideoEncoderConfiguration', {'config': config.toJson()});
  }

  @override
  Future<void> startPreview() {
    return _invokeMethod('startPreview');
  }

  @override
  Future<void> stopPreview() {
    return _invokeMethod('stopPreview');
  }

  @override
  Future<void> adjustAudioMixingPlayoutVolume(int volume) {
    return _invokeMethod('adjustAudioMixingPlayoutVolume', {'volume': volume});
  }

  @override
  Future<void> adjustAudioMixingPublishVolume(int volume) {
    return _invokeMethod('adjustAudioMixingPublishVolume', {'volume': volume});
  }

  @override
  Future<void> adjustAudioMixingVolume(int volume) {
    return _invokeMethod('adjustAudioMixingVolume', {'volume': volume});
  }

  @override
  Future<int> getAudioMixingCurrentPosition() {
    return _invokeMethod('getAudioMixingCurrentPosition');
  }

  @override
  Future<int> getAudioMixingDuration() {
    return _invokeMethod('getAudioMixingDuration');
  }

  @override
  Future<int> getAudioMixingPlayoutVolume() {
    return _invokeMethod('getAudioMixingPlayoutVolume');
  }

  @override
  Future<int> getAudioMixingPublishVolume() {
    return _invokeMethod('getAudioMixingPublishVolume');
  }

  @override
  Future<void> pauseAudioMixing() {
    return _invokeMethod('pauseAudioMixing');
  }

  @override
  Future<void> resumeAudioMixing() {
    return _invokeMethod('resumeAudioMixing');
  }

  @override
  Future<void> setAudioMixingPosition(int pos) {
    return _invokeMethod('setAudioMixingPosition', {'pos': pos});
  }

  @override
  Future<void> startAudioMixing(
      String filePath, bool loopback, bool replace, int cycle) {
    return _invokeMethod('startAudioMixing', {
      'filePath': filePath,
      'loopback': loopback,
      'replace': replace,
      'cycle': cycle
    });
  }

  @override
  Future<void> stopAudioMixing() {
    return _invokeMethod('stopAudioMixing');
  }

  @override
  Future<void> addInjectStreamUrl(String url, LiveInjectStreamConfig config) {
    return _invokeMethod(
        'addInjectStreamUrl', {'url': url, 'config': config.toJson()});
  }

  @override
  Future<void> addPublishStreamUrl(String url, bool transcodingEnabled) {
    return _invokeMethod('addPublishStreamUrl',
        {'url': url, 'transcodingEnabled': transcodingEnabled});
  }

  @override
  Future<void> addVideoWatermark(
      String watermarkUrl, WatermarkOptions options) {
    return _invokeMethod('addVideoWatermark',
        {'watermarkUrl': watermarkUrl, 'options': options.toJson()});
  }

  @override
  Future<void> clearVideoWatermarks() {
    return _invokeMethod('clearVideoWatermarks');
  }

  @override
  Future<int> createDataStream(bool reliable, bool ordered) {
    return _invokeMethod(
        'createDataStream', {'reliable': reliable, 'ordered': ordered});
  }

  @override
  Future<void> disableLastmileTest() {
    return _invokeMethod('disableLastmileTest');
  }

  @override
  Future<void> enableDualStreamMode(bool enabled) {
    return _invokeMethod('enableDualStreamMode', {'enabled': enabled});
  }

  @override
  Future<void> enableInEarMonitoring(bool enabled) {
    return _invokeMethod('enableInEarMonitoring', {'enabled': enabled});
  }

  @override
  Future<void> enableLastmileTest() {
    return _invokeMethod('enableLastmileTest');
  }

  @override
  Future<void> enableSoundPositionIndication(bool enabled) {
    return _invokeMethod('enableSoundPositionIndication', {'enabled': enabled});
  }

  @override
  Future<double> getCameraMaxZoomFactor() {
    return _invokeMethod('getCameraMaxZoomFactor');
  }

  @override
  Future<double> getEffectsVolume() {
    return _invokeMethod('getEffectsVolume');
  }

  @override
  Future<bool> isCameraAutoFocusFaceModeSupported() {
    return _invokeMethod('isCameraAutoFocusFaceModeSupported');
  }

  @override
  Future<bool> isCameraExposurePositionSupported() {
    return _invokeMethod('isCameraExposurePositionSupported');
  }

  @override
  Future<bool> isCameraFocusSupported() {
    return _invokeMethod('isCameraFocusSupported');
  }

  @override
  Future<bool> isCameraTorchSupported() {
    return _invokeMethod('isCameraTorchSupported');
  }

  @override
  Future<bool> isCameraZoomSupported() {
    return _invokeMethod('isCameraZoomSupported');
  }

  @override
  Future<bool> isSpeakerphoneEnabled() {
    return _invokeMethod('isSpeakerphoneEnabled');
  }

  @override
  Future<void> pauseAllEffects() {
    return _invokeMethod('pauseAllEffects');
  }

  @override
  Future<void> pauseEffect(int soundId) {
    return _invokeMethod('pauseEffect', {'soundId': soundId});
  }

  @override
  Future<void> playEffect(int soundId, String filePath, int loopCount,
      double pitch, double pan, double gain, bool publish) {
    return _invokeMethod('playEffect', {
      'soundId': soundId,
      'filePath': filePath,
      'loopCount': loopCount,
      'pitch': pitch,
      'pan': pan,
      'gain': gain,
      'publish': publish
    });
  }

  @override
  Future<void> preloadEffect(int soundId, String filePath) {
    return _invokeMethod(
        'preloadEffect', {'soundId': soundId, 'filePath': filePath});
  }

  @override
  Future<void> registerMediaMetadataObserver() {
    return _invokeMethod('registerMediaMetadataObserver');
  }

  @override
  Future<void> removeInjectStreamUrl(String url) {
    return _invokeMethod('removeInjectStreamUrl', {'url': url});
  }

  @override
  Future<void> removePublishStreamUrl(String url) {
    return _invokeMethod('removePublishStreamUrl', {'url': url});
  }

  @override
  Future<void> resumeAllEffects() {
    return _invokeMethod('resumeAllEffects');
  }

  @override
  Future<void> resumeEffect(int soundId) {
    return _invokeMethod('resumeEffect', {'soundId': soundId});
  }

  @override
  Future<void> sendMetadata(String metadata) {
    return _invokeMethod('sendMetadata', {'metadata': metadata});
  }

  @override
  Future<void> sendStreamMessage(int streamId, String message) {
    return _invokeMethod(
        'sendStreamMessage', {'streamId': streamId, 'message': message});
  }

  @override
  Future<void> setCameraAutoFocusFaceModeEnabled(bool enabled) {
    return _invokeMethod(
        'setCameraAutoFocusFaceModeEnabled', {'enabled': enabled});
  }

  @override
  Future<void> setCameraCapturerConfiguration(
      CameraCapturerConfiguration config) {
    return _invokeMethod(
        'setCameraCapturerConfiguration', {'config': config.toJson()});
  }

  @override
  Future<void> setCameraExposurePosition(
      double positionXinView, double positionYinView) {
    return _invokeMethod('setCameraExposurePosition', {
      'positionXinView': positionXinView,
      'positionYinView': positionYinView
    });
  }

  @override
  Future<void> setCameraFocusPositionInPreview(
      double positionX, double positionY) {
    return _invokeMethod('setCameraFocusPositionInPreview',
        {'positionX': positionX, 'positionY': positionY});
  }

  @override
  Future<void> setCameraTorchOn(bool isOn) {
    return _invokeMethod('setCameraTorchOn', {'isOn': isOn});
  }

  @override
  Future<void> setCameraZoomFactor(double factor) {
    return _invokeMethod('setCameraZoomFactor', {'factor': factor});
  }

  @override
  Future<void> setDefaultAudioRoutetoSpeakerphone(bool defaultToSpeaker) {
    return _invokeMethod('setDefaultAudioRoutetoSpeakerphone',
        {'defaultToSpeaker': defaultToSpeaker});
  }

  @override
  Future<void> setEffectsVolume(double volume) {
    return _invokeMethod('setEffectsVolume', {'volume': volume});
  }

  @override
  Future<void> setEnableSpeakerphone(bool enabled) {
    return _invokeMethod('setEnableSpeakerphone', {'enabled': enabled});
  }

  @override
  @deprecated
  Future<void> setEncryptionMode(EncryptionMode encryptionMode) {
    return _invokeMethod('setEncryptionMode',
        {'encryptionMode': EncryptionModeConverter(encryptionMode).value()});
  }

  @override
  @deprecated
  Future<void> setEncryptionSecret(String secret) {
    return _invokeMethod('setEncryptionSecret', {'secret': secret});
  }

  @override
  Future<void> setInEarMonitoringVolume(int volume) {
    return _invokeMethod('setInEarMonitoringVolume', {'volume': volume});
  }

  @override
  Future<void> setLiveTranscoding(LiveTranscoding transcoding) {
    return _invokeMethod(
        'setLiveTranscoding', {'transcoding': transcoding.toJson()});
  }

  @override
  Future<void> setLocalPublishFallbackOption(StreamFallbackOptions option) {
    return _invokeMethod('setLocalPublishFallbackOption',
        {'option': StreamFallbackOptionsConverter(option).value()});
  }

  @override
   @deprecated
  Future<void> setLocalVoiceChanger(AudioVoiceChanger voiceChanger) {
    return _invokeMethod('setLocalVoiceChanger',
        {'voiceChanger': AudioVoiceChangerConverter(voiceChanger).value()});
  }

  @override
  Future<void> setLocalVoiceEqualization(
      AudioEqualizationBandFrequency bandFrequency, int bandGain) {
    return _invokeMethod('setLocalVoiceEqualization', {
      'bandFrequency':
      AudioEqualizationBandFrequencyConverter(bandFrequency).value(),
      'bandGain': bandGain
    });
  }

  @override
  Future<void> setLocalVoicePitch(double pitch) {
    return _invokeMethod('setLocalVoicePitch', {'pitch': pitch});
  }

  @override
  Future<void> setLocalVoiceReverb(AudioReverbType reverbKey, int value) {
    return _invokeMethod('setLocalVoiceReverb', {
      'reverbKey': AudioReverbTypeConverter(reverbKey).value(),
      'value': value
    });
  }

  @override
  @deprecated
  Future<void> setLocalVoiceReverbPreset(AudioReverbPreset preset) {
    return _invokeMethod('setLocalVoiceReverbPreset',
        {'preset': AudioReverbPresetConverter(preset).value()});
  }

  @override
  Future<void> setMaxMetadataSize(int size) {
    return _invokeMethod('setMaxMetadataSize', {'size': size});
  }

  @override
  Future<void> setRemoteDefaultVideoStreamType(VideoStreamType streamType) {
    return _invokeMethod('setRemoteDefaultVideoStreamType',
        {'streamType': VideoStreamTypeConverter(streamType).value()});
  }

  @override
  Future<void> setRemoteSubscribeFallbackOption(StreamFallbackOptions option) {
    return _invokeMethod('setRemoteSubscribeFallbackOption',
        {'option': StreamFallbackOptionsConverter(option).value()});
  }

  @override
  Future<void> setRemoteUserPriority(int uid, UserPriority userPriority) {
    return _invokeMethod('setRemoteUserPriority', {
      'uid': uid,
      'userPriority': UserPriorityConverter(userPriority).value()
    });
  }

  @override
  Future<void> setRemoteVideoStreamType(int uid, VideoStreamType streamType) {
    return _invokeMethod('setRemoteVideoStreamType', {
      'uid': uid,
      'streamType': VideoStreamTypeConverter(streamType).value()
    });
  }

  @override
  Future<void> setRemoteVoicePosition(int uid, double pan, double gain) {
    return _invokeMethod(
        'setRemoteVoicePosition', {'uid': uid, 'pan': pan, 'gain': gain});
  }

  @override
  Future<void> setVolumeOfEffect(int soundId, double volume) {
    return _invokeMethod(
        'setVolumeOfEffect', {'soundId': soundId, 'volume': volume});
  }

  @override
  Future<void> startAudioRecording(String filePath,
      AudioSampleRateType sampleRate, AudioRecordingQuality quality) {
    return _invokeMethod('startAudioRecording', {
      'filePath': filePath,
      'sampleRate': AudioSampleRateTypeConverter(sampleRate).value(),
      'quality': AudioRecordingQualityConverter(quality).value()
    });
  }

  @override
  Future<void> startChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration) {
    return _invokeMethod('startChannelMediaRelay', {
      'channelMediaRelayConfiguration': channelMediaRelayConfiguration.toJson()
    });
  }

  @override
  Future<void> startEchoTest(int intervalInSeconds) {
    return _invokeMethod(
        'startEchoTest', {'intervalInSeconds': intervalInSeconds});
  }

  @override
  Future<void> startLastmileProbeTest(LastmileProbeConfig config) {
    return _invokeMethod('startLastmileProbeTest', {'config': config.toJson()});
  }

  @override
  Future<void> stopAllEffects() {
    return _invokeMethod('stopAllEffects');
  }

  @override
  Future<void> stopAudioRecording() {
    return _invokeMethod('stopAudioRecording');
  }

  @override
  Future<void> stopChannelMediaRelay() {
    return _invokeMethod('stopChannelMediaRelay');
  }

  @override
  Future<void> stopEchoTest() {
    return _invokeMethod('stopEchoTest');
  }

  @override
  Future<void> stopEffect(int soundId) {
    return _invokeMethod('stopEffect', {'soundId': soundId});
  }

  @override
  Future<void> stopLastmileProbeTest() {
    return _invokeMethod('stopLastmileProbeTest');
  }

  @override
  Future<void> switchCamera() {
    return _invokeMethod('switchCamera');
  }

  @override
  Future<void> unloadEffect(int soundId) {
    return _invokeMethod('unloadEffect', {'soundId': soundId});
  }

  @override
  Future<void> unregisterMediaMetadataObserver() {
    return _invokeMethod('unregisterMediaMetadataObserver');
  }

  @override
  Future<void> updateChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration) {
    return _invokeMethod('updateChannelMediaRelay', {
      'channelMediaRelayConfiguration': channelMediaRelayConfiguration.toJson()
    });
  }

  @override
  Future<void> enableFaceDetection(bool enable) {
    return _invokeMethod('enableFaceDetection', {'enable': enable});
  }

  @override
  Future<void> setAudioMixingPitch(int pitch) {
    return _invokeMethod('setAudioMixingPitch', {'pitch': pitch});
  }

  @override
  Future<void> enableEncryption(bool enabled, EncryptionConfig config) {
    return _invokeMethod(
        'enableEncryption', {'enabled': enabled, 'config': config.toJson()});
  }

  @override
  Future<void> sendCustomReportMessage(
      String id, String category, String event, String label, int value) {
    return _invokeMethod('sendCustomReportMessage', {
      'id': id,
      'category': category,
      'event': event,
      'label': label,
      'value': value
    });
}

  @override
  Future<void> setAudioSessionOperationRestriction(
      AudioSessionOperationRestriction restriction) {
    return _invokeMethod('setAudioSessionOperationRestriction', {
      'restriction':
          AudioSessionOperationRestrictionConverter(restriction).value()
    });
  }

  @override
  Future<int> getNativeHandle() {
    return _invokeMethod('getNativeHandle');
  }

  @override
  Future<void> setAudioEffectParameters(
      AudioEffectPreset preset, int param1, int param2) {
    return _invokeMethod('setAudioEffectParameters', {
      'preset': AudioEffectPresetConverter(preset).value(),
      'param1': param1,
      'param2': param2
    });
  }

  @override
  Future<void> setAudioEffectPreset(AudioEffectPreset preset) {
    return _invokeMethod('setAudioEffectPreset',
        {'preset': AudioEffectPresetConverter(preset).value()});
  }

  @override
  Future<void> setVoiceBeautifierPreset(VoiceBeautifierPreset preset) {
    return _invokeMethod('setVoiceBeautifierPreset',
        {'preset': VoiceBeautifierPresetConverter(preset).value()});
  }
}

/// @nodoc
mixin RtcEngineInterface
    implements
        RtcUserInfoInterface,
        RtcAudioInterface,
        RtcVideoInterface,
        RtcAudioMixingInterface,
        RtcAudioEffectInterface,
        RtcVoiceChangerInterface,
        RtcVoicePositionInterface,
        RtcPublishStreamInterface,
        RtcMediaRelayInterface,
        RtcAudioRouteInterface,
        RtcEarMonitoringInterface,
        RtcDualStreamInterface,
        RtcFallbackInterface,
        RtcTestInterface,
        RtcMediaMetadataInterface,
        RtcWatermarkInterface,
        RtcEncryptionInterface,
        RtcAudioRecorderInterface,
        RtcInjectStreamInterface,
        RtcCameraInterface,
        RtcStreamMessageInterface {
  /// 销毁 [RtcEngine] 实例。
  ///
  /// 该方法释放 Agora SDK 使用的所有资源。有些 app 只在用户需要时才进行语音通话，
  /// 不需要时则将资源释放出来用于其他操作，该方法对这类程序可能比较有用。只要调用了 [RtcEngine.destroy] 方法，
  /// 用户将无法再使用和回调该 SDK 内的其它方法。如需再次使用通信功能，必须重新创建一个 [RtcEngine] 实例。
  ///
  /// **Note**
  /// - 该方法需要在子线程中操作。
  /// - 该方法为同步调用。在等待 [RtcEngine] 实例资源释放后再返回。
  /// APP 不应该在 SDK 产生的回调中调用该接口，否则由于 SDK 要等待回调返回才能回收相关的对象资源，会造成死锁。
  /// - 如果需要在销毁后再次创建 [RtcEngine] 实例，需要等待 [RtcEngine.destroy] 方法执行结束，
  /// 收到返回值后才能再创建实例。
  Future<void> destroy();

  /// 设置频道场景。
  ///
  /// 该方法用于设置 Agora 频道的使用场景。Agora SDK 会针对不同的使用场景采用不同的优化策略，
  /// 如通信场景偏好流畅，直播场景偏好画质。
  ///
  /// **Parameter** [profile] 频道使用场景。详见 [ChannelProfile]。
  Future<void> setChannelProfile(ChannelProfile profile);

  /// 设置直播场景下的用户角色。
  ///
  /// 在加入频道前，用户需要通过本方法设置观众（默认）或主播模式。在加入频道后，用户可以通过本方法切换用户模式。
  ///
  /// 直播场景下，如果你在加入频道后调用该方法切换用户角色，调用成功后，本地会触发 [RtcEngineEventHandler.clientRoleChanged] 回调；
  /// 远端会触发 [RtcEngineEventHandler.userJoined] 或 [RtcEngineEventHandler.userOffline] (`BecomeAudience`) 回调。
  ///
  /// **Parameter** [role] 用户角色。详见 [ClientRole]。
  Future<void> setClientRole(ClientRole role);

  /// 加入频道。
  ///
  /// 该方法让用户加入通话频道，在同一个频道内的用户可以互相通话，多个用户加入同一个频道，可以群聊。
  /// 使用不同 App ID 的 App 是不能互通的。如果已在通话中，用户必须调用 [RtcEngine.leaveChannel] 退出当前通话，
  /// 才能进入下一个频道。
  ///
  /// 成功调用该方加入频道后，本地会触发 [RtcEngineEventHandler.joinChannelSuccess] 回调；
  /// 通信场景下的用户和直播场景下的主播加入频道后，远端会触发 [RtcEngineEventHandler.userJoined] 回调。
  ///
  /// 在网络状况不理想的情况下，客户端可能会与 Agora 的服务器失去连接；SDK 会自动尝试重连，重连成功后，
  /// 本地会触发 [RtcEngineEventHandler.rejoinChannelSuccess] 回调。
  ///
  /// **Note**
  /// - 频道内每个用户的 UID 必须是唯一的。如果将 `uid` 设为 `0`，系统将自动分配一个 UID。
  /// 如果想要从不同的设备同时接入同一个频道，请确保每个设备上使用的 UID 是不同的。
  /// - 请确保用于生成 Token 的 App ID 和 `create` 方法创建 [RtcEngine] 对象时用的 App ID 一致。
  ///
  /// **Parameter** [token] 在 App 服务器端生成的用于鉴权的 Token：
  /// - 安全要求不高：你可以使用控制台生成的临时 Token，详见[获取临时 Token](https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms#temptoken)。
  /// - 安全要求高：将值设为你的服务端生成的正式 Token，详见[从服务端生成 Token](https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms#generatetoken)。
  ///
  /// **Parameter** [channelName] 标识通话的频道名称，长度在 64 字节以内的字符串。以下为支持的字符集范围（共 89 个字符）：
  ///
  ///  - 26 个小写英文字母 a-z
  ///  - 26 个大写英文字母 A-Z
  ///  - 10 个数字 0-9
  ///  - 空格
  ///  - "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ","
  ///
  /// **Parameter** [optionalInfo] （非必选项）开发者需加入的任何附加信息。一般可设置为空字符串，或频道相关信息。该信息不会传递给频道内的其他用户。
  ///
  /// **Parameter** [optionalUid] （非必选项）用户 ID，32 位无符号整数。建议设置范围：1 到 (2^32-1)，并保证唯一性。
  /// 如果不指定（即设为 0），SDK 会自动分配一个，并在 [RtcEngineEventHandler.joinChannelSuccess] 回调方法中返回，App 层必须记住该返回值并维护，SDK 不对该返回值进行维护。
  Future<void> joinChannel(
      String token, String channelName, String optionalInfo, int optionalUid);

  /// 快速切换直播频道。
  ///
  /// 当直播频道中的观众想从一个频道切换到另一个频道时，可以调用该方法，实现快速切换。
  ///
  /// 成功调用该方切换频道后，本地会先收到离开原频道的回调 [RtcEngineEventHandler.leaveChannel]，
  /// 再收到成功加入新频道的回调 [RtcEngineEventHandler.joinChannelSuccess]。
  ///
  /// **Note**
  /// - 该方法仅适用直播频道中的观众用户。
  ///
  /// **Parameter** [token] 在服务器端生成的用于鉴权的 Token：
  /// - 安全要求不高：你可以使用控制台生成的临时 Token，详见[获取临时 Token](https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms#temptoken)。
  /// - 安全要求高：将值设为你的服务端生成的正式 Token，详见[从服务端生成 Token](https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms#generatetoken)。
  ///
  /// **Parameter** [channelName] 标识频道的频道名，最大不超过 64 字节。以下为支持的字符集范围（共 89 个字符）：
  /// - 26 个小写英文字母 a-z
  /// - 26 个大写英文字母 A-Z
  /// - 10 个数字 0-9
  /// - 空格
  /// - "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ","
  Future<void> switchChannel(String token, String channelName);

  /// 离开频道。
  ///
  /// 离开频道，即挂断或退出通话。
  ///
  /// 调用 [RtcEngine.joinChannel] 后，必须调用 [leaveChannel] 结束通话，否则无法开始下一次通话。
  ///
  /// 不管当前是否在通话中，都可以调用 [leaveChannel]，没有副作用。
  ///
  /// 该方法会把会话相关的所有资源释放掉。该方法是异步操作，调用返回时并没有真正退出频道。
  ///
  /// 成功调用该方法离开频道后，本地会触发 [RtcEngineEventHandler.leaveChannel] 回调；通信场景下的用户和直播场景下的主播离开频道后，远端会触发 [RtcEngineEventHandler.userOffline] 回调。
  ///
  /// **Note**
  /// - 如果你调用了 `leaveChannel` 后立即调用 [RtcEngine.destroy] 方法，SDK 将无法触发 [RtcEngineEventHandler.leaveChannel] 回调。
  /// - 如果你在旁路推流过程中调用了 `leaveChannel` 方法， SDK 将自动调用 [RtcEngine.removeInjectStreamUrl] 方法。
  Future<void> leaveChannel();

  /// 更新 Token。
  ///
  /// 该方法用于更新 Token。如果启用了 Token 机制，过一段时间后使用的 Token 会失效。以下两种情况下，app 应重新获取 Token，然后
  /// 调用 `renewToken` 更新 Token，否则 SDK 无法和服务器建立连接：
  /// - 发生 [RtcEngineEventHandler.tokenPrivilegeWillExpire] 回调时。
  /// - [RtcEngineEventHandler.connectionStateChanged] 回调报告 [ConnectionChangedReason.TokenExpired] 时。
  ///
  /// **Parameter** [token] 新的 Token。
  Future<void> renewToken(String token);

  /// 打开与 Web SDK 的互通（仅在直播下适用）。
  ///
  /// **Deprecated**
  /// 该方法已废弃。自 v3.0.1 起，SDK 自动开启与 Web SDK 的互通，无需调用该方法开启。
  ///
  /// 该方法打开或关闭与 Agora Web SDK 的互通。如果有用户通过 Web SDK 加入频道，请确保调用该方法，否则 Web 端用户看 Native 端的画面会是黑屏。
  ///
  /// 该方法仅在直播场景下适用，通信场景下默认互通是打开的。
  ///
  /// **Parameter** [enabled] 是否打开与 Agora Web SDK 的互通：
  /// - `true`：打开互通。
  /// - `false`：（默认）关闭互通。
  @deprecated
  Future<void> enableWebSdkInteroperability(bool enabled);

  /// 获取当前网络连接状态。
  Future<ConnectionStateType> getConnectionState();

  /// 获取通话 ID。
  ///
  /// 获取当前的通话 ID。客户端在每次 [RtcEngine.joinChannel] 后会生成一个对应的 `CallId`，
  /// 标识该客户端的此次通话。有些方法如 [RtcEngine.rate]、[RtcEngine.complain] 需要在通话结束后调用，向 SDK 提交反馈，这些方法必须指定 `CallId` 参数。
  /// 使用这些反馈方法，需要在通话过程中调用 [RtcEngine.getCallId] 方法获取 `CallId`，在通话结束后在反馈方法中作为参数传入。
  ///
  /// **Returns**
  /// 通话 ID。
  Future<String> getCallId();

  /// 给通话评分。
  ///
  /// **Parameter** [callId] 通过 [RtcEngine.getCallId] 函数获取的通话 ID。
  ///
  /// **Parameter** [rating] 给通话的评分，最低 1 分，最高 5 分，如超过这个范围，SDK 会返回 [ErrorCode.InvalidArgument] 错误。
  ///
  /// **Parameter** [description] （非必选项）给通话的描述，可选，长度应小于 800 字节。
  Future<void> rate(String callId, int rating, {String description});

  /// 投诉通话质量。
  ///
  /// 该方法让用户就通话质量进行投诉。一般在通话结束后调用。
  ///
  /// **Parameter** [callId] 通话 [RtcEngine.getCallId] 函数获取的通话 ID。
  ///
  /// **Parameter** [description] （非必选项）给通话的描述，可选，长度应小于 800 字节。
  Future<void> complain(String callId, String description);

  /// 设置 Agora SDK 输出的日志文件。
  ///
  /// 设置 SDK 的输出 log 文件。SDK 运行时产生的所有 log 将写入该文件。 App 必须保证指定的目录存在而且可写。
  ///
  /// **Note**
  /// 如需调用本方法，请在调用 [RtcEngine.create] 方法初始化 `RtcEngine` 对象后立即调用，否则可能造成输出日志不完整。
  ///
  /// **Parameter** [filePath] 日志文件的完整路径。该日志文件为 UTF-8 编码。
  /// - Android 平台：默认路径为 `/storage/emulated/0/Android/data/<package name>="">/files/agorasdk.log`。
  /// - iOS 平台：默认路径为 `App Sandbox/Library/caches/agorasdk.log`.
  Future<void> setLogFile(String filePath);

  /// 设置日志输出等级
  ///
  /// 该方法设置 SDK 的日志输出等级。不同的等级可以单独或组合使用。
  ///
  /// 日志级别顺序依次为 `OFF`、`CRITICAL`、`ERROR`、`WARNING`、`INFO` 和 `DEBUG`。选择一个级别，你就可以看到在该级别之前所有级别的日志信息。 例如，你选择 `WARNING` 级别，就可以看到在 `CRITICAL`、`ERROR` 和 `WARNING` 级别上的所有日志信息。
  ///
  /// **Parameter** [filter] 日志输出等级。详见 [LogFilter]。
  Future<void> setLogFilter(LogFilter filter);

  /// 设置 Agora SDK 输出的单个日志文件大小。
  ///
  /// 默认情况下，SDK 会生成 agorasdk.log、agorasdk_1.log、agorasdk_2.log、agorasdk_3.log、agorasdk_4.log 这 5 个日志文件。每个文件的默认大小为 1024 KB。日志文件为 UTF-8 编码。 最新的日志永远写在 agorasdk.log 中。agorasdk.log 写满后，SDK 会从 1-4 中删除修改时间最早的一个文件，然后将 agorasdk.log 重命名为该文件，并建立新的 agorasdk.log 写入最新的日志。
  ///
  /// **Parameter** [fileSizeInKBytes] 单个日志文件的大小，单位为 KB。默认值为 1024 KB。如果你将 `fileSizeInKBytes` 设为 1024 KB，SDK 会最多输出 5 MB 的日志文件。如果你将 `fileSizeInKBytes` 设为 小于 1024 KB，单个日志文件最大仍为 1024 KB。
  Future<void> setLogFileSize(int fileSizeInKBytes);

  /// 通过 JSON 配置 SDK 提供技术预览或特别定制功能。
  ///
  /// JSON 选项默认不公开。声网工程师正在努力寻求以标准化方式公开 JSON 选项。
  ///
  /// **Parameter** [parameters] JSON 字符串形式的参数。
  Future<void> setParameters(String parameters);

  /// Gets the native handle of the SDK engine.
  ///
  /// This interface is used to retrieve the native C++ handle of the SDK engine used in special scenarios, such as registering the audio and video frame observer.
  Future<int> getNativeHandle();
}

/// @nodoc
mixin RtcUserInfoInterface {
  /// 注册本地用户 User Account。
  ///
  /// 该方法为本地用户注册一个 User Account。注册成功后，该 User Account 即可标识该本地用户的身份，用户可以使用它加入频道。
  ///
  /// 成功注册 User Account 后，本地会触发 [RtcEngineEventHandler.localUserRegistered] 回调，
  /// 告知本地用户的 UID 和 User Account。
  ///
  /// 该方法为可选。如果你希望用户使用 User Account 加入频道，可以选用以下两种方式：
  /// - 先调用 [RtcEngine.registerLocalUserAccount] 方法注册 Account，
  /// 再调用 [RtcEngine.joinChannelWithUserAccount] 方法加入频道。
  /// - 直接调用 [RtcEngine.joinChannelWithUserAccount] 方法加入频道。
  ///
  /// 两种方式的区别在于，提前调用 [RtcEngine.registerLocalUserAccount]，可以缩短使用 [RtcEngine.joinChannelWithUserAccount] 进入频道的时间。
  ///
  /// **Note**
  /// - `userAccount` 不能为空，否则该方法不生效。
  /// - 请确保在该方法中设置的 `userAccount` 在频道中的唯一性。
  /// - 为保证通信质量，请确保频道内使用同一类型的数据标识用户身份。即同一频道内需要统一使用 UID 或 User Account。
  /// 如果有用户通过 Agora Web SDK 加入频道，请确保 Web 加入的用户也是同样类型。
  ///
  /// **Parameter** [appId] 你的项目在 Agora 控制台注册的 App ID。
  ///
  /// **Parameter** [userAccount] 用户 User Account。该参数为必填，最大不超过 255 字节，不可填 null。请确保注册的 User Account 的唯一性。以下为支持的字符集范围（共 89 个字符）：
  /// - 26 个小写英文字母 a-z
  /// - 26 个大写英文字母 A-Z
  /// - 10 个数字 0-9
  /// - 空格
  /// - "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ","
  Future<void> registerLocalUserAccount(String appId, String userAccount);

  /// 使用 User Account 加入频道。
  ///
  /// 该方法允许本地用户使用 User Account 加入频道。成功加入频道后，会触发以下回调：
  /// - 本地：[RtcEngineEventHandler.localUserRegistered] 和 [RtcEngineEventHandler.joinChannelSuccess] 回调。
  /// - 通信场景下的用户和直播场景下的主播加入频道后，远端会依次触发 [RtcEngineEventHandler.userJoined] 和 [RtcEngineEventHandler.userInfoUpdated] 回调。
  ///
  /// **Note**
  ///
  /// 为保证通信质量，请确保频道内使用同一类型的数据标识用户身份。即同一频道内需要统一使用 UID 或 User Account。
  /// 如果有用户通过 Agora Web SDK 加入频道，请确保 Web 加入的用户也是同样类型。
  ///
  /// **Parameter** [token] 在服务器端生成的用于鉴权的 Token。
  ///  - 安全要求不高：你可以使用控制台生成的临时 Token，详见[获取临时 Token](https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms#temptoken)。
  ///  - 安全要求高：将值设为你的服务端生成的正式 Token，详见[从服务端生成 Token](https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms#generatetoken)。
  ///
  /// **Parameter** [channelName] 标识频道的频道名，最大不超过 64 字节。以下为支持的字符集范围（共 89 个字符）：
  ///  - 26 个小写英文字母 a-z
  ///  - 26 个大写英文字母 A-Z
  ///  - 10 个数字 0-9
  ///  - 空格
  ///  - "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ","
  ///
  /// **Parameter** [userAccount] 用户 User Account。该参数为必需，最大不超过 255 字节，不可为 null。请确保加入频道的 User Account 的唯一性。以下为支持的字符集范围（共 89 个字符）：
  ///  - 26 个小写英文字母 a-z
  ///  - 26 个大写英文字母 A-Z
  ///  - 10 个数字 0-9
  ///  - 空格
  ///  - "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ","
  ///
  Future<void> joinChannelWithUserAccount(
      String token, String channelName, String userAccount);

  /// 通过 User Account 获取用户信息。
  ///
  /// 远端用户加入频道后， SDK 会获取到该远端用户的 UID 和 User Account，然后缓存一个包含了远端用户 UID 和 User Account 的 Mapping 表，
  /// 并在本地触发 [RtcEngineEventHandler.userInfoUpdated] 回调。
  /// 收到这个回调后，你可以调用该方法，通过传入 User Account 获取包含了指定用户 User Account 的 UserInfo 对象。
  ///
  /// **Parameter** [userAccount] User Account。该参数为必填。
  Future<UserInfo> getUserInfoByUserAccount(String userAccount);

  /// 通过 UID 获取用户信息。
  ///
  /// 远端用户加入频道后， SDK 会获取到该远端用户的 UID 和 User Account，然后缓存一个包含了远端用户 UID 和 User Account 的 Mapping 表，
  /// 并在本地触发 [RtcEngineEventHandler.userInfoUpdated] 回调。
  /// 收到这个回调后，你可以调用该方法，通过传入 UID 获取包含了指定用户 User Account 的 UserInfo 对象。
  ///
  /// **Parameter** [uid] 用户 ID。该参数为必填。
  Future<UserInfo> getUserInfoByUid(int uid);
}

mixin RtcAudioInterface {
  /// 启用音频模块（默认为开启状态）。
  ///
  /// **Note**
  /// - 该方法设置的是内部引擎为开启状态，在频道内和频道外均可调用，且在 [RtcEngine.leaveChannel] 后仍然有效。
  /// - 该方法重置整个引擎，响应速度较慢，因此我们建议使用如下方法来控制音频模块：
  ///   - [RtcEngine.enableLocalAudio]：是否启动麦克风采集并创建本地音频流。
  ///   - [RtcEngine.muteLocalAudioStream]：是否发布本地音频流。
  ///   - [RtcEngine.muteRemoteAudioStream]：是否接收并播放远端音频流。
  ///   - [RtcEngine.muteAllRemoteAudioStreams]：是否接收并播放所有远端音频流。
  Future<void> enableAudio();

  /// 关闭音频模块。
  ///
  /// **Note**
  /// - 该方法设置的是内部引擎为禁用状态，在频道内和频道外均可调用，且在 [RtcEngine.leaveChannel] 后仍然有效。
  /// - 该方法重置整个引擎，响应速度较慢，因此 Agora 建议使用如下方法来控制音频模块：
  ///   - [RtcEngine.enableLocalAudio]：是否启动麦克风采集并创建本地音频流。
  ///   - [RtcEngine.muteLocalAudioStream]：是否发布本地音频流。
  ///   - [RtcEngine.muteRemoteAudioStream]：是否接收并播放远端音频流。
  ///   - [RtcEngine.muteAllRemoteAudioStreams]：是否接收并播放所有远端音频流。
  Future<void> disableAudio();

  /// 设置音频编码配置。
  ///
  /// **Note**
  /// - 该方法需要在 [RtcEngine.joinChannel] 之前设置好，[RtcEngine.joinChannel] 后设置不生效。
  /// - 通信和直播场景下，音质（码率）会有网络自适应的调整，通过该方法设置的是一个最高码率。
  /// - 在有高音质需求的场景（例如音乐教学场景）中，建议将 `profile` 设置为 [AudioProfile.MusicHighQuality]，`scenario` 设置为 [AudioScenario.GameStreaming]。
  ///
  /// **Parameter** [profile] 设置采样率，码率，编码模式和声道数。详见 [AudioProfile]。
  ///
  /// **Parameter** [scenario] 设置音频应用场景。不同的音频场景下，设备的系统音量是不同的。详见 [AudioScenario]。
  Future<void> setAudioProfile(AudioProfile profile, AudioScenario scenario);

  /// 调节录音音量。
  ///
  /// **Note**
  ///
  /// 为避免回声并提升通话质量，Agora 建议将 `volume` 值设为 [0,100]。如果 `volume` 值需超过 100，联系[技术支持](https://agora-ticket.agora.io/)。
  ///
  /// **Parameter** [volume] 录音信号音量，可在 [0,400] 范围内进行调节：
  /// - 0：静音。
  /// - 100：原始音量。
  /// - 400：最大可为原始音量的 4 倍（自带溢出保护）。
  Future<void> adjustRecordingSignalVolume(int volume);

  /// 调节本地播放的指定远端用户音量。
  ///
  /// 你可以在通话中调用该方法调节指定远端用户在本地播放的音量。如需调节多个用户在本地播放的音量，则需多次调用该方法。
  ///
  /// **Note**
  /// - 该方法要在加入频道后调用。
  /// - 该方法调节的是本地播放的指定远端用户混音后的音量。
  /// - 该方法每次只能调整一位远端用户在本地播放的音量。如需调整多位远端用户在本地播放的音量，则需多次调用该方法。
  ///
  /// **Parameter** [uid] 远端用户的 ID。
  ///
  /// **Parameter** [volume] 播放音量，取值范围为 [0,100]。
  /// - 0：静音。
  /// - 100：原始音量。
  Future<void> adjustUserPlaybackSignalVolume(int uid, int volume);

  /// 调节本地播放的所有远端用户音量。
  ///
  /// **Note**
  /// - 该方法调节的是本地播放的所有远端用户混音后的音量。
  /// - 静音本地音频需同时调用该方法和 [RtcEngine.adjustAudioMixingVolume] 方法，并将 `volume` 参数设置为 0。
  /// - 为避免回声并提升通话质量，Agora 建议将 `volume` 值设为 [0,100]。如果 `volume` 值需超过 100，联系[技术支持](https://agora-ticket.agora.io/)。
  ///
  /// **Parameter** [volume] 播放音量，取值范围为 [0,400]：
  /// - 0：静音。
  /// - 100：原始音量。
  /// - 400：最大可为原始音量的 4 倍（自带溢出保护）。
  Future<void> adjustPlaybackSignalVolume(int volume);

  /// 开启/关闭本地音频采集。
  ///
  /// 当 app 加入频道时，它的语音功能默认是开启的。该方法可以关闭或重新开启本地语音，即停止或重新开始本地音频采集。
  ///
  /// 该方法不影响接收或播放远端音频流，`enableLocalAudio(false)` 适用于只听不发的用户场景。
  ///
  /// 语音功能关闭或重新开启后，会收到回调 [RtcEngineEventHandler.localAudioStateChanged]，
  /// 并报告 [AudioLocalState.Stopped] 或 [AudioLocalState.Recording]。
  ///
  /// **Note**
  /// - 调用 `enableLocalAudio(false)` 关闭本地采集后，系统会走媒体音量；调用 `enableLocalAudio(true)` 重新打开本地采集后，系统会恢复为通话音量。
  /// - 该方法与 [RtcEngine.muteLocalAudioStream] 的区别在于：
  ///   - [RtcEngine.enableLocalAudio] 开启或关闭本地语音采集及处理。使用 `enableLocalAudio` 关闭或开启本地采集后，本地听远端播放会有短暂中断。
  ///   - [RtcEngine.muteLocalAudioStream] 停止或继续发送本地音频流。
  ///
  /// **Parameter** [enabled] 是否开启本地语音。
  /// - `true`：（默认）重新开启本地语音，即开启本地语音采集。
  /// - `false`：关闭本地语音，即停止本地语音采集。
  Future<void> enableLocalAudio(bool enabled);

  /// 停止/恢复发送本地音频流。
  ///
  /// 静音/取消静音。该方法用于允许/禁止往网络发送本地音频流。
  /// 成功调用该方法后，远端会触发 [RtcEngineEventHandler.userMuteAudio] 回调。
  ///
  /// **Note**
  /// - 该方法不影响录音状态，并没有禁用麦克风。
  /// - 如果你在该方法后调用 [RtcEngine.setChannelProfile] 方法，SDK 会根据你设置的频道模式以及用户角色，
  /// 重新设置是否停止发送本地音频。因此我们建议在 [RtcEngine.setChannelProfile] 后调用该方法。
  ///
  /// **Parameter** [muted] 是否停止发送本地音频流。
  /// - `true`: 停止发送本地音频流。
  /// - `false`:（默认）继续发送本地音频流。
  Future<void> muteLocalAudioStream(bool muted);

  /// 停止/恢复接收指定音频流。
  ///
  /// 如果之前有调用过 [RtcEngine.muteAllRemoteAudioStreams] (`true`) 停止接收
  /// 所有远端音频流，在调用本 API 之前请确保你已调用 [RtcEngine.muteAllRemoteAudioStreams] (`false`)。
  /// [RtcEngine.muteAllRemoteAudioStreams] 是全局控制，
  /// [RtcEngine.muteRemoteAudioStream] 是精细控制。
  ///
  /// **Parameter** [uid] 指定的用户 ID。
  ///
  /// **Parameter** [muted] 是否停止接收指定用户的音频流：
  /// - `true`：停止接收指定用户的音频流。
  /// - `false`：继续接收指定用户的音频流（默认）。
  Future<void> muteRemoteAudioStream(int uid, bool muted);

  /// 停止/恢复接收所有音频流。
  ///
  /// **Parameter** [muted] 是否停止接收所有音频流：
  /// - `true`：停止接收所有远端音频流。
  /// - `false`：继续接收所有远端音频流（默认）。
  Future<void> muteAllRemoteAudioStreams(bool muted);

  /// 设置是否默认接收音频流。
  ///
  /// 该方法在加入频道前后都可调用。如果在加入频道后调用 `setDefaultMuteAllRemoteAudioStreams(true)`，
  /// 会接收不到后面加入频道的用户的音频流。
  ///
  /// **Note**
  ///
  /// 停止接收音频流后，如果想要恢复接收，请调用 [RtcEngine.muteRemoteAudioStream] (`false`)，并指定你想要
  /// 接收的远端用户的 ID。
  /// 如果想恢复接收多个用户的音频流，则需要多次调用 [RtcEngine.muteRemoteAudioStream]。
  /// [RtcEngine.setDefaultMuteAllRemoteAudioStreams] (`false`) 只能恢复接收设置后加入频道的用户的音频流。
  ///
  /// **Parameter** [muted] 是否默认不接收所有远端音频：
  /// - `true`：默认不接收所有远端音频流。
  /// - `false`: 默认接收所有远端音频流（默认）。
  Future<void> setDefaultMuteAllRemoteAudioStreams(bool muted);

  /// 启用说话者音量提示。
  ///
  /// 该方法允许 SDK 定期向 App 反馈当前谁在说话以及说话者的音量。启用该方法后，无论频道内是否有人说话，
  /// 都会在说话声音音量提示回调 [RtcEngineEventHandler.audioVolumeIndication] 回调
  /// 中按设置的间隔时间返回音量提示。
  ///
  /// **Parameter** [interval] 指定音量提示的时间间隔：
  /// - &le; 0：禁用音量提示功能。
  /// - &gt; 0：返回音量提示的间隔，单位为毫秒。建议设置到大于 200 毫秒。最小不得少于 10 毫秒，否则会收不到 [RtcEngineEventHandler.audioVolumeIndication] 回调。
  ///
  /// **Parameter** [smooth] 平滑系数，指定音量提示的灵敏度。取值范围为 [0, 10]，建议值为 3，数字越大，波动越灵敏；数字越小，波动越平滑。
  ///
  /// **Parameter** [report_vad] 是否开启人声检测
  /// - `true`: 开启本地人声检测功能。开启后，[RtcEngineEventHandler.audioVolumeIndication] 回调的 `vad` 参数会报告是否在本地检测到人声。
  /// - `false`: （默认）关闭本地人声检测功能。除引擎自动进行本地人声检测的场景外，[RtcEngineEventHandler.audioVolumeIndication] 回调的 `vad` 参数不会报告是否在本地检测到人声。
  Future<void> enableAudioVolumeIndication(
      int interval, int smooth, bool report_vad);
}

mixin RtcVideoInterface {
  /// 启用视频模块。
  ///
  /// 该方法用于打开视频模式。可以在加入频道前或者通话中调用，在加入频道前调用，则自动开启视频模式，
  /// 在通话中调用则由音频模式切换为视频模式。调用 [RtcEngine.disableVideo] 方法可关闭视频模式。
  ///
  /// 成功调用该方法后，远端会触发 [RtcEngineEventHandler.userEnableVideo] (`true`) 回调。
  ///
  /// **Note**
  ///
  /// - 该方法设置的是内部引擎为开启状态，在频道内和频道外均可调用，且在 [RtcEngine.leaveChannel] 后仍然有效。
  /// - 该方法重置整个引擎，响应速度较慢，因此 Agora 建议使用如下方法来控制视频模块：
  ///  - [RtcEngine.enableLocalVideo]：是否启动摄像头采集并创建本地视频流。
  ///  - [RtcEngine.muteLocalVideoStream]：是否发布本地视频流。
  ///  - [RtcEngine.muteRemoteVideoStream]：是否接收并播放远端视频流。
  ///  - [RtcEngine.muteAllRemoteVideoStreams]：是否接收并播放所有远端视频流。
  Future<void> enableVideo();

  /// 关闭视频模块。
  ///
  /// 该方法用于关闭视频。可以在加入频道前或者通话中调用，在加入频道前调用，则自动开启纯音频模式，在通话中调用则由视频模式切换为纯音频频模式。
  /// 调用 [RtcEngine.enableVideo] 方法可开启视频模式。
  ///
  /// 成功调用该方法后，远端会触发 [RtcEngineEventHandler.userEnableVideo] (`false`) 回调。
  ///
  /// **Note**
  /// - 该方法设置的是内部引擎为禁用状态，在频道内和频道外均可调用，且在 [RtcEngine.leaveChannel] 后仍然有效。
  /// - 该方法重置整个引擎，响应速度较慢，因此 Agora 建议使用如下方法来控制视频模块：
  ///
  ///     - [RtcEngine.enableLocalVideo]：是否启动摄像头采集并创建本地视频流。
  ///     - [RtcEngine.muteLocalVideoStream]：是否发布本地视频流。
  ///     - [RtcEngine.muteRemoteVideoStream]：是否接收并播放远端视频流。
  ///     - [RtcEngine.muteAllRemoteVideoStreams]：是否接收并播放所有远端视频流。
  Future<void> disableVideo();

  /// 设置视频编码属性。
  ///
  /// 该方法设置视频编码属性。每个属性对应一套视频参数，如分辨率、帧率、码率、视频方向等。 所有设置的参数均为理想情况下的最大值。当视频引擎因网络环境等原因无法达到设置的分辨率、帧率或码率的最大值时，会取最接近最大值的那个值。
  ///
  /// 如果用户加入频道后不需要重新设置视频编码属性，则 Agora 建议在 [RtcEngine.enableVideo] 前调用该方法，可以加快首帧出图的时间。
  ///
  /// **Parameter** [config] 视频编码属性。详见 [VideoEncoderConfiguration]。
  Future<void> setVideoEncoderConfiguration(VideoEncoderConfiguration config);

  /// 开启视频预览。
  ///
  /// 该方法用于在进入频道前启动本地视频预览。
  ///
  /// 调用该 API 前，必须：
  /// - 创建 `RtcLocalView`。
  /// - 调用 [RtcEngine.enableVideo] 开启视频功能。
  ///
  /// **Note**
  /// - 本地预览默认开启镜像功能。
  ///   - （仅 Android）详见 [TextureView] 和 [SurfaceView]。
  ///   - （仅 iOS）详见 [UIView](https://developer.apple.com/documentation/uikit/uiview).
  /// - 使用该方法启用了本地视频预览后，如果直接调用 [RtcEngine.leaveChannel] 退出频道，
  /// 并不会关闭预览。如需关闭预览，请调用 [RtcEngine.stopPreview]。
  Future<void> startPreview();

  /// 停止视频预览。
  Future<void> stopPreview();

  /// 开启/关闭本地视频采集。
  ///
  /// 该方法禁用或重新启用本地视频采集。不影响接收远端视频。
  ///
  /// 调用 [RtcEngine.enableVideo] 后，本地视频即默认开启。
  /// 你可以调用 [RtcEngine.enableVideo] (`false`) 关闭本地视频采集。关闭后如果想重新开启，则可调用 [RtcEngine.enableVideo] (`true`)。
  ///
  /// 成功禁用或启用本地视频采集后，远端会触发 [RtcEngineEventHandler.userEnableLocalVideo] 回调。
  ///
  /// **Note**
  ///
  /// 该方法设置的是内部引擎为启用或禁用状态，在 [RtcEngine.leaveChannel] 后仍然有效。
  ///
  /// **Parameter** [enabled] 是否启用本地视频：
  /// - `true`：开启本地视频采集和渲染（默认）。
  /// - `false`: 关闭使用本地摄像头设备。关闭后，
  /// 远端用户会接收不到本地用户的视频流；但本地用户依然可以接收远端用户的视频流。设置为 `false` 时，该方法不需要本地有摄像头。
  Future<void> enableLocalVideo(bool enabled);

  /// 停止/恢复发送本地视频流。
  ///
  /// 成功调用该方法后，远端会触发 [RtcEngineEventHandler.userMuteVideo] 回调。
  ///
  /// **Note**
  /// - 调用该方法时，SDK 不再发送本地视频流，但摄像头仍然处于工作状态。
  /// 相比于 [RtcEngine.enableLocalVideo] (`false`) 用于控制本地视频流发送的方法，该方法响应速度更快。
  /// - 该方法不影响本地视频流获取，没有禁用摄像头。
  /// - 如果你在该方法后调用 [RtcEngine.setChannelProfile] 方法，SDK 会根据你设置的频道模式以及用户角色，
  /// 重新设置是否停止发送本地视频。因此我们建议在 [RtcEngine.setChannelProfile] 后调用该方法。
  ///
  /// **Parameter** [muted] 是否发送本地视频流:
  /// - `true`：不发送本地视频流。
  /// - `false`：（默认）发送本地视频流。
  Future<void> muteLocalVideoStream(bool muted);

  /// 停止/恢复接收指定视频流。
  ///
  /// **Note**
  ///
  /// 如果之前有调用过 [RtcEngine.muteAllRemoteVideoStreams] (`true`) 停止接收所有远端视频流，
  /// 在调用本 API 之前请确保你已调用 [RtcEngine.muteAllRemoteVideoStreams] (`false`)。
  /// [RtcEngine.muteAllRemoteVideoStreams] 是全局控制，[RtcEngine.muteRemoteVideoStream] 是精细控制。
  ///
  /// **Parameter** [uid] 指定的用户 ID。
  ///
  /// **Parameter** [muted] 是否停止接收指定用户的视频流：
  /// - `true`：停止接收指定用户的视频流。
  /// - `false`：（默认）继续接收指定用户的视频流。
  Future<void> muteRemoteVideoStream(int uid, bool muted);

  /// 停止/恢复接收所有视频流。
  ///
  /// **Parameter** [muted] 是否停止接收所有远端视频流：
  /// - `true`：停止接收所有远端视频流。
  /// - `false`：（默认）继续接收所有远端视频流。
  Future<void> muteAllRemoteVideoStreams(bool muted);

  /// 设置是否默认接收视频流。
  ///
  /// 该方法在加入频道前后都可调用。如果在加入频道后调用 `setDefaultMuteAllRemoteVideoStreams`(true) 会接收不到后面加入频道的用户的音频流。
  ///
  /// **Note**
  ///
  /// 停止接收视频流后，如果想要恢复接收，请调用 [RtcEngine.muteRemoteVideoStream] (`false`)，并指定你想要接收的远端用户的 ID。
  /// 如果想恢复接收多个用户的视频流，则需要多次调用 [RtcEngine.muteRemoteVideoStream]。
  /// `setDefaultMuteAllRemoteVideoStreams(false)` 只能恢复接收设置后加入频道的用户的视频流。
  ///
  /// **Parameter** [muted] 是否默认不接收所有远端视频流：
  /// - `true`：默认不接收所有远端视频流。
  /// - `false`：默认继续接收所有远端视频流（默认）。
  Future<void> setDefaultMuteAllRemoteVideoStreams(bool muted);

  /// 开启本地美颜功能，并设置美颜效果选项。
  ///
  /// **Note**
  /// - 该方法需要在 [RtcEngine.enableVideo] 之后调用。
  /// - 该方法在 Android 和 iOS 均适用。在 Android 平台，该方法仅适用于 Android 4.4 及以上版本。
  ///
  /// **Parameter** [enabled] 是否开启美颜功能：
  ///
  /// - `true`：开启。
  /// - `false`：（默认）关闭。
  ///
  /// **Parameter** [options] 美颜选项。详见 [BeautyOptions]。
  Future<void> setBeautyEffectOptions(bool enabled, BeautyOptions options);
}

mixin RtcAudioMixingInterface {
  /// 开始播放音乐文件及混音。
  ///
  /// 该方法指定本地或在线音频文件来和麦克风采集的音频流进行混音或替换。替换是指用音频文件替换麦克风采集的音频流。
  /// 该方法可以选择是否让对方听到本地播放的音频，并指定循环播放的次数。
  /// 成功调用该方法后，本地会触发 [RtcEngineEventHandler.audioMixingStateChanged] 回调且状态码为 [AudioMixingStateCode.Playing]。
  /// 播放结束后，会收到 [RtcEngineEventHandler.audioMixingStateChanged] 回调且状态码为 [AudioMixingStateCode.Stopped]。
  ///
  /// **Note**
  /// - 该方法在 Android 和 iOS 均可调用。如需在 Android 平台调用该方法，请确保使用 Android 4.2 或以上设备，且 API Level &ge; 16。
  /// - 请在频道内调用该方法，如果在频道外调用该方法可能会出现问题。
  /// - 如果播放的是在线音乐文件，请确保重复调用该 API 的间隔超过 100 ms，否则 SDK 会返回 [AudioMixingErrorCode.TooFrequentCall] = 702 警告码，
  /// 表示音乐文件打开过于频繁。
  /// - 如果播放的是在线音乐文件，Agora 建议不要使用重定向地址。重定向地址在某些机型上可能会出现无法打开的情况。
  /// - 如果本地音乐文件不存在、文件格式不支持、无法访问在线音乐文件 URL 都会返回警告码 [AudioMixingErrorCode.CanNotOpen] = 701。
  /// - 如果在模拟器上使用该 API，暂时只支持存放在 /sdcard/ 中的 mp3 文件。
  ///
  /// **Parameter** [filePath] 指定需要混音的本地或在线音频文件的绝对路径（包含文件名后缀），如 `/sdcard/emulated/0/audio.mp4`。支持的音频格式包括：mp3、mp4、m4a、aac、3gp、mkv 及 wav。
  /// - 如果用户提供的目录以 `/assets/` 开头，则去 assets 里面查找该文件。
  /// - 如果用户提供的目录不是以 `/assets/` 开头，一律认为是在绝对路径里查找该文件。
  ///
  /// **Parameter** [loopback]
  /// - `true`：只有本地可以听到混音或替换后的音频流。
  /// - `false`：本地和对方都可以听到混音或替换后的音频流。
  ///
  /// **Parameter** [replace]
  /// - `true`：只推动设置的本地音频文件或者线上音频文件，不传输麦克风收录的音频。
  /// - `false`：音频文件内容将会和麦克风采集的音频流进行混音。
  ///
  /// **Parameter** [cycle] 音频文件循环播放的次数：
  /// - 正整数：循环的次数。
  /// - -1：无限循环。
  Future<void> startAudioMixing(
      String filePath, bool loopback, bool replace, int cycle);

  /// 停止播放音乐文件及混音。
  ///
  /// 该方法停止播放伴奏。请在频道内调用该方法。
  Future<void> stopAudioMixing();

  /// 暂停播放音乐文件及混音。
  ///
  /// 该方法暂停播放伴奏。请在频道内调用该方法。
  Future<void> pauseAudioMixing();

  /// 恢复播放音乐文件及混音。
  ///
  /// 该方法恢复混音，继续播放伴奏。请在频道内调用该方法。
  Future<void> resumeAudioMixing();

  /// 调节音乐文件的播放音量。
  ///
  /// **Note**
  /// - 该方法调节混音里伴奏在本端和远端播放的音量大小。请在频道内调用该方法。
  /// - 调用该方法不影响调用 [RtcEngine.playEffect] 播放音效文件的音量。
  ///
  /// **Parameter** [volume] 伴奏音量范围为 [0,100]。默认 100 为原始文件音量。
  Future<void> adjustAudioMixingVolume(int volume);

  /// 调节音乐文件的本地播放音量。
  ///
  /// 该方法调节混音里音乐文件在本端播放的音量大小。请在频道内调用该方法。
  ///
  /// **Parameter** [volume] 伴奏音量范围为 [0,100]。默认 100 为原始文件音量。
  Future<void> adjustAudioMixingPlayoutVolume(int volume);

  /// 调节音乐文件的远端播放音量。
  ///
  /// 该方法调节混音里音乐文件在远端播放的音量大小。请在频道内调用该方法。
  ///
  /// **Parameter** [volume] 伴奏音量范围为 [0,100]。默认 100 为原始文件音量。
  Future<void> adjustAudioMixingPublishVolume(int volume);

  /// 获取音乐文件的本地播放音量。
  ///
  /// 该方法获取音乐文件的本地播放音量。该接口可以方便开发者排查音量相关问题。
  Future<int> getAudioMixingPlayoutVolume();

  /// 获取音乐文件的远端播放音量。
  ///
  /// 该方法获取音乐文件的远端播放音量。该接口可以方便开发者排查音量相关问题。
  Future<int> getAudioMixingPublishVolume();

  /// 获取音乐文件的时长。
  ///
  /// 该方法获取音乐文件时长，单位为毫秒。请在频道内调用该方法。
  ///
  /// **Returns**
  /// - 方法调用成功并返回音乐文件的时长。
  /// - < 0：方法调用失败。
  Future<int> getAudioMixingDuration();

  /// 获取音乐文件的播放进度。
  ///
  /// 该方法获取当前伴奏播放进度，单位为毫秒。请在频道内调用该方法。
  ///
  /// **Returns**
  /// - 方法调用成功并返回伴奏播放进度。
  /// - < 0：方法调用失败。
  Future<int> getAudioMixingCurrentPosition();

  /// 设置音乐文件的播放位置。
  ///
  /// **Parameter** [pos] 整数。进度条位置，单位为毫秒。
  Future<void> setAudioMixingPosition(int pos);

  /// 调整本地播放的音乐文件的音调。
  ///
  /// 本地人声和播放的音乐文件混音时，调用该方法可以仅调节音乐文件的音调。
  ///
  /// **Note**
  /// 该方法需在 [RtcEngine.startAudioMixing] 后调用。
  ///
  /// **Parameter** [pitch] 按半音音阶调整本地播放的音乐文件的音调，默认值为 0，即不调整音调。
  /// 取值范围为 [-12,12]，每相邻两个值的音高距离相差半音。取值的绝对值越大，音调升高或降低得越多。
  Future<void> setAudioMixingPitch(int pitch);
}

mixin RtcAudioEffectInterface {
  /// 获取所有音效文件播放音量, 范围为 [0.0,100.0]。
  ///
  /// **Returns**
  /// - 方法调用成功返回音效的音量值。
  /// - < 0: 方法调用失败。
  Future<double> getEffectsVolume();

  /// 设置所有音效文件的播放音量。
  ///
  /// **Parameter** [volume] 所有音效文件的播放音量，取值范围为 [0.0,100.0]。 100.0 为默认值。
  Future<void> setEffectsVolume(double volume);

  /// 设置指定音效文件的播放音量。
  ///
  /// **Parameter** [soundId] 指定音效的 ID。每个音效均有唯一的 ID。
  ///
  /// **Parameter** [volume] 指定音效文件的播放音量，取值范围为 [0.0,100.0]。 100.0 为默认值。
  Future<void> setVolumeOfEffect(int soundId, double volume);

  /// 播放指定音效文件。
  /// 该方法播放指定的本地或在线音效文件。你可以在该方法中设置音效文件的播放次数、音调、音效的空间位置和增益，以及远端用户是否能听到该音效。
  ///
  /// 你可以多次调用该方法，通过传入不同的音效文件的 `soundId` 和 `filePath`，同时播放多个音效文件，实现音效叠加。
  /// 为获得最佳用户体验，我们建议同时播放的音效文件不要超过 3 个。
  ///
  /// 调用该方法播放音效结束后，SDK 会触发 [RtcEngineEventHandler.audioEffectFinished] 回调。
  ///
  /// **Parameter** [soundId] 音效的 ID。每个音效均有唯一的 ID。如果你已通过 [RtcEngine.preloadEffect] 将音效加载至内存，
  /// 确保这里的 `soundID` 与 [RtcEngine.preloadEffect] 设置的 `soundId` 相同。
  ///
  /// **Parameter** [filePath] 待播放的音效文件的绝对路径或 URL 地址。如 `/sdcard/emulated/0/audio.mp4`。建议填写文件后缀名。
  /// 若无法确定文件后缀名，可不填。支持的音频格式包括：mp3、mp4、m4a、aac、3gp、mkv 及 wav。
  ///
  /// **Parameter** [loopCount] 音效文件循环播放的次数：
  /// - 0：播放音效文件一次。
  /// - 1：播放音效文件两次。
  /// - -1：无限循环播放音效文件，直至调用 [RtcEngine.stopEffect] 或 [RtcEngine.stopAllEffects] 后停止。
  ///
  /// **Parameter** [pitch] 音效的音调。取值范围为 [0.5,2.0]。默认值为 1.0，代表原始音调。取值越小，则音调越低。
  ///
  /// **Parameter** [pan] 音效的空间位置。取值范围为 [-1.0,1.0]：
  /// - -1.0：音效出现在左边。
  /// - 0：音效出现在正前边。
  /// - 1.0：音效出现在右边。
  ///
  /// **Parameter** [gain] 音效的音量。取值范围为 [0.0,100.0]。100.0 为默认值，代表原始音量。取值越小，则音量越低。
  ///
  /// **Parameter** [publish] 是否将音效发布到远端：
  ///
  /// - `true`：音效文件在本地播放的同时，会发布到 Agora 云上，因此远端用户也能听到该音效。
  /// - `false`：音效文件不会发布到 Agora 云上，因此只能在本地听到该音效。
  ///
  Future<void> playEffect(int soundId, String filePath, int loopCount,
      double pitch, double pan, double gain, bool publish);

  /// 停止播放指定音效文件。
  ///
  /// **Note**
  ///
  /// 如果你已通过 [RtcEngine.preloadEffect] 将音效加载至内存，确保这里的 `soundID` 与 [RtcEngine.preloadEffect] 设置的 `soundID` 相同
  ///
  /// **Parameter** [soundId] 音效文件的 ID。每个音效均有唯一的 ID。
  Future<void> stopEffect(int soundId);

  /// 停止播放所有音效文件。
  Future<void> stopAllEffects();

  /// 将音效文件预加载至内存。
  ///
  /// 支持音频格式为 mp3、mp4、m4a、aac、3gp、mkv 和 wav。
  ///
  /// **Note**
  ///
  /// - 该方法不支持预加载在线音效文件。
  /// - 为保证通话流畅度，请注意控制音效文件的大小。Agora 推荐你在加入频道前调用该方法。
  ///
  /// **Parameter** [soundId] 音效文件的 ID。
  ///
  /// **Parameter** [filePath] 音效文件的绝对路径。
  Future<void> preloadEffect(int soundId, String filePath);

  /// 从内存释放指定的预加载音效文件。
  ///
  /// **Parameter** [soundId] 音效文件的 ID。每个音效均有唯一的 ID。
  Future<void> unloadEffect(int soundId);

  /// 暂停播放指定音效文件。
  ///
  /// **Parameter** [soundId] 指定音效的 ID。每个音效均有唯一的 ID。
  Future<void> pauseEffect(int soundId);

  /// 暂停播放所有音效文件。
  Future<void> pauseAllEffects();

  /// 恢复播放指定音效文件。
  ///
  /// **Parameter** [soundId] 指定音效的 ID。每个音效均有唯一的 ID。
  Future<void> resumeEffect(int soundId);

  /// 恢复播放所有音效文件。
  Future<void> resumeAllEffects();

  /// 设置 SDK 对 Audio Session 的控制权限
  ///
  /// 该方法限制 Agora SDK 对 Audio Session 的操作权限。在默认情况下，SDK 和 App 对 Audio Session 都有控制权，但某些场景下，App 会希望限制 Agora SDK 对 Audio Session 的控制权限，而使用其他应用或第三方组件对 Audio Session 进行操控。调用该方法可以实现该功能。
  ///
  /// 该接口可以在任意时候调用，可以在任意时候通过该方法把控制权交还给 SDK。
  ///
  /// **Note**
  /// - 一旦调用该方法限制了 Agora SDK 对 Audio Session 的控制权限， SDK 将无法对 Audio Session 进行相关设置，而需要用户自己或第三方组件进行维护。
  ///
  /// **Parameter** [restriction] Agora SDK 对 Audio Session 的控制权限，详见 [AudioSessionOperationRestriction].
  Future<void> setAudioSessionOperationRestriction(
      AudioSessionOperationRestriction restriction);
}

mixin RtcVoiceChangerInterface {
  /// 设置本地语音变声、美音或语聊美声效果。
  ///
  /// **Note**
  ///
  /// 该方法不能与 [RtcEngine.setLocalVoiceReverbPreset] 方法一同使用，否则先调的方法会不生效。
  ///
  /// **Parameter** [voiceChanger] 本地语音的变声、美音或语聊美声效果选项。详见 [AudioVoiceChanger]。
  Future<void> setLocalVoiceChanger(AudioVoiceChanger voiceChanger);

  /// 设置本地语音混响（含虚拟立体声效果）。
  ///
  /// **Note**
  /// - 该方法不能与 [RtcEngine.setLocalVoiceReverb] 方法一同使用。
  /// - 该方法不能与 [RtcEngine.setLocalVoiceChanger] 方法一同使用，否则先调的方法会不生效。
  ///
  /// **Parameter** [preset] 本地语音混响选项。详见 [AudioReverbPreset]。
  Future<void> setLocalVoiceReverbPreset(AudioReverbPreset preset);

  /// 设置本地语音音调。
  /// 该方法改变本地说话人声音的音调。
  ///
  /// **Parameter** [pitch] 语音频率。可以在 [0.5,2.0] 范围内设置。取值越小，则音调越低。默认值为 1.0，表示不需要修改音调。
  Future<void> setLocalVoicePitch(double pitch);

  /// 设置本地语音音效均衡。
  ///
  /// **Parameter** [bandFrequency] 频谱子带索引，取值范围是 [0,9]，分别代表 10 个频带，对应的中心频率是 [31，62，125，250，500，1k，2k，4k，8k，16k] Hz。
  /// 详见 [AudioEqualizationBandFrequency]。
  ///
  /// **Parameter** [bandGain] 每个 band 的增益，单位是 dB，每一个值的范围是 [-15,15]，默认值为 0。
  Future<void> setLocalVoiceEqualization(
      AudioEqualizationBandFrequency bandFrequency, int bandGain);

  /// 设置本地音效混响。
  ///
  /// **Note**
  /// - Agora SDK 提供更为简便的接口 [RtcEngine.setLocalVoiceReverbPreset]。 该方法通过一系列内置参数的调整，直接实现流行、R&B、摇滚、嘻哈等预置的混响效果。
  ///
  /// **Parameter** [reverbKey] 混响音效 Key。参考 [AudioReverbType]。
  ///
  /// **Parameter** [value] 各混响音效 Key 所对应的值。
  Future<void> setLocalVoiceReverb(AudioReverbType reverbKey, int value);

  /// 设置 SDK 预设的人声音效。
  ///
  /// 自从 v3.2.0
  ///
  /// 调用该方法可以为本地发流用户设置 SDK 预设的人声音效，且不会改变原声的性别特征。设置音效后，频道内所有用户都能听到该效果。
  ///
  /// 根据不同的场景，你可以为用户设置不同的音效，各音效的适用场景可参考《美声与音效》。
  ///
  /// 为获取更好的人声效果，Agora 推荐你在调用该方法前将 [RtcEngine.setAudioProfile] 的 `scenario` 设为 `GameStreaming(3)`。
  ///
  ///**Note**
  /// - 该方法在加入频道前后都能调用。
  /// - 请勿将 `setAudioProfile` 的 `profile` 参数设置为 `SpeechStandard(1)`，否则该方法会调用失败。
  /// - 该方法对人声的处理效果最佳，Agora 不推荐调用该方法处理含音乐的音频数据。
  /// - 如果调用该方法并设置除 `RoomAcoustics3DVoice` 或 `PitchCorrection` 外的枚举，请勿再调用 `setAudioEffectParameters`，否则该方法设置的效果会被覆盖。
  /// - 调用该方法后，Agora 不推荐调用以下方法，否则该方法设置的效果会被覆盖:
  ///     - `setVoiceBeautifierPreset`
  ///     - `setLocalVoiceReverbPreset`
  ///     - `setLocalVoiceChanger`
  ///     - `setLocalVoicePitch`
  ///     - `setLocalVoiceEqualization`
  ///     - `setLocalVoiceReverb`
  ///
  /// **Parameter** [preset] 预设的音效选项: [AudioEffectPreset]。
  Future<void> setAudioEffectPreset(AudioEffectPreset preset);

  /// 设置 SDK 预设的美声效果。
  ///
  /// 自从 v3.2.0
  ///
  /// 调用该方法可以为本地发流用户设置 SDK 预设的人声美化效果。设置美声效果后，频道内所有用户都能听到该效果。根据不同的场景，你可以为用户设置不同的美声效果， 各美声效果的适用场景可参考《美声与音效》。
  ///
  /// 为获取更好的人声效果，Agora 推荐你在调用该方法前将 setAudioProfile 的 scenario 设为 AgoraAudioScenarioGameStreaming(3)，并将 profile 设为 AgoraAudioProfileMusicHighQuality(4) 或 AgoraAudioProfileMusicHighQualityStereo(5)。
  ///
  /// **Note**
  /// - 该方法在加入频道前后都能调用。
  /// - 请勿将 `setAudioProfile` 的 `profile` 参数设置为 `SpeechStandard(1)`，否则该方法会调用失败。
  /// - 该方法对人声的处理效果最佳，Agora 不推荐调用该方法处理含音乐的音频数据。
  /// - 调用该方法后，Agora 不推荐调用以下方法，否则该方法设置的效果会被覆盖：
  ///   - `setAudioEffectPreset`
  ///   - `setAudioEffectParameters`
  ///   - `setLocalVoiceReverbPreset`
  ///   - `setLocalVoiceChanger`
  ///   - `setLocalVoicePitch`
  ///   - `setLocalVoiceEqualization`
  ///   - `setLocalVoiceReverb`
  ///
  /// **Parameter** [preset] 预设的美声效果选项：[VoiceBeautifierPreset]。
  Future<void> setVoiceBeautifierPreset(VoiceBeautifierPreset preset);

  /// 设置 SDK 预设人声音效的参数。
  ///
  /// 调用该方法可以对本地发流用户进行如下设置：
  /// - 3D 人声音效：设置 3D 人声音效的环绕周期。
  /// - 电音音效：设置电音音效的基础调式和主音音高。为方便用户自行调节电音音效，Agora 推荐你将基础调式和主音音高配置选项与应用的 UI 元素绑定。
  ///
  /// 设置后，频道内所有用户都能听到该效果。
  ///
  /// 该方法可以单独使用，也可以搭配 [RtcEngine.setAudioEffectPreset] 使用。搭配使用时，需要先调用 `setAudioEffectPreset` 并使用 `RoomAcoustics3DVoice` 或 `PitchCorrection` 枚举，再调用该方法使用相同的枚举。否则， 该方法设置的效果会覆盖 `setAudioEffectPreset` 设置的效果。
  ///
  /// **Note**
  /// - 该方法在加入频道前后都能调用。
  /// - 为获取更好的人声效果，Agora 推荐你在调用该方法前将 `setAudioProfile` 的 `scenario` 设为 `GameStreaming(3)`。
  /// - 请勿将 `setAudioProfile` 的 `profile` 参数设置为 `SpeechStandard(1)`，否则该方法会调用失败。
  /// - 该方法对人声的处理效果最佳，Agora 不推荐调用该方法处理含音乐的音频数据。
  /// - 调用该方法后，Agora 不推荐调用以下方法，否则该方法设置的效果会被覆盖：
  ///   - `setAudioEffectPreset`
  ///   - `setVoiceBeautifierPreset`
  ///   - `setLocalVoiceReverbPreset`
  ///   - `setLocalVoiceChanger`
  ///   - `setLocalVoicePitch`
  ///   - `setLocalVoiceEqualization`
  ///   - `setLocalVoiceReverb`
  ///
  /// **Parameter** [preset] SDK 预设的音效：
  /// - 3D 人声音效: `RoomAcoustics3DVoice`
  ///   - 你需要在使用该枚举前将 `setAudioProfile` 的 `profile` 参数设置为 `MusicStandardStereo(3)` 或 `MusicHighQualityStereo(5)`，否则该枚举设置无效。
  ///   - 启用 3D 人声后，用户需要使用支持双声道的音频播放设备才能听到预期效果。
  /// - 电音音效 `PitchCorrection`。为获取更好的人声效果，Agora 建议你在使用该枚举前将 `setAudioProfile` 的 `profile` 参数设置为 `MusicHighQuality(4)` 或 `MusicHighQualityStereo(5)`。
  ///
  /// **Parameter** [param1]
  /// - 如果 `preset` 设为 `RoomAcoustics3DVoice`，则 `param1` 表示 3D 人声音效的环绕周期。取值范围为 [1,60]， 单位为秒。默认值为 10，表示人声会 10 秒环绕 360 度。
  /// - 如果 `preset` 设为 `PitchCorrection`，则 `param1` 表示电音音效的基础调式。可设为如下值：
  ///   - 1: （默认）自然大调。
  ///   - 2:  自然小调。
  ///   - 3: 和风小调。
  ///
  /// **Parameter** [param2]
  /// - 如果 `preset` 设为 `RoomAcoustics3DVoice`，你需要将 `param2` 设为 0。
  /// - 如果 `preset` 设为 `PitchCorrection`，则 `param2` 表示电音音效的主音音高。可设为如下值：
  ///   - 1: A 调
  ///   - 2: A# 调
  ///   - 3: B 调
  ///   - 4: (默认) C 调
  ///   - 5: C# 调
  ///   - 6: D 调
  ///   - 7: D# 调
  ///   - 8: E 调
  ///   - 9: F 调
  ///   - 10: F# 调
  ///   - 11: G 调
  ///   - 12: G# 调
  Future<void> setAudioEffectParameters(
      AudioEffectPreset preset, int param1, int param2);
}


mixin RtcVoicePositionInterface {
  /// 开启/关闭远端用户的语音立体声。
  ///
  /// 如果想调用 [RtcEngine.setRemoteVoicePosition] 实现听声辨位的功能，请确保在调用 [RtcEngine.joinChannel]方法前调用该方法。
  ///
  ///
  /// **Parameter** [enabled] 是否开启远端用户语音立体声：
  /// - `true`：开启。
  /// - `false`：（默认）关闭。
  Future<void> enableSoundPositionIndication(bool enabled);

  /// 设置远端用户声音的空间位置和音量，方便本地用户听声辨位。
  ///
  /// 用户通过调用该接口，设置远端用户声音出现的位置，左右声道的声音差异会让用户产生声音的方位感，
  /// 从而判断出远端用户的实时位置。在多人在线游戏场景，如吃鸡游戏中，该方法能有效增加游戏角色的方位感，模拟真实场景。
  ///
  /// **Note**
  /// - 使用该方法需要在加入频道前调用 [RtcEngine.enableSoundPositionIndication] 开启远端用户的语音立体声。
  /// - 为获得最佳听觉体验，我们建议用户佩戴耳机。
  ///
  /// **Parameter** [uid] 远端用户的 ID。
  ///
  /// **Parameter** [pan] 设置远端用户声音出现的位置，取值范围为 [-1.0,1.0]：
  /// - 0.0：（默认）声音出现在正前方。
  /// - -1.0：声音出现在左边。
  /// - 1.0：声音出现在右边
  ///
  /// **Parameter** [gain] 设置远端用户声音的音量，取值范围为 [0.0,100.0]，默认值为 100.0，表示该用户的原始音量。取值越小，则音量越低。
  Future<void> setRemoteVoicePosition(int uid, double pan, double gain);
}

mixin RtcPublishStreamInterface {
  /// 设置直播转码。
  ///
  /// 该方法用于旁路推流的视图布局及音频设置等。调用该方法更新转码参数 `LiveTranscoding` 时，SDK 会触发 [RtcEngineEventHandler.transcodingUpdated] 回调。
  /// 首次调用该方法设置转码参数时，不会触发 [RtcEngineEventHandler.transcodingUpdated] 回调。
  ///
  /// **Note**
  /// - 请确保已开通旁路推流的功能，详见进阶功能《推流到 CDN》中的前提条件。
  /// - 该方法仅适用于直播场景下的主播用户。
  /// - 请确保先调用过该方法，再调用 [RtcEngine.addPublishStreamUrl]。
  ///
  /// **Parameter** [transcoding] 旁路推流布局相关设置。详见 [LiveTranscoding]。
  Future<void> setLiveTranscoding(LiveTranscoding transcoding);

  /// 增加旁路推流地址。
  ///
  /// 调用该方法后，SDK 会在本地触发 [RtcEngineEventHandler.rtmpStreamingStateChanged] 回调，
  /// 报告增加旁路推流地址的状态。
  ///
  /// **Note**
  /// - 调用该方法前，请确保已开通旁路推流的功能，详见进阶功能《推流到 CDN》中的前提条件。
  /// - 该方法仅适用直播场景。
  /// - 请确保在成功加入频道后才能调用该接口。
  /// - 该方法每次只能增加一路旁路推流地址。如需推送多路流，则需多次调用该方法。
  ///
  /// **Parameter** [url] CDN 推流地址，格式为 RTMP。该字符长度不能超过 1024 字节。url 不支持中文等特殊字符。
  ///
  /// **Parameter** [transcodingEnabled] 是否转码。如果设为 `true`，则需要在该方法前先调用 [RtcEngine.setLiveTranscoding] 方法。
  /// - `true`：转码。[转码](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#转码)是指在旁路推流时对音视频流进行转码处理后，再推送到其他 RTMP 服务器。多适用于频道内有多个主播，需要进行混流、合图的场景。
  /// - `false`：不转码。
  Future<void> addPublishStreamUrl(String url, bool transcodingEnabled);

  /// 删除旁路推流地址。
  /// 调用该方法后，SDK 会在本地触发 [RtcEngineEventHandler.rtmpStreamingStateChanged] 回调，
  /// 报告删除旁路推流地址的状态。
  ///
  /// **Note**
  /// - 调用该方法前，请确保已开通旁路推流的功能，详见进阶功能《推流到 CDN》中的前提条件。
  /// - 该方法只适用于直播场景。
  /// - 该方法每次只能删除一路旁路推流地址。如需删除多路流，则需多次调用该方法。
  ///
  /// **Parameter** [url] 待删除的推流地址，格式为 RTMP。该字符长度不能超过 1024 字节。推流地址不支持中文等特殊字符。
  Future<void> removePublishStreamUrl(String url);
}

mixin RtcMediaRelayInterface {
  /// 开始跨频道媒体流转发。
  ///
  /// 该方法可用于实现跨频道媒体流转发。
  ///
  /// 成功调用该方法后，SDK 会触发 [RtcEngineEventHandler.channelMediaRelayStateChanged]
  /// 和 [RtcEngineEventHandler.channelMediaRelayEvent] 回调，
  /// 并在回调中报告当前的跨频道媒体流转发状态和事件。
  ///
  /// - 如果 [RtcEngineEventHandler.channelMediaRelayStateChanged] 回调报告 [ChannelMediaRelayState.Running] 和 [ChannelMediaRelayError.None]
  /// 且 [RtcEngineEventHandler.channelMediaRelayEvent] 回调报告 [ChannelMediaRelayEvent.SentToDestinationChannel]，
  /// 则表示 SDK 开始在源频道和目标频道之间转发媒体流。
  /// - 如果 [RtcEngineEventHandler.channelMediaRelayStateChanged] 回调报告 [ChannelMediaRelayState.Failure]，则表示跨频道媒体流转发出现异常。
  ///
  /// **Note**
  /// - 跨频道媒体流转发功能需要联系 sales@agora.io 开通。
  /// - 该功能不支持 String 型 UID。
  /// - 请在成功加入频道后调用该方法。
  /// - 该方法仅适用于直播场景下的主播。
  /// - 成功调用该方法后，若你想再次调用该方法，必须先调用 [RtcEngine.stopChannelMediaRelay] 方法退出当前的转发状态。
  ///
  /// **Parameter** [channelMediaRelayConfiguration] 跨频道媒体流转发参数配置。
  Future<void> startChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration);

  /// 更新媒体流转发的频道。
  ///
  /// 成功开始跨频道转发媒体流后，如果你希望将流转发到多个目标频道，或退出当前的转发频道，可以调用该方法。
  ///
  /// 成功调用该方法后，SDK 会触发 [RtcEngineEventHandler.channelMediaRelayEvent] 回调，
  /// 并在回调中报告状态码 [ChannelMediaRelayEvent.UpdateDestinationChannel]。
  ///
  /// **Note**
  /// - 请在 [RtcEngine.startChannelMediaRelay] 方法后调用该方法，更新媒体流转发的频道。
  /// - 跨频道媒体流转发最多支持 4 个目标频道。如果直播间里已经有 4 个频道了，你可以在调用该方法之前，
  /// 调用 [ChannelMediaRelayConfiguration] 类中的 `destInfos` 方法移除不需要的频道。
  ///
  /// **Parameter** [channelMediaRelayConfiguration] 跨频道媒体流转发参数配置。详见 [ChannelMediaRelayConfiguration]。
  Future<void> updateChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration);

  /// 停止跨频道媒体流转发。
  ///
  /// 一旦停止，主播会退出所有目标频道。
  ///
  /// 成功调用该方法后，SDK 会触发 [RtcEngineEventHandler.channelMediaRelayStateChanged] 回调。
  /// 如果报告 [ChannelMediaRelayState.Idle] 和 [ChannelMediaRelayError.None]，则表示已停止转发媒体流。
  ///
  /// **Note**
  ///
  /// 如果该方法调用不成功，SDK 会触发 [RtcEngineEventHandler.channelMediaRelayStateChanged] 回调，
  /// 并报告状态码 [ChannelMediaRelayError.ServerNoResponse] 或 [ChannelMediaRelayError.ServerConnectionLost]。
  /// 你可以调用 [RtcEngine.leaveChannel] 方法离开频道，跨频道媒体流转发会自动停止。
  Future<void> stopChannelMediaRelay();
}

mixin RtcAudioRouteInterface {
  /// 设置默认的音频播放路由。
  ///
  /// 该方法设置接收到的语音从听筒或扬声器出声。如果用户不调用本方法，则语音默认从听筒出声。
  /// 如果你想要在加入频道后修改语音路由，可以使用 [RtcEngine.setEnableSpeakerphone]。
  ///
  /// 各场景下默认的语音路由：
  /// - 通信场景：
  ///   - 语音通话，默认从听筒出声。
  ///   - 视频通话，默认从扬声器出声。如果有用户在频道中使用 [RtcEngine.disableVideo] 或 [RtcEngine.muteLocalVideoStream] 和 [RtcEngine.muteAllRemoteVideoStreams] 关闭视频，则语音路由会自动切换回听筒。
  /// - 直播场景：扬声器。
  ///
  /// **Note**
  /// - 该方法仅适用于通信场景。
  /// - 该方法需要在加入频道前设置，否则不生效。
  ///
  /// **Parameter** [defaultToSpeaker] 设置默认的音频播放路由：
  /// - `true`：默认从外放（扬声器）出声。如果设备连接了耳机或蓝牙，则无法切换到外放。
  /// - `false`：（默认）默认从听筒出声。如果设备连接了耳机，则语音路由走耳机。
  Future<void> setDefaultAudioRoutetoSpeakerphone(bool defaultToSpeaker);

  /// 启用/关闭扬声器播放。
  ///
  /// 该方法设置是否将语音路由设到扬声器（外放）。
  /// 调用该方法后，SDK 将返回 [RtcEngineEventHandler.audioRouteChanged] 回调提示状态已更改。
  ///
  /// **Note**
  /// - 请确保在调用此方法前已调用过 [RtcEngine.joinChannel] 方法。
  /// - 直播频道内的观众调用该 API 无效。
  ///
  /// **Parameter** [enabled] 是否将音频路由到外放：
  /// - `true`：切换到外放。
  /// - `false`：切换到听筒。如果设备连接了耳机，则语音路由走耳机。
  Future<void> setEnableSpeakerphone(bool enabled);

  /// 检查扬声器状态启用状态。
  ///
  /// **Returns**
  /// - `true`：扬声器已开启，语音会输出到扬声器。
  /// - `false`：扬声器未开启，语音会输出到非扬声器（听筒，耳机等）。
  Future<bool> isSpeakerphoneEnabled();
}

mixin RtcEarMonitoringInterface {
  /// 开启耳返功能。
  ///
  /// **Parameter** [enabled] 是否开启耳返功能：
  /// - `true`：开启耳返功能。
  /// - `false`：（默认）关闭耳返功能。
  Future<void> enableInEarMonitoring(bool enabled);

  /// 设置耳返音量。
  ///
  /// **Parameter** [volume] 设置耳返音量，取值范围在 0 到 100 间。默认值为 100。
  Future<void> setInEarMonitoringVolume(int volume);
}

mixin RtcDualStreamInterface {
  /// 开/关视频双流模式。
  ///
  /// 该方法设置单流或者双流模式。发送端开启双流模式后，接收端可以选择接收大流还是小流。其中，大流指高分辨率、高码率的视频流，
  /// 小流指低分辨率、低码率的视频流。
  ///
  /// **Parameter** [enabled] 指定双流或者单流模式：
  /// - `true`：双流。
  /// - `false`：（默认）单流。
  Future<void> enableDualStreamMode(bool enabled);

  /// 设置订阅的视频流类型。
  ///
  /// 在网络条件受限的情况下，如果发送端没有调用 [RtcEngine.enableDualStreamMode] (`false`) 关闭双流模式，
  /// 接收端可以选择接收大流还是小流。其中，大流可以接为高分辨率高码率的视频流，
  /// 小流则是低分辨率低码率的视频流。
  ///
  /// 正常情况下，用户默认接收大流。如需节约带宽和计算资源，则可以调用该方法动态调整对应远端视频流的大小。
  /// SDK 会根据该方法中的设置，切换大小流。
  ///
  /// 视频小流默认的宽高比和视频大流的宽高比一致。根据当前大流的宽高比，系统会自动分配小流的分辨率、帧率及码率。
  ///
  /// 调用本方法的执行结果将在 [RtcEngineEventHandler.apiCallExecuted] 中返回。
  ///
  /// **Parameter** [uid] 用户 ID。
  ///
  /// **Parameter** [streamType] 视频流类型。详见 [VideoStreamType]。
  Future<void> setRemoteVideoStreamType(int uid, VideoStreamType streamType);

  /// 设置默认订阅的视频流类型。
  ///
  /// **Parameter** [streamType] 视频流类型。详见 [VideoStreamType]。
  Future<void> setRemoteDefaultVideoStreamType(VideoStreamType streamType);
}

mixin RtcFallbackInterface {
  /// 设置弱网条件下发布的音视频流回退选项。
  ///
  /// 网络不理想的环境下，直播音视频的质量都会下降。使用该接口并将 option 设置为 [StreamFallbackOptions.AudioOnly] 后，
  /// SDK 会在上行弱网且音视频质量严重受影响时，自动关断视频流，从而保证或提高音频质量。
  /// 同时 SDK 会持续监控网络质量，并在网络质量改善时恢复音视频流。当本地推流回退为音频流时，或由音频流恢复为音视频流时，
  /// SDK 会触发本地发布的媒体流已回退为音频流 [RtcEngineEventHandler.localPublishFallbackToAudioOnly] 回调。
  ///
  /// **Note**
  ///
  /// 旁路推流场景下，设置本地推流回退为 [StreamFallbackOptions.AudioOnly] 可能会导致远端的 CDN 用户听到声音的时间有所延迟。
  /// 因此在有旁路推流的场景下，Agora 建议不开启该功能。
  ///
  /// **Parameter** [option] 本地推流回退处理选项。详见 [StreamFallbackOptions]。
  ///
  Future<void> setLocalPublishFallbackOption(StreamFallbackOptions option);

  /// 设置弱网条件下订阅的音视频流回退选项。
  ///
  /// 网络不理想的环境下，直播音视频的质量都会下降。使用该接口并将 `option` 设置
  /// 为 [StreamFallbackOptions.VideoStreamLow] 或者 [StreamFallbackOptions.AudioOnly] 后，
  /// SDK 会在下行弱网且音视频质量严重受影响时，
  /// 将视频流切换为小流，或关断视频流，从而保证或提高音频质量。同时 SDK 会持续监控网络质量，并在网络质量改善时恢复音视频流。
  /// 当远端订阅流回退为音频流时，或由音频流恢复为音视频流时，SDK 会触发远端订阅流已回退为
  /// 音频流 [RtcEngineEventHandler.remoteSubscribeFallbackToAudioOnly] 回调。
  ///
  /// **Parameter** [option] 远端订阅流回退处理选项。详见 [StreamFallbackOptions]。
  Future<void> setRemoteSubscribeFallbackOption(StreamFallbackOptions option);

  /// 设置用户媒体流优先级。
  ///
  /// 如果将某个用户的优先级设为高，那么发给这个用户的音视频流的优先级就会高于其他用户。
  /// 该方法可以与 [RtcEngine.setRemoteSubscribeFallbackOption] 搭配使用。如果开启了订阅流回退选项，弱网下 SDK 会优先保证高优先级用户收到的流的质量。
  ///
  /// **Note**
  ///
  /// 目前 Agora SDK 仅允许将一名远端用户设为高优先级。
  ///
  /// **Parameter** [uid] 远端用户的 ID。
  ///
  /// **Parameter** [userPriority] 远端用户的优先级。详见 [UserPriority]。
  Future<void> setRemoteUserPriority(int uid, UserPriority userPriority);
}

mixin RtcTestInterface {
  /// 开始语音通话回路测试。
  ///
  /// 方法启动语音通话测试，目的是测试系统的音频设备（耳麦、扬声器等）和网络连接是否正常。
  /// 在测试过程中，用户先说一段话，声音会在设置的时间间隔（单位为秒）后回放出来。
  /// 如果用户能正常听到自己刚才说的话，就表示系统音频设备和网络连接都是正常的。
  ///
  /// **Note**
  /// - 请在加入频道前调用该方法。
  /// - 调用 [RtcEngine.startEchoTest] 后必须调用 [RtcEngine.stopEchoTest] 以结束测试，
  /// 否则不能进行下一次回声测试，也无法调用 [RtcEngine.joinChannel] 加入频道。
  /// - 直播场景下，该方法仅能由用户角色为主播的用户调用。
  ///
  /// **Parameter** [intervalInSeconds] 设置返回语音通话回路测试结果的时间间隔，取值范围为 [2,10]，单位为秒，默认为 10 秒。
  Future<void> startEchoTest(int intervalInSeconds);

  /// 停止语音通话回路测试。
  Future<void> stopEchoTest();

  /// 启用网络测试。
  ///
  /// 该方法启用网络连接质量测试，用于检测用户网络接入质量。默认该功能为关闭状态。该方法主要用于以下两种场景：
  /// - 用户加入频道前，可以调用该方法判断和预测目前的上行网络质量是否足够好。
  /// - 直播场景下，当用户角色想由观众切换为主播时，可以调用该方法判断和预测目前的上行网络质量是否足够好。
  /// 无论哪种场景，启用该方法会消耗一定的网络流量，影响通话质量。在收到 [RtcEngineEventHandler.lastmileQuality] 回调后
  /// 须调用 [RtcEngine.disableLastmileTest] 停止测试，再加入频道或切换用户角色。
  ///
  /// **Note**
  ///
  /// 该方法请勿与 [RtcEngine.startLastmileProbeTest] 同时使用。
  ///  - 调用该方法后，在收到 [RtcEngineEventHandler.lastmileQuality]  回调之前请不要调用其他方法，
  /// 否则可能会由于 API 操作过于频繁导致此回调无法执行。
  ///  - 直播场景下，主播在加入频道后，请勿调用该方法。
  ///  - 加入频道前调用该方法检测网络质量后，SDK 会占用一路视频的带宽，码率
  /// 与 [RtcEngine.setVideoEncoderConfiguration] 中设置的码率相同。加入频道后，无论是否调用了 [RtcEngine.disableLastmileTest]，SDK 均会自动停止带宽占用。
  Future<void> enableLastmileTest();

  /// 关闭网络测试。
  Future<void> disableLastmileTest();

  /// 开始通话前网络质量探测，向用户反馈上下行网络的带宽、丢包、网络抖动和往返时延数据。
  ///
  /// 启用该方法后，SDK 会依次返回如下 2 个回调：
  /// - [RtcEngineEventHandler.lastmileQuality]：视网络情况约 2 秒内返回。
  /// 该回调通过打分反馈上下行网络质量，更贴近用户的主观感受。
  /// - [RtcEngineEventHandler.lastmileProbeResult]：视网络情况约 30 秒内返回。
  /// 该回调通过客观数据反馈上下行网络质量，因此更客观。
  ///
  /// 该方法主要用于以下两种场景：
  /// - 用户加入频道前，可以调用该方法判断和预测目前的上行网络质量是否足够好。
  /// - 直播场景下，当用户角色想由观众切换为主播时，可以调用该方法判断和预测目前的上行网络质量是否足够好。
  ///
  /// **Note**
  /// - 该方法会消耗一定的网络流量，影响通话质量，因此我们建议不要同时使用该方法和 [RtcEngine.enableLastmileTest]。
  /// - 调用该方法后，在收到 [RtcEngineEventHandler.lastmileQuality]
  /// 和 [RtcEngineEventHandler.lastmileProbeResult] 回调之前请不用调用其他方法，
  /// 否则可能会由于 API 操作过于频繁导致此方法无法执行。
  /// - 直播场景下，如果本地用户为主播，请勿在加入频道后调用该方法。
  ///
  /// **Parameter** [config] Last-mile 网络探测配置。详见 [LastmileProbeConfig]。
  Future<void> startLastmileProbeTest(LastmileProbeConfig config);

  /// 停止通话前网络质量探测。
  Future<void> stopLastmileProbeTest();
}

mixin RtcMediaMetadataInterface {
  /// 注册媒体 Metadata 观测器。
  ///
  /// 该接口通过在直播的视频帧中同步添加 Metadata，实现发送商品链接、分发优惠券、发送答题等功能，构建更为丰富的直播互动方式。
  ///
  /// **Note**
  /// 请在调用 [RtcEngine.joinChannel] 加入频道前调用该方法。
  Future<void> registerMediaMetadataObserver();

  /// 注销媒体 Metadata 观测器。
  Future<void> unregisterMediaMetadataObserver();

  /// 设置 Metadata 的最大数据大小。
  ///
  /// **Parameter** [size] Metadata 的最大数据大小，单位为 Byte，最大值不超过 1024。
  Future<void> setMaxMetadataSize(int size);

  /// 发送 Mtadata。
  ///
  /// **Parameter** [metadata] 想要发送的 Metadata。
  ///
  /// **Note**
  /// 请确保在该方法中传入的 Metadata 大小不超过 [setMaxMetadataSize] 中设定的值。
  Future<void> sendMetadata(String metadata);
}

mixin RtcWatermarkInterface {
  /// 添加本地视频水印。
  ///
  /// 该方法将一张 PNG 图片作为水印添加到本地发布的直播视频流上，同一直播频道中的观众、旁路直播观众和录制设备都能看到或采集到该水印图片。
  /// Agora 当前只支持在直播视频流中添加一个水印，后添加的水印会替换掉之前添加的水印。
  ///
  /// 水印坐标和 [RtcEngine.setVideoEncoderConfiguration] 方法中的设置有依赖关系：
  /// - 如果视频编码方向/ORIENTATION_MODE 固定为横屏或自适应模式下的横屏，那么水印使用横屏坐标。
  /// - 如果视频编码方向/ORIENTATION_MODE 固定为竖屏或自适应模式下的竖屏，那么水印使用竖屏坐标。
  /// - 设置水印坐标时，水印的图像区域不能超出 [RtcEngine.setVideoEncoderConfiguration] 方法中设置的视频尺寸，否则超出部分将被裁剪。
  ///
  /// **Note**
  /// - 你需要在调用 [RtcEngine.enableVideo] 方法之后再调用本方法。
  /// - 如果你只是在旁路直播（推流到CDN）中添加水印，你可以使用本方法或 [RtcEngine.setLiveTranscoding] 方法设置水印。
  /// - 待添加图片必须是 PNG 格式。本方法支持所有像素格式的 PNG 图片：RGBA、RGB、Palette、Gray 和 Alpha_gray。
  /// - 如果待添加的 PNG 图片的尺寸与你在本方法中设置的尺寸不一致，SDK 会对 PNG 图片进行缩放或裁剪，以与设置相符。
  /// - 如果你已经使用 [RtcEngine.startPreview] 方法开启本地视频预览，那么本方法的 `visibleInPreview` 可设置水印在预览时是否可见。
  /// - 如果你已设置本地视频为镜像模式，那么此处的本地水印也为镜像。为避免本地用户看本地视频时的水印也被镜像，
  /// Agora 建议你不要对本地视频同时使用镜像和水印功能，请在应用层实现本地水印功能。
  ///
  /// **Parameter** [watermarkUrl] 待添加的水印图片的本地路径。本方法支持从本地路径和 assets 路径添加水印图片。如果使用 assets 路径，需要以 `/assets/` 开头。
  ///
  /// **Parameter** [options] 待添加的水印图片的设置选项。详见 [WatermarkOptions]。
  Future<void> addVideoWatermark(String watermarkUrl, WatermarkOptions options);

  /// 删除本地视频水印。
  ///
  /// 该方法删除使用 [RtcEngine.addVideoWatermark] 方法添加的本地视频水印。
  Future<void> clearVideoWatermarks();
}

mixin RtcEncryptionInterface {
  /// 启用内置加密，并设置数据加密密码。
  ///
  /// **Deprecated**
  /// 自 v3.1.2 起废弃。请改用 `enableEncryption`。
  ///
  /// 如果需要启用加密，请在加入频道前调用 [RtcEngine.setEncryptionSecret] 启用
  /// 内置加密功能，并设置加密密码。同一频道内的所有用户应设置相同的密码。
  /// 当用户离开频道时，该频道的密码会自动清除。如果未指定密码或将密码设置为空，则无法激活加密功能。
  ///
  /// **Note**
  /// - 为保证最佳传输效果，请确保加密后的数据大小不超过原始数据大小 + 16 字节。16 字节是 AES 通用加密模式下最大填充块大小。
  /// - 请勿在转码推流场景中使用该方法。
  ///
  /// **Parameter** [secret] 加密密码。
  Future<void> setEncryptionSecret(String secret);

  /// 设置内置的加密方案。
  ///
  /// **Deprecated**
  /// 自 v3.1.2 起废弃。请改用 `enableEncryption`。
  ///
  /// Agora SDK 支持内置加密功能，默认使用 `AES128XTS` 加密方式。如需使用其他加密方式，可以调用该 API 设置。
  /// 同一频道内的所有用户必须设置相同的加密方式和密码才能进行通话。关于这几种加密方式的区别，请参考 AES 加密算法的相关资料。
  ///
  /// **Note**
  ///
  /// 在调用本方法前，请先调用 [RtcEngine.setEncryptionSecret] 启用内置加密功能。
  ///
  /// **Parameter** [encryptionMode] 加密方式。详见 [EncryptionMode]。
  Future<void> setEncryptionMode(EncryptionMode encryptionMode);

  /// 开启或关闭内置加密。
  ///
  /// @since v3.1.2。
  ///
  /// 在安全要求较高的场景下，Agora 建议你在加入频道前，调用 `enableEncryption` 方法开启内置加密。
  ///
  /// 同一频道内所有用户必须使用相同的加密模式和密钥。一旦所有用户都离开频道，该频道的加密密钥会自动清除。
  ///
  /// **Note**
  /// - 如果开启了内置加密，则不能使用 RTMP 推流功能。
  /// - Agora 支持 4 种加密模式。除 `SM4128ECB` 模式外，其他加密模式都需要在集成 SDK 时，额外添加加密库文件。详见《媒体流加密》。
  ///
  /// **Parameter** [enabled] 是否开启内置加密：
  /// - `true`：开启内置加密。
  /// - `false`：关闭内置加密。
  /// **Parameter** [config] 配置内置加密模式和密钥。详见 [EncryptionConfig]。
  Future<void> enableEncryption(bool enabled, EncryptionConfig config);
}

mixin RtcAudioRecorderInterface {
  /// 开始客户端录音。
  ///
  /// Agora SDK 支持通话过程中在客户端进行录音。调用该方法后，你可以录制频道内所有用户的音频，
  /// 并得到一个包含所有用户声音的录音文件。录音文件格式可以为：
  /// - .wav：文件大，音质保真度较高。
  /// - .aac：文件小，音质保真度较低。
  ///
  /// **Note**
  /// - 请确保你在该方法中指定的路径存在并且可写。
  /// - 该接口需要在 [RtcEngine.joinChannel] 之后调用。
  /// 如果调用 [RtcEngine.leaveChannel] 时还在录音，录音会自动停止。
  /// - 为保证录音效果，当 `sampleRate` 设为 44.1 kHz 或 48 kHz 时，建议将 `quality` 设
  /// 为 [AudioRecordingQuality.Medium] 或 [AudioRecordingQuality.High]。
  ///
  /// **Parameter** [filePath] 录音文件在本地保存的绝对路径，由用户自行制定，需精确到文件名及格式，例如：`/dir1/dir2/dir3/audio.aac`。
  ///
  /// **Parameter** [sampleRate] 录音采样率 (Hz)。详见 [AudioSampleRateType]。
  ///
  /// **Parameter** [quality] 录音音质。详见 [AudioRecordingQuality]。
  Future<void> startAudioRecording(String filePath,
      AudioSampleRateType sampleRate, AudioRecordingQuality quality);

  /// 停止客户端录音。
  ///
  /// **Note**
  /// 该方法停止录音。该接口需要在 [RtcEngine.leaveChannel] 之前调用，不然会在调用 [RtcEngine.leaveChannel] 时自动停止。
  Future<void> stopAudioRecording();
}

mixin RtcInjectStreamInterface {
  /// 输入在线媒体流。
  ///
  /// 该方法通过在服务端拉取视频流并发送到频道中，将正在播出的视频输入到正在进行的直播中。可主要应用于赛事直播、多人看视频互动等直播场景。
  ///
  /// 调用该方法后，SDK 会在本地触发 [RtcEngineEventHandler.streamInjectedStatus] 回调，
  /// 报告输入在线媒体流的状态；
  /// 成功输入媒体流后，该音视频流会出现在频道中，频道内所有用户都会收到 [RtcEngineEventHandler.userJoined] 回调，
  /// 其中 uid 为 666。
  ///
  /// **Note**
  /// - 调用该方法前，请确保已开通旁路推流的功能，详见进阶功能《推流到 CDN》中的前提条件。
  /// - 该方法仅适用于直播场景中的主播用户。
  /// - 频道内同一时间只允许输入一个在线媒体流。
  ///
  /// **Parameter** [url] 添加到直播中的视频流 URL 地址，支持 RTMP，HLS，HTTP-FLV 协议传输。
  /// - 支持的音频编码格式：AAC。
  /// - 支持的视频编码格式：H264 (AVC)。
  ///
  /// **Parameter** [config] 外部输入的音视频流的配置。
  Future<void> addInjectStreamUrl(String url, LiveInjectStreamConfig config);

  /// 删除输入的在线媒体流。
  ///
  /// 成功删除后，会触发 [RtcEngineEventHandler.userOffline] 回调，其中 uid 为 666。
  ///
  /// **Parameter** [url] 已输入、待删除的外部视频流 URL 地址，格式为 HTTP 或 HTTPS。
  Future<void> removeInjectStreamUrl(String url);
}

mixin RtcCameraInterface {
  /// 切换前置/后置摄像头。
  Future<void> switchCamera();

  /// 检测设备是否支持摄像头缩放功能。
  ///
  /// **Returns**
  /// - `true`：设备支持相机缩放功能。
  /// - `false`：设备不支持相机缩放功能。
  Future<bool> isCameraZoomSupported();

  /// 检测设备是否支持闪光灯常开。
  ///
  /// **Returns**
  /// - `true`：设备支持闪光灯常开。
  /// - `false`：设备不支持闪光灯常开。
  Future<bool> isCameraTorchSupported();

  /// 检测设备是否支持手动对焦功能。
  ///
  /// **Returns**
  /// - `true`：设备支持手动对焦功能。
  /// - `false`：设备不支持手动对焦功能。
  Future<bool> isCameraFocusSupported();

  /// 检测设备是否支持手动曝光功能。
  ///
  /// **Returns**
  /// - `true`：设置支持手动曝光功能。
  /// - `false`：设置不支持手动曝光功能。
  Future<bool> isCameraExposurePositionSupported();

  /// 检测设备是否支持人脸对焦功能。
  ///
  /// **Returns**
  /// - `true`：设备支持人脸对焦功能。
  /// - `false`：设备不支持人脸对焦功能。
  Future<bool> isCameraAutoFocusFaceModeSupported();

  /// 设置摄像头缩放比例。
  ///
  /// **Parameter** [factor] 相机缩放比例，有效范围从 1.0 到最大缩放。
  Future<void> setCameraZoomFactor(double factor);

  /// 获取摄像头支持最大缩放比例。
  ///
  /// **Returns** 该相机支持的最大缩放比例。
  Future<double> getCameraMaxZoomFactor();

  /// 设置手动对焦位置，并触发对焦。
  ///
  /// 成功调用该方法后，本地会触发 [RtcEngineEventHandler.cameraFocusAreaChanged] 回调。
  ///
  /// **Parameter** [positionX] 触摸点相对于视图的横坐标。
  ///
  /// **Parameter** [positionY] 触摸点相对于视图的纵坐标。
  Future<void> setCameraFocusPositionInPreview(
      double positionX, double positionY);

  /// 设置手动曝光位置。
  ///
  /// 成功调用该方法后，本地会触发 [RtcEngineEventHandler.cameraExposureAreaChanged] 回调。
  ///
  /// **Parameter** [positionXinView] 触摸点相对于视图的横坐标。
  ///
  /// **Parameter** [positionYinView] 触摸点相对于视图的纵坐标。
  Future<void> setCameraExposurePosition(
      double positionXinView, double positionYinView);

  /// 开启/关闭本地人脸检测。
  ///
  /// 开启本地人脸检测后，SDK 会触发 [RtcEngineEventHandler.facePositionChanged] 回调向你报告人脸检测的信息：
  /// - 摄像头采集的画面大小。
  /// - 人脸在画面中的位置。
  /// - 人脸距设备屏幕的距离。
  ///
  /// **Parameter** [enable] 是否开启人脸检测：
  /// - `true`：开启人脸检测。
  /// - `false`：（默认）关闭人脸检测。
  Future<void> enableFaceDetection(bool enable);

  /// 设置是否打开闪光灯。
  ///
  /// **Parameter** [isOn] 是否打开闪光灯：
  /// - `true`：打开。
  /// - `false`：关闭。
  Future<void> setCameraTorchOn(bool isOn);

  /// 设置是否开启人脸对焦功能。
  ///
  /// **Parameter** [enabled] 是否开启人脸对焦：
  /// - `true`：开启人脸对焦功能。
  /// - `false`：（默认）关闭人脸对焦功能。
  Future<void> setCameraAutoFocusFaceModeEnabled(bool enabled);

  /// 设置摄像头的采集偏好。
  ///
  /// 一般的视频通话或直播中，默认由 SDK 自动控制摄像头的输出参数。在如下特殊场景中，默认的参数通常无法满足需求，
  /// 或可能引起设备性能问题，我们推荐调用该接口设置摄像头的采集偏好：
  ///
  /// - 使用裸数据自采集接口时，如果 SDK 输出的分辨率和帧率高于 [RtcEngine.setVideoEncoderConfiguration]
  /// 中指定的参数，在后续处理视频帧的时候，比如美颜功能时，
  /// 会需要更高的 CPU 及内存，容易导致性能问题。在这种情况下，我们推荐将摄像头采集偏好设置为 [CameraCaptureOutputPreference.Performance]，
  /// 避免性能问题。
  /// - 如果没有本地预览功能或者对预览质量没有要求，我们推荐将采集偏好设置为 [CameraCaptureOutputPreference.Performance]，以优化 CPU 和
  /// 内存的资源分配。
  /// - 如果用户希望本地预览视频比实际编码发送的视频清晰，可以将采集偏好设置为 [CameraCaptureOutputPreference.Preview]。
  ///
  /// **Note**
  ///
  /// 请在启动摄像头之前调用该方法，如 [RtcEngine.joinChannel]，[RtcEngine.enableVideo]
  /// 或者 [RtcEngine.enableLocalVideo]。
  ///
  /// **Parameter** [config] 摄像头采集偏好。详见 [CameraCapturerConfiguration]。
  Future<void> setCameraCapturerConfiguration(
      CameraCapturerConfiguration config);
}

mixin RtcStreamMessageInterface {
  /// 创建数据流。
  ///
  /// 该方法用于创建数据流。[`RtcEngine`] 生命周期内，每个用户最多只能创建 5 个数据流。
  /// 频道内数据通道最多允许数据延迟 5 秒，若超过 5 秒接收方尚未收到数据流，则数据通道会向 App 报错。
  ///
  /// **Parameter** [reliable] 是否可靠。
  ///
  ///  - `true`: 接收方 5 秒内会收到发送方所发送的数据，
  /// 否则会收到 [RtcEngineEventHandler.streamMessageError] 回调并获得相应报错信息。
  ///  - `false`: 接收方不保证收到，就算数据丢失也不会报错。
  /// **Parameter** [ordered] 是否有序。
  ///  - `true`: 接收方会按照发送方发送的顺序收到数据包。
  ///  - `false`: 接收方不保证按照发送方发送的顺序收到数据包。
  ///
  /// **Returns**
  /// - 创建数据流成功则返回数据流 ID。
  /// - < 0：创建数据流失败。如果返回的错误码是负数，对应错误代码和警告代码里的正整数。
  Future<int> createDataStream(bool reliable, bool ordered);

  /// 发送数据流。
  ///
  /// 该方法发送数据流消息到频道内所有用户。SDK 对该方法的实现进行了如下限制：
  /// 频道内每秒最多能发送 30 个包，且每个包最大为 1 KB。 每个客户端每秒最多能发送 6 KB 数据。频道内每人最多能同时有 5 个数据通道。
  ///
  /// 成功调用该方法后，远端会触发 [RtcEngineEventHandler.streamMessage] 回调，
  /// 远端用户可以在该回调中获取接收到的流消息；若调用失败，
  /// 远端会触发 [RtcEngineEventHandler.streamMessageError] 回调。
  ///
  /// **Note**
  /// - 请确保在调用该方法前，已调用 [RtcEngine.createDataStream] 创建了数据通道。
  /// - 该方法仅适用于通信场景以及直播场景下的主播用户。
  ///
  /// **Parameter** [streamId] 数据流 ID，[RtcEngine.createDataStream] 的返回值。
  ///
  /// **Parameter** [message] 待发送的数据。
  Future<void> sendStreamMessage(int streamId, String message);
}
