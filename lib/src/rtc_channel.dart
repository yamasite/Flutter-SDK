import 'dart:async';

import 'package:flutter/services.dart';

import 'classes.dart';
import 'enum_converter.dart';
import 'enums.dart';
import 'events.dart';
import 'rtc_engine.dart';

/// [RtcChannel] 类。
class RtcChannel with RtcChannelInterface {
  static const MethodChannel _methodChannel =
      MethodChannel('agora_rtc_channel');
  static const EventChannel _eventChannel =
      EventChannel('agora_rtc_channel/events');

  static StreamSubscription _subscription;

  static final Map<String, RtcChannel> _channels = {};

  final String _channelId;

  RtcChannelEventHandler _handler;

  RtcChannel._(this._channelId);

  Future<T> _invokeMethod<T>(String method, [Map<String, dynamic> arguments]) {
    return _methodChannel.invokeMethod(
        method,
        arguments == null
            ? {'channelId': _channelId}
            : {'channelId': _channelId, ...arguments});
  }

  /// 创建并返回 [RtcChannel] 对象。
  ///
  /// 你可以多次调用该方法，创建多个 [RtcChannel] 对象，再调用各 [RtcChannel] 对象中的 [RtcChannel.joinChannel] 方法，实现同时加入多个频道。
  ///
  /// 加入多个频道后，你可以同时订阅各个频道的音、视频流；但是同一时间只能在一个频道发布一路音、视频流。
  ///
  /// **Parameter** [channelId] 标识通话的频道名称，长度在 64 字节以内的字符串。以下为支持的字符集范围（共 89 个字符）：
  ///  - 26 个小写英文字母 a-z
  ///  - 26 个大写英文字母 A-Z
  ///  - 10 个数字 0-9
  ///  - 空格
  ///  - "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ","
  ///
  /// **Note**
  ///  - 该参数没有默认值，请确保对参数设值。
  ///  - 请勿将该参数设为空字符 ""，否则 SDK 会返回 [ErrorCode(5)]。
  ///
  /// **Returns**
  /// - 方法调用成功，返回 [RtcChannel] 对象。
  /// - 方法调用失败，返回 null。
  ///  - 如果将 `channelId` 设为空字符 ""，则返回错误码 [ErrorCode(5)]。
  static Future<RtcChannel> create(String channelId) async {
    if (_channels.containsKey(channelId)) return _channels[channelId];
    await _methodChannel.invokeMethod('create', {'channelId': channelId});
    _channels[channelId] = RtcChannel._(channelId);
    return _channels[channelId];
  }

  /// 销毁所有的 [RtcChannel] 对象。
  static void destroyAll() {
    _channels.forEach((key, value) async {
      await value.destroy();
    });
    _channels.clear();
  }

  @override
  Future<void> destroy() {
    _channels.remove(_channelId);
    return _invokeMethod('destroy');
  }

  /// 设置频道事件句柄。
  ///
  /// 设置后，你可以通过 [RtcChannel] 回调监听对应频道内的事件、获取频道数据。
  ///
  /// **Parameter** [handler] 事件句柄。
  void setEventHandler(RtcChannelEventHandler handler) {
    _handler = handler;
    _subscription ??= _eventChannel.receiveBroadcastStream().listen((event) {
      final eventMap = Map<dynamic, dynamic>.from(event);
      final channelId = eventMap['channelId'];
      final methodName = eventMap['methodName'] as String;
      final data = List<dynamic>.from(eventMap['data']);
      _channels[channelId]?._handler?.process(methodName, data);
    });
  }

  @override
  Future<void> setClientRole(ClientRole role) {
    return _invokeMethod(
        'setClientRole', {'role': ClientRoleConverter(role).value()});
  }

  @override
  Future<void> joinChannel(String token, String optionalInfo, int optionalUid,
      ChannelMediaOptions options) {
    return _invokeMethod('joinChannel', {
      'token': token,
      'optionalInfo': optionalInfo,
      'optionalUid': optionalUid,
      'options': options.toJson()
    });
  }

  @override
  Future<void> joinChannelWithUserAccount(
    String token, String userAccount, ChannelMediaOptions options) {
    return _invokeMethod('joinChannelWithUserAccount', {
      'token': token,
      'userAccount': userAccount,
      'options': options.toJson()
    });
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
  Future<ConnectionStateType> getConnectionState() {
    return _invokeMethod('getConnectionState').then((value) {
      return ConnectionStateTypeConverter.fromValue(value).e;
    });
  }

  @override
  Future<void> publish() {
    return _invokeMethod('publish');
  }

  @override
  Future<void> unpublish() {
    return _invokeMethod('unpublish');
  }

  @override
  Future<String> getCallId() {
    return _invokeMethod('getCallId');
  }

  @override
  Future<void> adjustUserPlaybackSignalVolume(int uid, int volume) {
    return _invokeMethod(
        'adjustUserPlaybackSignalVolume', {'uid': uid, 'volume': volume});
  }

  @override
  Future<void> muteAllRemoteAudioStreams(bool muted) {
    return _invokeMethod('muteAllRemoteAudioStreams', {'muted': muted});
  }

  @override
  Future<void> muteRemoteAudioStream(int uid, bool muted) {
    return _invokeMethod('muteRemoteAudioStream', {'uid': uid, 'muted': muted});
  }

  @override
  Future<void> setDefaultMuteAllRemoteAudioStreams(bool muted) {
    return _invokeMethod(
        'setDefaultMuteAllRemoteAudioStreams', {'muted': muted});
  }

  @override
  Future<void> muteAllRemoteVideoStreams(bool muted) {
    return _invokeMethod('muteAllRemoteVideoStreams', {'muted': muted});
  }

  @override
  Future<void> muteRemoteVideoStream(int uid, bool muted) {
    return _invokeMethod('muteRemoteVideoStream', {'uid': uid, 'muted': muted});
  }

  @override
  Future<void> setDefaultMuteAllRemoteVideoStreams(bool muted) {
    return _invokeMethod(
        'setDefaultMuteAllRemoteVideoStreams', {'muted': muted});
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
  Future<int> createDataStream(bool reliable, bool ordered) {
    return _invokeMethod(
        'createDataStream', {'reliable': reliable, 'ordered': ordered});
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
  Future<void> sendMetadata(String metadata) {
    return _invokeMethod('sendMetadata', {'metadata': metadata});
  }

  @override
  Future<void> sendStreamMessage(int streamId, String message) {
    return _invokeMethod(
        'sendStreamMessage', {'streamId': streamId, 'message': message});
  }

  @override
  Future<void> setEncryptionMode(EncryptionMode encryptionMode) {
    return _invokeMethod('setEncryptionMode',
        {'encryptionMode': EncryptionModeConverter(encryptionMode).value()});
  }

  @override
  Future<void> setEncryptionSecret(String secret) {
    return _invokeMethod('setEncryptionSecret', {'secret': secret});
  }

  @override
  Future<void> setLiveTranscoding(LiveTranscoding transcoding) {
    return _invokeMethod(
        'setLiveTranscoding', {'transcoding': transcoding.toJson()});
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
  Future<void> startChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration) {
    return _invokeMethod('startChannelMediaRelay', {
      'channelMediaRelayConfiguration': channelMediaRelayConfiguration.toJson()
    });
  }

  @override
  Future<void> stopChannelMediaRelay() {
    return _invokeMethod('stopChannelMediaRelay');
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
  Future<void> enableEncryption(bool enabled, EncryptionConfig config) {
    return _invokeMethod(
        'enableEncryption', {'enabled': enabled, 'config': config.toJson()});
  }
}

mixin RtcChannelInterface
    implements
        RtcAudioInterface,
        RtcVideoInterface,
        RtcVoicePositionInterface,
        RtcPublishStreamInterface,
        RtcMediaRelayInterface,
        RtcDualStreamInterface,
        RtcFallbackInterface,
        RtcMediaMetadataInterface,
        RtcEncryptionInterface,
        RtcInjectStreamInterface,
        RtcStreamMessageInterface {
  /// 销毁当前的 [RtcChannel] 对象。
  Future<void> destroy();

  /// 设置直播场景下的用户角色。
  ///
  /// 该方法设置用户角色为观众或主播。
  /// 直播频道中，只有角色为主播的用户才能调用 [RtcChannel] 类下的 [RtcChannel.publish] 方法。
  ///
  /// 成功调用该方法切换用户角色后，SDK 会触发以下回调：
  /// - 本地：[RtcChannelEventHandler.clientRoleChanged]。
  /// - 远端：[RtcChannelEventHandler.userJoined] 或 [RtcChannelEventHandler.userOffline] (`BecomeAudience`)。
  ///
  /// **Parameter** [role] 用户角色。详见 [ClientRole]。
  Future<void> setClientRole(ClientRole role);

  /// 使用 UID 加入频道。
  ///
  /// **Note**
  /// - 该方法不支持相同的用户重复加入同一个频道。
  /// - Agora 建议不同频道中使用不同的 UID。
  /// - 如果想要从不同的设备同时接入同一个频道，请确保每个设备上使用的 UID 是不同的。
  /// - 请确保用于生成 Token 的 App ID 和创建 [RtcEngine] 对象时用的 App ID 一致。
  ///
  /// **Parameter** [token] 在 App 服务器端生成的用于鉴权的 Token：
  /// - 安全要求不高：你可以使用控制台生成的临时 Token，详见[获取临时 Token](https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms#temptoken)。
  /// - 安全要求高：将值设为你的服务端生成的正式 Token，详见[从服务端生成 Token](https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms#generatetoken)。
  ///
  /// **Parameter** [optionalInfo] 开发者需加入的任何附加信息。一般可设置为空字符串，或频道相关信息。该信息不会传递给频道内的其他用户。
  ///
  /// **Parameter** [optionalUid] 用户 ID，32 位无符号整数。建议设置范围：1 到 (2<sup>32</sup>-1)，并保证唯一性。
  /// 如果不指定（即设为 0），SDK 会自动分配一个，
  /// 并在 [`JoinChannelSuccess`]{@link RtcChannelEvents.JoinChannelSuccess} 回调方法中返回，App 层必须记住该返回值并维护，SDK 不对该返回值进行维护。
  ///
  /// **Parameter** [options] 频道媒体设置选项。详见 [ChannelMediaOptions]。
  Future<void> joinChannel(String token, String optionalInfo, int optionalUid,
      ChannelMediaOptions options);


  /// 使用 User Account 加入频道。
  ///
  /// **Note**
  /// - 该方法不支持相同的用户重复加入同一个频道。
  /// - 我们建议不同频道中使用不同的 User Account。
  /// - 如果想要从不同的设备同时接入同一个频道，请确保每个设备上使用的 User Account 是不同的。
  /// - 请确保用于生成 Token 的 App ID 和创建 RtcEngine 对象时用的 App ID 一致。
  ///
  /// **Parameter** [token] 在 App 服务器端生成的用于鉴权的 Token：
  /// - 安全要求不高：你可以使用控制台生成的临时 Token，详见[获取临时 Token](https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms#temptoken)。
  /// - 安全要求高：将值设为你的服务端生成的正式 Token，详见[从服务端生成 Token](https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms#generatetoken)。
  ///
  /// **Parameter** [userAccount] 用户 User Account。该参数为必需，最大不超过 255 字节，不可为 null。请确保加入频道的 User Account 的唯一性。
  /// 以下为支持的字符集范围（共 89 个字符）：
  /// - 26 个小写英文字母 a-z
  /// - 26 个大写英文字母 A-Z
  /// - 10 个数字 0-9
  /// - 空格
  /// - "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ","
  ///
  /// **Parameter** [options] 频道媒体设置选项。详见 [ChannelMediaOptions]。
  Future<void> joinChannelWithUserAccount(
      String token, String userAccount, ChannelMediaOptions options);

  /// 离开当前频道。
  ///
  /// 成功调用该方法离开频道后，会触发如下回调：
  /// - 本地：[RtcChannelEventHandler.leaveChannel].
  /// - 远端：通信场景下的用户和直播场景下的主播离开频道后，触发 [RtcChannelEventHandler.userOffline]。
  Future<void> leaveChannel();

  /// 更新 Token。
  ///
  /// 在如下情况下，SDK 判定当前的 Token 已过期：
  /// - SDK 触发 [RtcChannelEventHandler.tokenPrivilegeWillExpire] 回调，或者
  /// - SDK 在 [RtcChannelEventHandler.connectionStateChanged] 回调中报告 [ConnectionChangedReason.TokenExpired] 错误。
  ///
  /// 你应该在服务端重新获取 Token，然后调用该方法更新 Token，否则 SDK 无法和服务器建立连接。
  ///
  /// **Parameter** [token] 新的 Token。
  Future<void> renewToken(String token);

  /// 获取网络连接状态。
  Future<ConnectionStateType> getConnectionState();

  /// 将本地音视频流发布到本频道。
  ///
  /// 该方法的调用需满足以下要求，否则 SDK 会返回 [ErrorCode.Refused]：
  /// - 该方法仅支持将音视频流发布到当前 [RtcChannel] 类所对应的频道。
  /// - 直播场景下，该方法仅适用于角色为主播的用户。你可以调用该 [RtcChannel] 类
  /// 下的 [RtcChannel.setClientRole] 方法设置用户角色。
  /// - SDK 只支持用户同一时间在一个频道发布一路音视频流。详情请参考高阶指南《多频道管理》。
  Future<void> publish();

  // 停止将本地音视频流发布到本频道。
  ///
  /// 请确保你想要停止发布音视频流的频道 `channelId`，与当前正在 [RtcChannel.publish] 音视频流的频道 `channelId` 一致，
  /// 否则 SDK 会返回 [ErrorCode.Refused]。
  Future<void> unpublish();

  /// 获取当前的通话 ID。
  ///
  /// **Returns**
  /// - 方法调用成功，则返回当前的通话 ID。
  /// - 方法调用失败，则返回空字符串 ""。
  Future<String> getCallId();
}

mixin RtcAudioInterface {
  /// 调节本地播放的指定远端用户音量。
  ///
  /// 你可以多次调用该方法调节不同远端用户在本地播放的音量，或对某个远端用户在本地播放的音量调节多次。
  ///
  /// **Note**
  /// - 该方法要在加入频道后调用。
  /// - 该方法调节的是本地播放的指定远端用户混音后的音量。
  /// - 该方法每次只能调整一位远端用户在本地播放的音量。若需调整多位远端用户在本地播放的音量，则需多次调用该方法。
  ///
  /// **Parameter** [uid] 远端用户的 ID。
  ///
  /// **Parameter** [volume] 播放音量，取值范围为 [0,100]。
  /// - 0：静音。
  /// - 100：原始音量。
  Future<void> adjustUserPlaybackSignalVolume(int uid, int volume);

  /// 停止/恢复接收指定音频流。
  ///
  /// **Parameter** [uid] 指定的用户 ID。
  ///
  /// **Parameter** [muted] 设置是否停止/恢复接收指定音频流：
  /// - `true`：停止接收指定用户的音频流。
  /// - `false`：（默认）继续接收指定用户的音频流。
  Future<void> muteRemoteAudioStream(int uid, bool muted);

  /// 停止/恢复接收所有音频流。
  ///
  /// **Parameter** [muted] 设置是否默认不接收所有远端音频：
  /// - `true`：不接收所有远端音频流。
  /// - `false`：（默认）接收所有远端音频流。
  Future<void> muteAllRemoteAudioStreams(bool muted);

  /// 设置是否默认接收音频流。
  ///
  /// **Parameter** [muted] 设置是否默认不接收所有远端音频：
  /// - `true`：不接收所有远端音频流。
  /// - `false`：（默认）接收所有远端音频流。
  Future<void> setDefaultMuteAllRemoteAudioStreams(bool muted);
}

mixin RtcVideoInterface {
  /// 停止/恢复接收指定视频流。
  ///
  /// **Parameter** [uid] 指定的用户 ID。
  ///
  /// **Parameter** [muted] 设置是否停止/恢复接收指定视频流：
  /// - `true`：停止接收指定用户的视频流。
  /// - `false`：（默认）继续接收指定用户的视频流。
  Future<void> muteRemoteVideoStream(int uid, bool muted);

  /// 停止/恢复接收所有视频流。
  ///
  /// **Parameter** [muted] 设置是否停止/恢复接收所有视频流：
  /// - `true`：停止接收所有远端视频流。
  /// - `false`：（默认）继续接收所有远端视频流。
  Future<void> muteAllRemoteVideoStreams(bool muted);

  /// 设置是否默认接收视频流。
  ///
  ///
  /// **Parameter** [muted] 设置是否默认不接收所有远端视频：
  /// - `true`：不接收所有远端视频流。
  /// - `false`：（默认）接收所有远端视频流。
  Future<void> setDefaultMuteAllRemoteVideoStreams(bool muted);
}

mixin RtcVoicePositionInterface {
  /// 设置远端用户声音的空间位置和音量，方便本地用户听声辨位。
  ///
  /// 用户通过调用该接口，设置远端用户声音出现的位置，左右声道的声音差异会让用户产生声音的方位感，
  /// 从而判断出远端用户的实时位置。
  /// 在多人在线游戏场景，如吃鸡游戏中，该方法能有效增加游戏角色的方位感，模拟真实场景。
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
  /// - 1.0：声音出现在右边。
  ///
  /// **Parameter** [gain] 设置远端用户声音的音量，取值范围为 [0.0,100.0]，默认值为 100.0，
  /// 表示该用户的原始音量。取值越小，则音量越低。
  Future<void> setRemoteVoicePosition(int uid, double pan, double gain);
}

mixin RtcPublishStreamInterface {
  /// 设置直播转码。
  ///
  /// 该方法用于旁路推流的视图布局及音频设置等。调用该方法更新转码参数 `LiveTranscoding` 时，
  /// SDK 会触发 [RtcChannelEventHandler.transcodingUpdated] 回调。
  ///
  /// 首次调用该方法设置转码参数时，不会触发 [RtcChannelEventHandler.transcodingUpdated] 回调。
  ///
  /// **Note**
  /// - 请确保已开通旁路推流的功能，详见进阶功能《推流到 CDN》中的前提条件。
  /// - 该方法仅适用于直播场景下的主播用户。
  /// - 请确保先调用过该方法，再调用 [RtcChannel.addPublishStreamUrl]。
  ///
  /// **Parameter** [transcoding] 旁路推流布局相关设置。详见 [LiveTranscoding]。
  Future<void> setLiveTranscoding(LiveTranscoding transcoding);

  /// 增加旁路推流地址。
  ///
  /// 调用该方法后，SDK 会在本地
  /// 触发 [RtcChannelEventHandler.rtmpStreamingStateChanged] 回调，报告增加旁路推流地址的状态。
  ///
  /// **Note**
  /// - 调用该方法前，请确保已开通旁路推流的功能，详见进阶功能《推流到 CDN》中的前提条件。
  /// - 请确保在成功加入频道后才能调用该接口。
  /// - 该方法仅适用直播场景。
  /// - 该方法每次只能增加一路旁路推流地址。若需推送多路流，则需多次调用该方法。
  ///
  /// **Parameter** [url] CDN 推流地址，格式为 RTMP。该字符长度不能超过 1024 字节。url 不支持中文等特殊字符。
  ///
  /// **Parameter** [transcodingEnabled] 是否转码。如果设为 `true`，则需要在该方法前先调用 [RtcChannel.setLiveTranscoding] 方法。
  /// - `true`：转码。转码是指在旁路推流时对音视频流进行转码处理后，再推送到其他 RTMP 服务器。
  /// 多适用于频道内有多个主播，需要进行混流、合图的场景。
  /// - `false`：不转码。
  Future<void> addPublishStreamUrl(String url, bool transcodingEnabled);

  /// 删除旁路推流地址。
  ///
  /// 调用该方法后，SDK 会在本地触发 [RtcChannelEventHandler.rtmpStreamingStateChanged] 回调，报告删除旁路推流地址的状态。
  ///
  /// **Note**
  /// - 调用该方法前，请确保已开通旁路推流的功能，详见进阶功能《推流到 CDN》中的前提条件。
  /// - 该方法只适用于直播场景。
  /// - 该方法每次只能删除一路旁路推流地址。若需删除多路流，则需多次调用该方法。
  ///
  /// **Parameter** [url] 待删除的推流地址，格式为 RTMP。该字符长度不能超过 1024 字节。推流地址不支持中文等特殊字符。
  Future<void> removePublishStreamUrl(String url);
}

mixin RtcMediaRelayInterface {
  /// 开始跨频道媒体流转发。
  ///
  /// 成功调用该方法后，SDK 会触发 [RtcChannelEventHandler.channelMediaRelayStateChanged] 和
  /// [RtcChannelEventHandler.channelMediaRelayEvent] 回调，并在回调中报告当前的跨频道媒体流转发状态和事件。
  ///
  /// - 如果 [RtcChannelEventHandler.channelMediaRelayStateChanged] 回调报告 [ChannelMediaRelayState.Running] 和 [ChannelMediaRelayError.None]，
  /// 且 [RtcChannelEventHandler.channelMediaRelayEvent] 回调报告 [ChannelMediaRelayEvent.SentToDestinationChannel]，则表示 SDK 开始在源频道和目标频道之间转发媒体流。
  /// - 如果 [RtcChannelEventHandler.channelMediaRelayStateChanged] 回调报告 [ChannelMediaRelayState.Failure]，则表示跨频道媒体流转发出现异常。
  ///
  /// **Note**
  /// - 跨频道媒体流转发功能需要联系 sales@agora.io 开通。
  /// - 该功能不支持 String 型 UID。
  /// - 请在成功加入频道后调用该方法。
  /// - 该方法仅适用于直播场景下的主播。
  /// - 成功调用该方法后，若你想再次调用该方法，必须先调用 [RtcChannel.stopChannelMediaRelay] 方法退出当前的转发状态。
  ///
  /// **Parameter** [channelMediaRelayConfiguration] 跨频道媒体流转发参数配置。
  Future<void> startChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration);

  /// 更新媒体流转发的频道。
  ///
  /// 成功开始跨频道转发媒体流后，如果你希望将流转发到多个目标频道，或退出当前的转发频道，可以调用该方法。
  ///
  /// 成功调用该方法后，SDK 会触发 [RtcChannelEventHandler.channelMediaRelayEvent] 回调，
  /// 并在回调中报告状态码 [ChannelMediaRelayEvent.UpdateDestinationChannel]。
  ///
  /// **Note**
  /// - 请在 [RtcChannel.startChannelMediaRelay] 方法后调用该方法，
  /// 更新媒体流转发的频道。
  /// - 跨频道媒体流转发最多支持 4 个目标频道。
  ///
  /// **Parameter** [channelMediaRelayConfiguration] 跨频道媒体流转发参数配置。详见 [ChannelMediaRelayConfiguration]。
  Future<void> updateChannelMediaRelay(
      ChannelMediaRelayConfiguration channelMediaRelayConfiguration);

  /// 停止跨频道媒体流转发。
  ///
  /// 一旦停止，主播会退出所有目标频道。
  ///
  /// 成功调用该方法后，SDK 会触发 [RtcChannelEventHandler.channelMediaRelayStateChanged] 回调。
  /// 如果报告 [ChannelMediaRelayState.Idle] 和 [ChannelMediaRelayError.None]，则表示已停止转发媒体流。
  ///
  /// **Note**
  ///
  /// 如果该方法调用不成功，SDK 会触发 [RtcChannelEventHandler.channelMediaRelayStateChanged] 回调，
  /// 并报告状态码 [ChannelMediaRelayError.ServerNoResponse] 或 [ChannelMediaRelayError.ServerConnectionLost]。
  /// 你可以调用 [RtcChannel.leaveChannel] 方法离开频道，跨频道媒体流转发会自动停止。
  Future<void> stopChannelMediaRelay();
}

mixin RtcDualStreamInterface {
  /// 设置订阅的视频流类型。
  ///
  /// 在网络条件受限的情况下，如果发送端没有调用 [RtcEngine.enableDualStreamMode] 关闭双流模式，
  /// 接收端可以选择接收大流还是小流。其中，大流可以接为高分辨率高码率的视频流，小流则是低分辨率低码率的视频流。
  ///
  /// 正常情况下，用户默认接收大流。如需节约带宽和计算资源，则可以调用该方法动态调整对应远端视频流的大小。
  /// SDK 会根据该方法中的设置，切换大小流。
  ///
  /// 视频小流默认的宽高比和视频大流的宽高比一致。根据当前大流的宽高比，系统会自动分配小流的分辨率、帧率及码率。
  ///
  /// **Parameter** [uid] 远端用户的 ID。
  ///
  /// **Parameter** [streamType] 设置视频流大小类型。详见 [VideoStreamType]。
  Future<void> setRemoteVideoStreamType(int uid, VideoStreamType streamType);

  /// 设置默认订阅的视频流类型。
  /// **Parameter** [streamType] 设置视频流大小类型。详见 [VideoStreamType]。
  Future<void> setRemoteDefaultVideoStreamType(VideoStreamType streamType);
}

mixin RtcFallbackInterface {
  /// 设置用户媒体流优先级。
  ///
  /// 该方法可以与 [RtcEngine.setRemoteSubscribeFallbackOption] 搭配使用。
  /// 如果将某个用户的优先级设为高，那么发给这个用户的音视频流的优先级就会高于其他用户。
  ///
  /// **Note**
  ///
  /// Agora SDK 仅允许将一名远端用户设为高优先级。
  ///
  /// **Parameter** [uid] 远端用户的 ID。
  ///
  /// **Parameter** [userPriority] 远端用户的需求优先级。详见 [UserPriority]。
  Future<void> setRemoteUserPriority(int uid, UserPriority userPriority);
}

mixin RtcMediaMetadataInterface {
  /// 注册媒体 Metadata 观测器。
  ///
  /// 该接口通过在直播的视频帧中同步添加 Metadata，实现发送商品链接、分发优惠券、发送答题等功能，构建更为丰富的直播互动方式。
  ///
  /// **Note**
  /// - 请在调用 [RtcChannel.joinChannel] 加入频道前调用该方法。
  /// - 该方法仅适用于直播场景。
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

mixin RtcEncryptionInterface {
  /// 启用内置加密，并设置数据加密密码。
  ///
  /// **Deprecated**
  /// 自 v3.1.2 起废弃。请改用 [enableEncryption]。
  ///
  /// 如果需要启用加密，请在加入频道前调用该方法启用内置加密功能，并设置加密密码。
  ///
  /// 同一频道内的所有用户应设置相同的密码。 当用户离开频道时，该频道的密码会自动清除。
  /// 如果未指定密码或将密码设置为空，则无法激活加密功能。
  ///
  /// **Note**
  ///
  /// - 为保证最佳传输效果，请确保加密后的数据大小不超过原始数据大小 + 16 字节。
  /// 16 字节是 AES 通用加密模式下最大填充块大小。
  /// - 请勿在转码推流场景中使用该方法。
  ///
  /// **Parameter** [secret] 加密密码。
  Future<void> setEncryptionSecret(String secret);

  /// 设置内置的加密方案。
  ///
  /// **Deprecated**
  /// 自 v3.1.2 起废弃。请改用 [enableEncryption]。
  /// Agora SDK 支持内置加密功能，默认使用 `AES128XTS` 加密方式。如需使用其他加密方式，可以调用该 API 设置。
  ///
  /// 同一频道内的所有用户必须设置相同的加密方式和密码才能进行通话。关于这几种加密方式的区别，请参考 AES 加密算法的相关资料。
  ///
  /// **Note**
  /// - 请勿在转码推流场景中使用该方法。
  /// - 该方法需要在 [RtcChannel.setEncryptionSecret] 之后调用。
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
  ///
  /// **Parameter** [enabled] 是否开启内置加密：
  /// - `true`: 开启内置加密。
  /// - `false`: 关闭内置加密。
  ///
  /// **Parameter** [config] 配置内置加密模式和密钥。详见 [`EncryptionConfig`]{@link EncryptionConfig}。
  Future<void> enableEncryption(bool enabled, EncryptionConfig config);
}

}

mixin RtcInjectStreamInterface {
  /// 输入在线媒体流。
  ///
  /// 该方法通过在服务端拉取视频流并发送到频道中，将正在播出的视频输入到正在进行的直播中。可主要应用于赛事直播、多人看视频互动等直播场景。
  ///
  /// 调用该方法后，SDK 会在本地触发 [RtcChannelEventHandler.streamInjectedStatus] 回调，
  /// 报告输入在线媒体流的状态；成功输入媒体流后，该音视频流会出现在频道中，
  /// 频道内所有用户都会收到 [RtcChannelEventHandler.userJoined] (uid: 666)。
  ///
  /// **Note**
  /// - 调用该方法前，请确保已开通旁路推流的功能，详见进阶功能《推流到 CDN》中的前提条件。
  /// - 该方法仅适用于直播场景中的主播用户。
  ///
  /// **Parameter** [url] 添加到直播中的视频流 URL 地址，支持 RTMP， HLS， FLV 协议传输。
  /// - 支持的 FLV 音频编码格式：AAC。
  /// - 支持的 FLV 视频编码格式：H264 (AVC)。
  ///
  /// **Parameter** [config] [LiveInjectStreamConfig] 类，外部输入的音视频流的配置。
  Future<void> addInjectStreamUrl(String url, LiveInjectStreamConfig config);

  /// 删除输入的在线媒体流。
  ///
  /// 成功删除后，会触发 [RtcChannelEventHandler.userJoined] 回调，其中 `uid` 为 `666`。
  ///
  /// **Parameter** [url] 待删除的外部视频流 URL 地址，格式为 HTTP 或 HTTPS。
  Future<void> removeInjectStreamUrl(String url);
}

mixin RtcStreamMessageInterface {
  /// 创建数据流。
  ///
  /// 该方法用于创建数据流。[RtcChannel] 生命周期内，每个用户最多只能创建 5 个数据流。
  ///
  /// **Note**
  ///
  /// 请将 `reliable` 和 `ordered` 同时设置为 `true` 或 `false`，暂不支持交叉设置。
  ///
  /// **Parameter** [reliable] 设置是否保证接收方在 5 秒内收到数据消息：
  /// - `true`：接收方 5 秒内会收到发送方所发送的数据，否则会收到 [RtcChannelEventHandler.streamMessageError] 回调并获得相应报错信息。
  /// - `false`：接收方不保证收到，就算数据丢失也不会报错。
  ///
  /// **Parameter** [ordered] 设置接收方是否按发送方发送的顺序接收数据消息：
  /// - `true`：接收方会按照发送方发送的顺序收到数据包。
  /// - `false`：接收方不保证按照发送方发送的顺序收到数据包。
  ///
  /// **Returns**
  /// - 创建数据流成功则返回数据流 ID。
  /// - < 0：创建数据流失败。如果返回的错误码是负数，对应错误代码和警告代码里的正整数。
  Future<int> createDataStream(bool reliable, bool ordered);

  /// 发送数据流。
  ///
  /// 该方法发送数据流消息到频道内所有用户。SDK 对该方法的实现进行了如下限制：
  /// - 频道内每秒最多能发送 30 个包，且每个包最大为 1 KB。
  /// - 每个客户端每秒最多能发送 6 KB 数据。
  /// - 频道内每人最多能同时有 5 个数据通道。
  ///
  /// 成功调用该方法后，远端会触发 [RtcChannelEventHandler.streamMessage] 回调，远端用户可以在该回调中获取接收到的流消息；
  /// 若调用失败，远端会触发 [RtcChannelEventHandler.streamMessageError] 回调。
  ///
  /// **Parameter** [streamId] [RtcChannel.createDataStream] 方法返回的数据流 ID。
  ///
  /// **Parameter** [message] 待发送的数据，格式为 byte[]。
  Future<void> sendStreamMessage(int streamId, String message);
}
