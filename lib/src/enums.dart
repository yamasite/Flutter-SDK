import 'package:json_annotation/json_annotation.dart';

/// 访问区域。
enum AreaCode {
  /// 中国大陆。
  @JsonValue(0x00000001)
  CN,

  /// 北美区域。
  @JsonValue(0x00000002)
  NA,

  /// 欧洲区域。
  @JsonValue(0x00000004)
  EU,

  /// 除中国大陆以外的亚洲区域。
  @JsonValue(0x00000008)
  AS,

  /// 日本。
  @JsonValue(0x00000010)
  JP,

  /// 印度。
  @JsonValue(0x00000020)
  IN,

  /// （默认）全球。
  @JsonValue(-1)
  GLOB,
}

/// 用于旁路直播的输出音频的编码规格。
enum AudioCodecProfileType {
  /// (默认) LCAAC 规格，表示基本音频编码规格。
  @JsonValue(0)
  LCAAC,

  /// HEAAC 规格，表示高效音频编码规格。
  @JsonValue(1)
  HEAAC,
}

/// 语音音效均衡波段的中心频率。
enum AudioEqualizationBandFrequency {
  /// 31 Hz。
  @JsonValue(0)
  Band31,

  /// 62 Hz。
  @JsonValue(1)
  Band62,

  /// 125 Hz。
  @JsonValue(2)
  Band125,

  /// 250 Hz。
  @JsonValue(3)
  Band250,

  /// 500 Hz。
  @JsonValue(4)
  Band500,

  /// 1 kHz。
  @JsonValue(5)
  Band1K,

  /// 2 kHz。
  @JsonValue(6)
  Band2K,

  /// 4 kHz。
  @JsonValue(7)
  Band4K,

  /// 8 kHz。
  @JsonValue(8)
  Band8K,

  /// 16 kHz。
  @JsonValue(9)
  Band16K,
}

/// 本地音频出错原因。
enum AudioLocalError {
  /// 本地音频状态正常。
  @JsonValue(0)
  Ok,

  /// 本地音频出错原因不明确。
  @JsonValue(1)
  Failure,

  /// 没有权限启动本地音频录制设备。
  @JsonValue(2)
  DeviceNoPermission,

  /// 本地音频录制设备已经在使用中。
  @JsonValue(3)
  DeviceBusy,

  /// 本地音频录制失败，建议你检查录制设备是否正常工作。
  @JsonValue(4)
  RecordFailure,

  /// 本地音频编码失败。
  @JsonValue(5)
  EncodeFailure,

  /// 本地音频采集被系统电话中断。
  @JsonValue(8)
  Interrupted,
}

/// 本地音频状态。
enum AudioLocalState {
  /// 本地音频默认初始状态。
  @JsonValue(0)
  Stopped,

  /// 本地音频录制设备启动成功。
  @JsonValue(1)
  Recording,

  /// 本地音频首帧编码成功。
  @JsonValue(2)
  Encoding,

  /// 本地音频启动失败。
  @JsonValue(3)
  Failed,
}

/// 混音音乐文件错误码。
enum AudioMixingReason {
  /// 音乐文件打开出错。
  @JsonValue(701)
  CanNotOpen,

  /// 音乐文件打开太频繁。
  @JsonValue(702)
  TooFrequentCall,

  /// 自 v3.4.5 起废弃。请改用以 AUDIO_MIXING_REASON 为前缀的相关常量。
  @JsonValue(703)
  InterruptedEOF,

  /// 成功调用 `startAudioMixing` 开始音频文件的播放。
  @JsonValue(720)
  StartedByUser,

  /// 内部使用
  @JsonValue(721)
  OneLoopCompleted,

  /// 内部使用
  @JsonValue(722)
  StartNewLoop,

  /// 内部使用
  @JsonValue(723)
  AllLoopsCompleted,

  /// 内部使用
  @JsonValue(724)
  StoppedByUser,

  /// 内部使用
  @JsonValue(725)
  PausedByUser,

  /// 内部使用
  @JsonValue(726)
  ResumedByUser,

  /// 无错误。
  @JsonValue(0)
  OK,
}

/// 混音音乐文件状态。
enum AudioMixingStateCode {
  /// 音乐文件正常播放。
  @JsonValue(710)
  Playing,

  /// 音乐文件暂停播放。
  @JsonValue(711)
  Paused,

  /// 音乐文件停止播放。
  @JsonValue(713)
  Stopped,

  /// 音乐文件报错。
  @JsonValue(714)
  Failed,
}

/// 语音路由。
enum AudioOutputRouting {
  /// 使用默认的音频路由。
  @JsonValue(-1)
  Default,

  /// 使用耳机为语音路由。
  @JsonValue(0)
  Headset,

  /// 使用听筒为语音路由。
  @JsonValue(1)
  Earpiece,

  /// 使用不带麦的耳机为语音路由。
  @JsonValue(2)
  HeadsetNoMic,

  /// 使用手机的扬声器为语音路由。
  @JsonValue(3)
  Speakerphone,

  /// 使用外接的扬声器为语音路由。
  @JsonValue(4)
  Loudspeaker,

  /// 使用蓝牙耳机为语音路由。
  @JsonValue(5)
  HeadsetBluetooth,
}

/// 音频属性。
enum AudioProfile {
  ///默认设置。
  /// - 通信场景下，该选项代表指定 32 kHz 采样率，语音编码，单声道，编码码率最大值为 18 Kbps。
  /// - 直播场景下，该选项代表指定 48 kHz 采样率，音乐编码，单声道，编码码率最大值为 64 Kbps。
  @JsonValue(0)
  Default,

  /// 指定 32 kHz 采样率，语音编码，单声道，编码码率最大值为 18 Kbps。
  @JsonValue(1)
  SpeechStandard,

  /// 指定 48 kHz 采样率，音乐编码，单声道，编码码率最大值为 64 Kbps。
  @JsonValue(2)
  MusicStandard,

  /// 指定 48 kHz采样率，音乐编码，双声道，编码码率最大值为 80 Kbps。
  @JsonValue(3)
  MusicStandardStereo,

  /// 指定 48 kHz 采样率，音乐编码，单声道，编码码率最大值为 96 Kbps。
  @JsonValue(4)
  MusicHighQuality,

  /// 指定 48 kHz 采样率，音乐编码，双声道，编码码率最大值为 128 Kbps。
  @JsonValue(5)
  MusicHighQualityStereo,
}

/// 录音质量。
enum AudioRecordingQuality {
  /// 低音质。采样率为 32 kHz，录制 10 分钟的文件大小为 1.2 M 左右。
  @JsonValue(0)
  Low,

  /// 中音质。采样率为 32 kHz，录制 10 分钟的文件大小为 2 M 左右。
  @JsonValue(1)
  Medium,

  /// 高音质。采样率为 32 kHz，录制 10 分钟的文件大小为 3.75 M 左右。
  @JsonValue(2)
  High,
}

enum AudioRecordingPosition {
  /// （默认）录制本地和所有远端用户混音后的音频。
  @JsonValue(0)
  PositionMixedRecordingAndPlayback,

  /// 仅录制本地用户的音频。
  @JsonValue(1)
  PositionRecording,

  /// 仅录制所有远端用户的音频。
  @JsonValue(2)
  PositionMixedPlayback,
}

/// 远端音频流状态。
enum AudioRemoteState {
  /// 远端音频流默认初始状态。在以下情况下，会报告该状态：
  /// - [AudioRemoteStateReason.LocalMuted]
  /// - [AudioRemoteStateReason.RemoteMuted]
  /// - [AudioRemoteStateReason.RemoteOffline]
  @JsonValue(0)
  Stopped,

  /// 本地用户已接收远端音频首包。
  @JsonValue(1)
  Starting,

  /// 远端音频流正在解码，正常播放。在以下情况下，会报告该状态：
  /// - [AudioRemoteStateReason.NetworkRecovery]
  /// - [AudioRemoteStateReason.LocalUnmuted]
  /// - [AudioRemoteStateReason.RemoteUnmuted]
  @JsonValue(2)
  Decoding,

  /// 远端音频流卡顿。在以下情况下，会报告该状态：
  /// - [AudioRemoteStateReason.NetworkCongestion]
  @JsonValue(3)
  Frozen,

  /// 远端音频流播放失败。在以下情况下，会报告该状态：
  /// - [AudioRemoteStateReason.Internal]
  @JsonValue(4)
  Failed,
}

/// 远端音频流状态改变的原因。
enum AudioRemoteStateReason {
  /// 内部原因。
  @JsonValue(0)
  Internal,

  /// 网络阻塞。
  @JsonValue(1)
  NetworkCongestion,

  /// 网络恢复正常。
  @JsonValue(2)
  NetworkRecovery,

  /// 本地用户停止接收远端音频流或本地用户禁用音频模块。
  @JsonValue(3)
  LocalMuted,

  /// 本地用户恢复接收远端音频流或本地用户启用音频模块。
  @JsonValue(4)
  LocalUnmuted,

  /// 远端用户停止发送音频流或远端用户禁用音频模块。
  @JsonValue(5)
  RemoteMuted,

  /// 远端用户恢复发送音频流或远端用户启用音频模块。
  @JsonValue(6)
  RemoteUnmuted,

  /// 远端用户离开频道。
  @JsonValue(7)
  RemoteOffline,
}

/// 预设的本地语音混响效果选项。
enum AudioReverbPreset {
  /// 原声，即关闭本地语音混响。
  @JsonValue(0x00000000)
  Off,

  /// 流行。
  @JsonValue(0x00000001)
  Popular,

  /// R&B。
  @JsonValue(0x00000002)
  RnB,

  /// 摇滚。
  @JsonValue(0x00000003)
  Rock,

  /// 嘻哈。
  @JsonValue(0x00000004)
  HipHop,

  /// 演唱会。
  @JsonValue(0x00000005)
  VocalConcert,

  /// KTV。
  @JsonValue(0x00000006)
  KTV,

  /// 录音棚。
  @JsonValue(0x00000007)
  Studio,

  /// KTV（增强版）。
  @JsonValue(0x00100001)
  FX_KTV,

  /// 演唱会（增强版）。
  @JsonValue(0x00100002)
  FX_VOCAL_CONCERT,

  /// 大叔。
  @JsonValue(0x00100003)
  FX_UNCLE,

  /// 小姐姐。
  @JsonValue(0x00100004)
  FX_SISTER,

  /// 录音棚（增强版）。
  @JsonValue(0x00100005)
  FX_STUDIO,

  /// 流行（增强版）。
  @JsonValue(0x00100006)
  FX_POPULAR,

  /// R&B（增强版）。
  @JsonValue(0x00100007)
  FX_RNB,

  /// 留声机。
  @JsonValue(0x00100008)
  FX_PHONOGRAPH,

  /// 虚拟立体声。虚拟立体声是指将单声道的音轨渲染出立体声的效果，使频道内所有用户听到有空间感的声音效果。为达到更好的虚拟立体声效果，
  /// Agora 推荐在调用该方法前将 [RtcEngine.setAudioProfile] 的 `profile` 参数设置为 [AudioProfile.MusicHighQualityStereo](5)。
  @JsonValue(0x00200001)
  VIRTUAL_STEREO,
}

/// 音频混响类型。
enum AudioReverbType {
  /// 原始声音强度，即所谓的 dry signal，取值范围 [-20,10]，单位为 dB。
  @JsonValue(0)
  DryLevel,

  /// 早期反射信号强度，即所谓的 wet signal，取值范围 [-20,10]，单位为 dB。
  @JsonValue(1)
  WetLevel,

  /// 所需混响效果的房间尺寸，一般房间越大，混响越强，取值范围 [0,100]，单位为 dB。
  @JsonValue(2)
  RoomSize,

  /// Wet signal 的初始延迟长度，取值范围 [0,200]，单位为毫秒。
  @JsonValue(3)
  WetDelay,

  /// 混响持续的强度，取值范围为 [0,100]。
  @JsonValue(4)
  Strength,
}

/// 音频采样率。
enum AudioSampleRateType {
  /// 32 kHz。
  @JsonValue(32000)
  Type32000,

  /// 44.1 kHz。
  @JsonValue(44100)
  Type44100,

  /// 48 kHz。
  @JsonValue(48000)
  Type48000,
}

/// 音频应用场景。
enum AudioScenario {
  /// 默认音频应用场景。
  @JsonValue(0)
  Default,

  /// 娱乐应用，需要频繁上下麦的场景。
  @JsonValue(1)
  ChatRoomEntertainment,

  /// 教育应用，流畅度和稳定性优先。
  @JsonValue(2)
  Education,

  /// 游戏直播应用，需要外放游戏音效也直播出去的场景。
  @JsonValue(3)
  GameStreaming,

  /// 秀场应用，音质优先和更好的专业外设支持。
  @JsonValue(4)
  ShowRoom,

  /// 游戏开黑。
  @JsonValue(5)
  ChatRoomGaming,

  /// IoT（物联网）场景，适用于使用低功耗 IoT 设备的场景。
  @JsonValue(6)
  IOT,

  /// 会议场景，适用于人声为主的多人会议。
  ///
  /// 自从 v3.2.1
  @JsonValue(8)
  MEETING,
}

/// 本地语音变声、美音或语聊美声效果选项。
enum AudioVoiceChanger {
  /// 原声，即关闭本地语音的变声、美音或语聊美声效果。
  @JsonValue(0x00000000)
  Off,

  /// 变声：老年男性。
  @JsonValue(0x00000001)
  OldMan,

  /// 变声：小男孩。
  @JsonValue(0x00000002)
  BabyBoy,

  /// 变声：小女孩。
  @JsonValue(0x00000003)
  BabyGirl,

  /// 变声：猪八戒。
  @JsonValue(0x00000004)
  ZhuBaJie,

  /// 变声：空灵。
  @JsonValue(0x00000005)
  Ethereal,

  /// 变声：绿巨人。
  @JsonValue(0x00000006)
  Hulk,

  /// 美音：浑厚。
  @JsonValue(0x00100001)
  BEAUTY_VIGOROUS,

  /// 美音：低沉。
  @JsonValue(0x00100002)
  BEAUTY_DEEP,

  /// 美音：圆润。
  @JsonValue(0x00100003)
  BEAUTY_MELLOW,

  /// 美音：假音。
  @JsonValue(0x00100004)
  BEAUTY_FALSETTO,

  /// 美音：饱满。
  @JsonValue(0x00100005)
  BEAUTY_FULL,

  /// 美音：清澈。
  @JsonValue(0x00100006)
  BEAUTY_CLEAR,

  /// 美音：高亢。
  @JsonValue(0x00100007)
  BEAUTY_RESOUNDING,

  /// 美音：嘹亮。
  @JsonValue(0x00100008)
  BEAUTY_RINGING,

  /// 美音：空旷。
  @JsonValue(0x00100009)
  BEAUTY_SPACIAL,

  /// 语聊美声：磁性（男）。此枚举为男声定制化效果，不适用于女声。若女声使用此音效设置，则音频可能会产生失真。
  @JsonValue(0x00200001)
  GENERAL_BEAUTY_VOICE_MALE_MAGNETIC,

  /// 语聊美声：清新（女）。此枚举为女声定制化效果，不适用于男声。若男声使用此音效设置，则音频可能会产生失真。
  @JsonValue(0x00200002)
  GENERAL_BEAUTY_VOICE_FEMALE_FRESH,

  /// 语聊美声：活力（女）。此枚举为女声定制化效果，不适用于男声。若男声使用此音效设置，则音频可能会产生失真。
  @JsonValue(0x00200003)
  GENERAL_BEAUTY_VOICE_FEMALE_VITALITY,
}

/// 设置摄像头采集偏好。
enum CameraCaptureOutputPreference {
  /// （默认）自动调整采集参数。SDK 根据实际的采集设备性能及网络情况，选择合适的摄像头输出参数，从而保证设备性能。在这种情况下，预览质量接近于编码器的输出质量。
  @JsonValue(0)
  Auto,

  /// 优先保证设备性能。SDK 根据你在 `setVideoEncoderConfiguration` 中设置编码器的分辨率和帧率，选择最接近的摄像头输出参数，从而保证设备性能。在这种情况下，预览质量接近于编码器的输出质量。
  /// 详见 [RtcEngine.setVideoEncoderConfiguration]。
  @JsonValue(1)
  Performance,

  /// 优先保证视频预览质量。SDK选择较高的摄像头输出参数，从而提高预览视频的质量。在这种情况下，会消耗更多的 CPU 及内存做视频前处理。
  @JsonValue(2)
  Preview,

  /// 允许你设置本地摄像头采集的视频宽高。
  @JsonValue(3)
  Manual,
}

/// 设置摄像头方向。
enum CameraDirection {
  /// 使用后置摄像头。
  @JsonValue(0)
  Rear,

  /// 使用前置摄像头。
  @JsonValue(1)
  Front,
}

/// 跨频道媒体流转发出错的错误码。
enum ChannelMediaRelayError {
  /// 一切正常。
  @JsonValue(0)
  None,

  /// 服务器回应出错。
  @JsonValue(1)
  ServerErrorResponse,

  /// 服务器无回应。你可以调用 `leaveChannel` 方法离开频道。
  /// 详见 [RtcEngine.leaveChannel]。
  @JsonValue(2)
  ServerNoResponse,

  /// SDK 无法获取服务，可能是因为服务器资源有限导致。
  @JsonValue(3)
  NoResourceAvailable,

  /// 发起跨频道转发媒体流请求失败。
  @JsonValue(4)
  FailedJoinSourceChannel,

  /// 接受跨频道转发媒体流请求失败。
  @JsonValue(5)
  FailedJoinDestinationChannel,

  /// 服务器接收跨频道转发媒体流失败。
  @JsonValue(6)
  FailedPacketReceivedFromSource,

  /// 服务器发送跨频道转发媒体流失败。
  @JsonValue(7)
  FailedPacketSentToDestination,

  /// SDK 因网络质量不佳与服务器断开。你可以调用 [RtcEngine.leaveChannel] 方法离开当前频道。
  @JsonValue(8)
  ServerConnectionLost,

  ///服务器内部出错。
  @JsonValue(9)
  InternalError,

  /// 源频道的 Token 已过期。
  @JsonValue(10)
  SourceTokenExpired,

  /// 目标频道的 Token 已过期。
  @JsonValue(11)
  DestinationTokenExpired,
}

/// 跨频道媒体流转发事件码。
enum ChannelMediaRelayEvent {
  /// 网络中断导致用户与服务器连接断开。
  @JsonValue(0)
  Disconnect,

  /// 用户与服务器建立连接。
  @JsonValue(1)
  Connected,

  /// 用户已加入源频道。
  @JsonValue(2)
  JoinedSourceChannel,

  /// 用户已加入目标频道。
  @JsonValue(3)
  JoinedDestinationChannel,

  /// SDK 开始向目标频道发送数据包。
  @JsonValue(4)
  SentToDestinationChannel,

  /// 服务器收到了源标频道发送的视频流。
  @JsonValue(5)
  ReceivedVideoPacketFromSource,

  /// 服务器收到了源标频道发送的音频流。
  @JsonValue(6)
  ReceivedAudioPacketFromSource,

  /// 目标频道已更新。
  @JsonValue(7)
  UpdateDestinationChannel,

  /// 内部原因导致目标频道更新失败。
  @JsonValue(8)
  UpdateDestinationChannelRefused,

  /// 目标频道未发生改变，即目标频道更新失败。
  @JsonValue(9)
  UpdateDestinationChannelNotChange,

  /// 目标频道名为 NULL。
  @JsonValue(10)
  UpdateDestinationChannelIsNil,

  /// 视频属性已发送至服务器。
  @JsonValue(11)
  VideoProfileUpdate,
}

/// 跨频道媒体流转发状态。
enum ChannelMediaRelayState {
  /// SDK 正在初始化。
  @JsonValue(0)
  Idle,

  /// SDK 尝试跨频道。
  @JsonValue(1)
  Connecting,

  /// 源频道主播成功加入目标频道。
  @JsonValue(2)
  Running,

  /// 发生异常，详见 `code` 中提示的错误信息。
  @JsonValue(3)
  Failure,
}

/// 频道场景。
enum ChannelProfile {
  /// 通信场景（默认）。
  /// 用于常见的一对一通话或群聊，频道中的任何用户可以自由说话。
  @JsonValue(0)
  Communication,

  /// 直播场景。
  /// 直播场景有主播和观众两种用户角色，可以通过 `setClientRole` 方法设置主播和观众的角色。
  /// 主播可以收发语音/视频流，而观众只能接收语音/视频，无法发送。
  @JsonValue(1)
  LiveBroadcasting,

  /// 游戏语音场景。
  /// 频道内的任何一个可以自由对话。该模式默认采用低功耗低码率的编解码。
  @JsonValue(2)
  Game,
}

/// 直播场景里的用户角色。
enum ClientRole {
  /// 直播主播。
  @JsonValue(1)
  Broadcaster,

  /// 直播观众（默认）。
  @JsonValue(2)
  Audience,
}

/// 网络连接状态发生改变的原因。
enum ConnectionChangedReason {
  /// 建立网络连接中。
  @JsonValue(0)
  Connecting,

  /// 成功加入频道。
  @JsonValue(1)
  JoinSuccess,

  /// 网络连接中断。
  @JsonValue(2)
  Interrupted,

  /// 网络连接被服务器禁止。
  @JsonValue(3)
  BannedByServer,

  /// 加入频道失败。SDK 在尝试加入频道 20 分钟后还是没能加入频道，会返回该状态，并停止尝试重连。
  @JsonValue(4)
  JoinFailed,

  /// 离开频道。
  @JsonValue(5)
  LeaveChannel,

  /// 不是有效的 APP ID。请更换有效的 APP ID 重新加入频道。
  @JsonValue(6)
  InvalidAppId,

  /// 不是有效的频道名。请更换有效的频道名重新加入频道。
  @JsonValue(7)
  InvalidChannelName,

  /// 生成的 Token 无效。一般有以下原因：
  /// - 在控制台上启用了 App Certificate，但加入频道未使用 Token。当启用了 App Certificate，必须使用 Token。
  /// - 在调用 [RtcEngine.joinChannel] 加入频道时指定的 uid 与生成 Token 时传入的 uid 不一致。
  @JsonValue(8)
  InvalidToken,

  /// 当前使用的 Token 过期，不再有效，需要重新在你的服务端申请生成 Token。
  @JsonValue(9)
  TokenExpired,

  /// 此用户被服务器禁止。
  @JsonValue(10)
  RejectedByServer,

  ///  由于设置了代理服务器，SDK 尝试重连。
  @JsonValue(11)
  SettingProxyServer,

  /// 更新 Token 引起网络连接状态改变。
  @JsonValue(12)
  RenewToken,

  /// 客户端 IP 地址变更，可能是由于网络类型，或网络运营商的 IP 或端口发生改变引起。
  @JsonValue(13)
  ClientIpAddressChanged,

  /// SDK 和服务器连接保活超时，进入自动重连状态。
  /// 详见 [ConnectionStateType.Reconnecting]。
  @JsonValue(14)
  KeepAliveTimeout,

  /// 在云代理模式下，与云代理服务器的连接中断。
  @JsonValue(15)
  ProxyServerInterrupted,
}

/// 网络连接状态。
enum ConnectionStateType {
  /// 网络连接断开。该状态表示 SDK 处于：
  /// - 调用 [RtcEngine.joinChannel] 加入频道前的初始化阶段。
  /// - 调用 [RtcEngine.leaveChannel] 后的离开频道阶段。
  @JsonValue(1)
  Disconnected,

  /// 建立网络连接中。
  /// - 该状态表示 SDK 在调用 [RtcEngine.joinChannel] 后正在与指定的频道建立连接。
  /// - 如果成功加入频道，App 会收到 [RtcEngineEventHandler.connectionStateChanged] 回调，通知当前网络状态变成 [ConnectionStateType.Connected]。
  /// - 建立连接后，SDK 还会处理媒体初始化，一切就绪后会回调 [RtcEngineEventHandler.joinChannelSuccess]。
  @JsonValue(2)
  Connecting,

  /// 网络已连接。该状态表示用户已经加入频道，可以在频道内发布或订阅媒体流。如果因网络断开或切换而导致 SDK 与频道的连接中断，SDK 会自动重连，此时 App 会收到：
  /// - [RtcEngineEventHandler.connectionStateChanged] 回调，通知当前网络状态变成 [ConnectionStateType.Reconnecting]。
  @JsonValue(3)
  Connected,

  /// 重新建立网络连接中。
  ///
  /// 该状态表示 SDK 之前曾加入过频道，但因网络等原因连接中断了，此时 SDK 会自动尝试重新接入频道。
  /// - 如果 SDK 无法在 10 秒内重新加入频道，则 [RtcEngineEventHandler.connectionLost] 会被触发，SDK 会一直保持在 `Reconnecting` 的状态，并不断尝试重新加入频道。
  /// - 如果 SDK 在断开连接后，20 分钟内还是没能重新加入频道，App 会收到 [RtcEngineEventHandler.connectionStateChanged] 回调，通知当前网络状态进入 `Failed`，SDK 停止尝试重连。
  @JsonValue(4)
  Reconnecting,

  /// 网络连接失败。
  ///
  /// 该状态表示 SDK 已不再尝试重新加入频道，用户必须要调用 [RtcEngine.leaveChannel] 离开频道。
  ///
  /// 如果 SDK 因服务器端使用 RESTful API 禁止加入频道，则 App 会收到 [RtcEngineEventHandler.connectionStateChanged] 回调。
  @JsonValue(5)
  Failed,
}

/// 带宽受限时，视频编码降级偏好。
enum DegradationPreference {
  /// （默认）降低编码帧率以保证视频质量。
  @JsonValue(0)
  MaintainQuality,

  /// 降低视频质量以保证编码帧率。
  @JsonValue(1)
  MaintainFramerate,

  /// 预留参数，暂不支持。
  @JsonValue(2)
  MaintainBalanced
}

/// 加密模式。
enum EncryptionMode {
  /// **Deprecated**
  /// 该模式已废弃。
  @deprecated
  @JsonValue(0)
  None,

  /// （默认）128 位 AES 加密，XTS 模式。
  @JsonValue(1)
  AES128XTS,

  /// 128 位 AES 加密，ECB 模式。
  @JsonValue(2)
  AES128ECB,

  /// 256 位 AES 加密，XTS 模式。
  @JsonValue(3)
  AES256XTS,

  /// @nodoc 128 位 SM4 加密，ECB 模式。
  @JsonValue(4)
  SM4128ECB,

  /// 128 位 AES 加密, GCM 模式。
  @JsonValue(5)
  AES128GCM,

  /// 256 位 AES 加密, GCM 模式。
  @JsonValue(6)
  AES256GCM,

  /// （默认）128 位 AES 加密，GCM 模式。相比于 `AES128GCM` 加密模式，`AES128GCM2` 加密模式安全性更高且需要设置盐 （`encryptionKdfSalt`）。
  @JsonValue(7)
  AES128GCM2,

  /// 256 位 AES 加密，GCM 模式。相比于 `AES256GCM` 加密模式，`AES256GCM2` 加密模式安全性更高且需要设置盐 （`encryptionKdfSalt`）。
  @JsonValue(8)
  AES256GCM2,
}

/// 错误代码。SDK 上报的错误意味着 SDK 无法自动恢复，需要 App 干预或提示用户。
enum ErrorCode {
  /// 没有错误。
  @JsonValue(0)
  NoError,

  /// 一般性的错误（没有明确归类的错误原因）。
  @JsonValue(1)
  Failed,

  /// API 调用了无效的参数。例如指定的频道名含有非法字符。
  @JsonValue(2)
  InvalidArgument,

  /// SDK 初始化失败。Agora 建议尝试以下处理方法：
  /// - 检查音频设备状态。
  /// - 检查程序集完整性。
  /// - 尝试重新初始化 SDK。
  @JsonValue(3)
  NotReady,

  /// SDK 当前状态不支持此操作。
  @JsonValue(4)
  NotSupported,

  /// 调用被拒绝。仅供 SDK 内部使用，不通过 API 或者回调事件返回给 App。
  @JsonValue(5)
  Refused,

  /// 传入的缓冲区大小不足以存放返回的数据。
  @JsonValue(6)
  BufferTooSmall,

  /// SDK 尚未初始化，就调用其 API。请确认在调用 API 之前已创建 `RtcEngine` 对象并完成初始化。
  @JsonValue(7)
  NotInitialized,

  /// 没有操作权限。请检查用户是否授予 app 音视频设备使用权限。
  @JsonValue(9)
  NoPermission,

  /// API 调用超时。有些 API 调用需要 SDK 返回结果，如果 SDK 处理时间过长，超过 10 秒没有返回，会出现此错误。
  @JsonValue(10)
  TimedOut,

  /// 请求被取消。仅供 SDK 内部使用，不通过 API 或者回调事件返回给 App。
  @JsonValue(11)
  Canceled,

  /// 调用频率太高。仅供 SDK 内部使用，不通过 API 或者回调事件返回给 App。
  @JsonValue(12)
  TooOften,

  /// SDK 内部绑定到网络 Socket 失败。仅供 SDK 内部使用，不通过 API 或者回调事件返回给 App。
  @JsonValue(13)
  BindSocket,

  /// 网络不可用。仅供 SDK 内部使用，不通过 API 或者回调事件返回给 App。
  @JsonValue(14)
  NetDown,

  /// 没有网络缓冲区可用。仅供 SDK 内部使用，不通过 API 或者回调事件返回给 App。
  @JsonValue(15)
  NoBufs,

  /// 加入频道被拒绝。一般有以下原因：
  /// - 用户已进入频道，再次调用加入频道的 API，例如 `joinChannel`，会返回此错误。停止调用该方法即可。
  /// 详见 [RtcEngine.joinChannel]。
  /// - 用户在做 Echo 测试时尝试加入频道。等待 Echo test 结束后再加入频道即可。
  @JsonValue(17)
  JoinChannelRejected,

  /// 离开频道失败。一般有以下原因：
  /// - 用户已离开频道，再次调用退出频道的 API，例如 `leaveChannel`，会返回此错误。停止调用该方法即可。
  /// 详见 [RtcEngine.leaveChannel]。
  /// - 用户尚未加入频道，就调用退出频道的 API。这种情况下无需额外操作。
  @JsonValue(18)
  LeaveChannelRejected,

  /// 资源已被占用，不能重复使用。
  @JsonValue(19)
  AlreadyInUse,

  /// SDK 放弃请求，可能由于请求次数太多。
  @JsonValue(20)
  Abort,

  /// Windows 下特定的防火墙设置导致 SDK 初始化失败然后崩溃。
  @JsonValue(21)
  InitNetEngine,

  /// App 占用系统资源过多，SDK 分配资源失败。
  @JsonValue(22)
  ResourceLimited,

  /// 不是有效的 APP ID。请更换有效的 APP ID 重新加入频道。
  @JsonValue(101)
  InvalidAppId,

  /// 不是有效的频道名。请更换有效的频道名重新加入频道。
  @JsonValue(102)
  InvalidChannelId,

  /// 没有服务器资源，请尝试设置其他区域代码。
  ///
  ///
  @JsonValue(103)
  NoServerResources,

  /// 当前使用的 Token 过期，不再有效。
  ///
  /// **Deprecated** 已废弃。
  ///
  /// 请改用 [RtcEngineEventHandler.connectionStateChanged] 回调中的 `TokenExpired`。
  /// 详见 [RtcEngineEventHandler.connectionStateChanged] 和 [ConnectionChangedReason.TokenExpired]。
  ///
  /// 一般有以下原因：
  /// - Token 授权时间戳无效：Token 授权时间戳为 Token 生成时的时间戳，自 1970 年 1 月 1 日开始到当前时间的描述。
  /// 授权该 Token 在生成后的 24 小时内可以访问 Agora 服务。如果 24 小时内没有访问，则该 Token 无法再使用。需要重新在服务端申请生成 Token。
  /// - Token 服务到期时间戳已过期：用户设置的服务到期时间戳小于当前时间戳，无法继续使用 Agora 服务（比如正在进行的通话会被强制终止）；
  /// 设置服务到期时间并不意味着 Token 失效，而仅仅用于限制用户使用当前服务的时间。需要重新在服务端申请生成 Token。
  @deprecated
  @JsonValue(109)
  TokenExpired,

  /// 生成的 Token 无效。
  ///
  /// **Deprecated** 已废弃。请改用 `connectionStateChanged` 回调中的 `InvalidToken`。
  /// 详见 [RtcEngineEventHandler.connectionStateChanged] 和 [ConnectionChangedReason.InvalidToken]。
  ///
  /// 一般有以下原因：
  /// - 用户在控制台上启用了 App Certificate，但仍旧在代码里仅使用了 App ID。当启用了 App Certificate，必须使用 Token。
  /// - 字段 `uid` 为生成 Token 的必须字段，用户在调用 `joinChannel` 加入频道时必须设置相同的 `uid`。
  @deprecated
  @JsonValue(110)
  InvalidToken,

  /// 网络连接中断。仅适用于 Agora Web SDK。
  @JsonValue(111)
  ConnectionInterrupted,

  /// 网络连接丢失。仅适用于 Agora Web SDK。
  @JsonValue(112)
  ConnectionLost,

  /// 调用 [RtcEngine.sendStreamMessage] 或 [RtcEngine.getUserInfoByUserAccount] 方法时，用户不在频道内。
  @JsonValue(113)
  NotInChannel,

  /// 在调用 [RtcEngine.sendStreamMessage] 时，当发送的数据长度大于 1024 个字节时，会发生该错误。
  @JsonValue(114)
  SizeTooLarge,

  /// 在调用 [RtcEngine.sendStreamMessage] 时，当发送的数据码率超过限制（6 KB/s）时，会发生该错误。
  @JsonValue(115)
  BitrateLimit,

  /// 在调用 [RtcEngine.createDataStream] 时，如果创建的数据通道过多（超过 5 个通道），会发生该错误。
  @JsonValue(116)
  TooManyDataStreams,

  /// 解密失败，可能是用户加入频道用了不同的密码。请检查加入频道时的设置，或尝试重新加入频道。
  @JsonValue(120)
  DecryptionFailed,

  /// 此用户被服务器禁止。
  @JsonValue(123)
  ClientIsBannedByServer,

  /// 水印文件参数错误。
  @JsonValue(124)
  WatermarkParam,

  /// 水印文件路径错误。
  @JsonValue(125)
  WatermarkPath,

  /// 水印文件格式错误。
  @JsonValue(126)
  WatermarkPng,

  /// 水印文件信息错误。
  @JsonValue(127)
  WatermarkInfo,

  /// 水印文件数据格式错误。
  @JsonValue(128)
  WatermarkAGRB,

  /// 水印文件读取错误。
  @JsonValue(129)
  WatermarkRead,

  /// 不支持发送加密流。
  @JsonValue(130)
  EncryptedStreamNotAllowedPublish,

  /// 无效的 User account。
  @JsonValue(134)
  InvalidUserAccount,

  /// CDN 相关错误。请调用 [RtcEngine.removePublishStreamUrl] 方法删除原来的推流地址，然后调用 [RtcEngine.addPublishStreamUrl] 方法重新推流到新地址。
  @JsonValue(151)
  PublishStreamCDNError,

  /// 单个主播的推流地址数目达到上限 10。请删掉一些不用的推流地址再增加推流地址。
  @JsonValue(152)
  PublishStreamNumReachLimit,

  /// 操作不属于主播自己的流，如更新其他主播的流参数、停止其他主播的流。请检查 App 逻辑。
  @JsonValue(153)
  PublishStreamNotAuthorized,

  /// 推流服务器出现错误。请调用 [RtcEngine.addPublishStreamUrl] 重新推流。
  @JsonValue(154)
  PublishStreamInternalServerError,

  /// 服务器未找到这个流。
  @JsonValue(155)
  PublishStreamNotFound,

  /// 推流地址格式有错误。请检查推流地址格式是否正确。
  @JsonValue(156)
  PublishStreamFormatNotSuppported,

  /// 未集成 AI 降噪库。
  @JsonValue(157)
  ModuleNotFound,

  /// 客户端正在录音。如需开始新的录音，请先调用 [RtcEngine.stopAudioRecording] 停止当前录音，再调用 [RtcEngine.startAudioRecording]。
  @JsonValue(160)
  AlreadyInRecording,

  /// 加载媒体引擎失败。
  @JsonValue(1001)
  LoadMediaEngine,

  /// 启动媒体引擎开始通话失败。请尝试重新进入频道。
  @JsonValue(1002)
  StartCall,

  /// 启动摄像头失败，请检查摄像头是否被其他应用占用，或者尝试重新进入频道。
  ///
  /// **Deprecated**
  /// 已废弃。请改用 `localVideoStateChanged` 回调中的 `CaptureFailure`(4)。
  /// 详见 [LocalVideoStreamError.CaptureFailure] 和 [RtcEngineEventHandler.localVideoStateChanged]。
  @deprecated
  @JsonValue(1003)
  StartCamera,

  /// 启动视频渲染模块失败。
  @JsonValue(1004)
  StartVideoRender,

  /// 音频设备模块：音频设备出现错误（未明确指明为何种错误）。请检查音频设备是否被其他应用占用，或者尝试重新进入频道。
  @JsonValue(1005)
  AdmGeneralError,

  /// 音频设备模块：使用 java 资源出现错误。
  @JsonValue(1006)
  AdmJavaResource,

  /// 音频设备模块：设置的采样频率出现错误。
  @JsonValue(1007)
  AdmSampleRate,

  /// 音频设备模块：初始化播放设备出现错误。请检查播放设备是否被其他应用占用，或者尝试重新进入频道。
  @JsonValue(1008)
  AdmInitPlayout,

  /// 音频设备模块：启动播放设备出现错误。请检查播放设备是否正常，或者尝试重新进入频道。
  @JsonValue(1009)
  AdmStartPlayout,

  /// 音频设备模块：停止播放设备出现错误。
  @JsonValue(1010)
  AdmStopPlayout,

  /// 音频设备模块：初始化录音设备时出现错误。请检查录音设备是否正常，或者尝试重新进入频道。
  @JsonValue(1011)
  AdmInitRecording,

  /// 音频设备模块：启动录音设备出现错误。请检查录音设备是否正常，或者尝试重新进入频道
  @JsonValue(1012)
  AdmStartRecording,

  /// 音频设备模块：停止录音设备出现错误。
  @JsonValue(1013)
  AdmStopRecording,

  /// 音频设备模块：运行时播放出现错误。请检查播放设备是否正常，或者尝试重新进入频道。
  @JsonValue(1015)
  AdmRuntimePlayoutError,

  /// 音频设备模块：运行时录音错误。请检查录音设备是否正常，或者尝试重新进入频道。
  @JsonValue(1017)
  AdmRuntimeRecordingError,

  /// 音频设备模块：录音失败。
  @JsonValue(1018)
  AdmRecordAudioFailed,

  /// 音频设备模块：播放频率异常。
  @JsonValue(1020)
  AdmPlayAbnormalFrequency,

  /// 音频设备模块：录制频率异常。
  @JsonValue(1021)
  AdmRecordAbnormalFrequency,

  /// 音频设备模块：初始化 Loopback 设备错误。
  @JsonValue(1022)
  AdmInitLoopback,

  /// 音频设备模块：启动 Loopback 设备错误。
  @JsonValue(1023)
  AdmStartLoopback,

  /// 音频设备模块：没有录音权限。
  @JsonValue(1027)
  AdmNoPermission,

  /// 音频路由：连接蓝牙通话失败，默认路由会被启用。
  @JsonValue(1030)
  AudioBtScoFailed,

  /// 音频设备模块：无录制设备。
  @JsonValue(1359)
  AdmNoRecordingDevice,

  /// 音频设备模块：无播放设备。
  @JsonValue(1360)
  AdmNoPlayoutDevice,

  /// 视频设备模块：没有摄像头使用权限。
  @JsonValue(1501)
  VdmCameraNotAuthorized,

  /// 视频设备模块：未知错误。
  @JsonValue(1600)
  VcmUnknownError,

  /// 视频设备模块：视频 Codec 初始化错误。
  @JsonValue(1601)
  VcmEncoderInitError,

  /// 视频设备模块：视频 Codec 错误。
  @JsonValue(1602)
  VcmEncoderEncodeError,

  /// 视频设备模块：视频 Codec 设置错误。
  ///
  /// **Deprecated** 该错误代码已废弃。
  @deprecated
  @JsonValue(1603)
  VcmEncoderSetError,
}

/// 输入进直播的外部视频源状态。
enum InjectStreamStatus {
  /// 外部视频流输入成功。
  @JsonValue(0)
  StartSuccess,

  /// 外部视频流已存在。
  @JsonValue(1)
  StartAlreadyExists,

  /// 外部视频流输入未经授权。
  @JsonValue(2)
  StartUnauthorized,

  /// 输入外部视频流超时。
  @JsonValue(3)
  StartTimedout,

  /// 外部视频流输入失败。
  @JsonValue(4)
  StartFailed,

  /// 外部视频流停止输入成功。
  @JsonValue(5)
  StopSuccess,

  /// 未找到要停止输入的外部视频流。
  @JsonValue(6)
  StopNotFound,

  /// 要停止输入的外部视频流未经授权。
  @JsonValue(7)
  StopUnauthorized,

  /// 停止输入外部视频流超时。
  @JsonValue(8)
  StopTimedout,

  /// 停止输入外部视频流失败。
  @JsonValue(9)
  StopFailed,

  /// 输入的外部视频流被中断。
  @JsonValue(10)
  Broken,
}

/// Last-mile 质量探测结果的状态。
enum LastmileProbeResultState {
  /// 本次 Last-mile 质量探测是完整的。
  @JsonValue(1)
  Complete,

  /// 本次 Last-mile 质量探测未进行带宽预测，因此结果不完整。一个可能的原因是测试资源暂时受限。
  @JsonValue(2)
  IncompleteNoBwe,

  /// 未进行 Last-mile 质量探测。一个可能的原因是网络连接中断。
  @JsonValue(3)
  Unavailable,
}

/// 亮度明暗对比度。

enum LighteningContrastLevel {
  /// 低对比度。
  @JsonValue(0)
  Low,

  ///（默认）正常对比度。
  @JsonValue(1)
  Normal,

  /// 高对比度。
  @JsonValue(2)
  High,
}

/// 本地视频出错原因。
enum LocalVideoStreamError {
  /// 本地视频状态正常。
  @JsonValue(0)
  OK,

  /// 出错原因不明确。
  @JsonValue(1)
  Failure,

  /// 没有权限启动本地视频采集设备。
  @JsonValue(2)
  DeviceNoPermission,

  /// 本地视频采集设备正在使用中。
  @JsonValue(3)
  DeviceBusy,

  /// 本地视频采集失败，建议检查采集设备是否正常工作。
  @JsonValue(4)
  CaptureFailure,

  /// 本地视频编码失败。
  @JsonValue(5)
  EncodeFailure,

  /// （仅适用于 iOS）应用处于后台。
  @JsonValue(6)
  CaptureInBackground,

  /// (仅支持 iOS) 应用窗口处于侧拉、分屏、画中画模式。
  @JsonValue(7)
  CaptureMultipleForegroundApps,

  /// SDK 找不到本地视频采集设备。
  @JsonValue(8)
  DeviceNotFound,
}

/// 本地视频状态。
enum LocalVideoStreamState {
  /// 本地视频默认初始状态。
  @JsonValue(0)
  Stopped,

  /// 本地视频采集设备启动成功。
  @JsonValue(1)
  Capturing,

  /// 本地视频首帧编码成功。
  @JsonValue(2)
  Encoding,

  /// 本地视频启动失败。
  @JsonValue(3)
  Failed,
}

/// 输出日志过滤分级。
enum LogFilter {
  /// 不输出任何日志。
  @JsonValue(0)
  Off,

  /// 输出所有的 API 日志。如果你想获取最完整的日志，可以将日志级别设为该等级。
  @JsonValue(0x080f)
  Debug,

  /// 输出 CRITICAL、ERROR、WARNING、INFO 级别的日志。我们推荐你将日志级别设为该等级。
  @JsonValue(0x000f)
  Info,

  /// 仅输出 CRITICAL、ERROR、WARNING 级别的日志。
  @JsonValue(0x000e)
  Warning,

  /// 仅输出 CRITICAL、ERROR 级别的日志。
  @JsonValue(0x000c)
  Error,

  /// 仅输出 CRITICAL 级别的日志。
  @JsonValue(0x0008)
  Critical,
}

/// 网络质量。
enum NetworkQuality {
  /// 网络质量未知。
  @JsonValue(0)
  Unknown,

  /// 网络质量极好。
  @JsonValue(1)
  Excellent,

  /// 用户主观感觉和 `Excellent` 差不多，但码率可能略低于 `Excellent`。
  @JsonValue(2)
  Good,

  /// 用户主观感受有瑕疵但不影响沟通。
  @JsonValue(3)
  Poor,

  /// 勉强能沟通但不顺畅。
  @JsonValue(4)
  Bad,

  /// 网络质量非常差，基本不能沟通。
  @JsonValue(5)
  VBad,

  /// 网络连接已断开，完全无法沟通。
  @JsonValue(6)
  Down,

  /// 网络质量探测功能不可使用 (目前没有使用)。
  @JsonValue(7)
  Unsupported,

  /// 网络质量探测中。
  @JsonValue(8)
  Detecting,
}

/// 网络类型。
enum NetworkType {
  /// 网络连接类型未知。
  @JsonValue(-1)
  Unknown,

  /// 网络连接已断开。
  @JsonValue(0)
  Disconnected,

  /// 网络类型为 LAN。
  @JsonValue(1)
  LAN,

  /// 网络类型为 Wi-Fi（包含热点）。
  @JsonValue(2)
  WIFI,

  /// 网络类型为 2G 移动网络。
  @JsonValue(3)
  Mobile2G,

  /// 网络类型为 3G 移动网络。
  @JsonValue(4)
  Mobile3G,

  /// 网络类型为 4G 移动网络。
  @JsonValue(5)
  Mobile4G,
}

/// 详细的推流错误信息。
enum RtmpStreamingErrorCode {
  /// 推流成功。
  @JsonValue(0)
  OK,

  /// 参数无效。比如说如果你在调用 [RtcEngine.addPublishStreamUrl] 前没有调用 [RtcEngine.setLiveTranscoding] 设置转码参数，SDK 会返回该错误。
  /// 请检查输入参数是否正确。
  @JsonValue(1)
  InvalidParameters,

  /// 推流已加密不能推流。
  @JsonValue(2)
  EncryptedStreamNotAllowed,

  /// 推流超时未成功。可调用 [RtcEngine.addPublishStreamUrl] 重新推流。
  @JsonValue(3)
  ConnectionTimeout,

  /// 推流服务器出现错误。请调用 [RtcEngine.addPublishStreamUrl] 重新推流。
  @JsonValue(4)
  InternalServerError,

  /// CDN 服务器出现错误。
  @JsonValue(5)
  RtmpServerError,

  /// 推流请求过于频繁。
  @JsonValue(6)
  TooOften,

  /// 单个主播的推流地址数目达到上限 10。请删掉一些不用的推流地址再增加推流地址。
  @JsonValue(7)
  ReachLimit,

  /// 主播操作不主播自己的流，如更新其他主播的流参数、停止其他主播的流。请检查 app 逻辑。
  @JsonValue(8)
  NotAuthorized,

  /// 服务器未找到这个流。
  @JsonValue(9)
  StreamNotFound,

  /// 推流地址格式有错误。请检查推流地址格式是否正确。
  @JsonValue(10)
  FormatNotSupported,

  /// 推流已正常结束。当你调用 [RtcEngine.removePublishStreamUrl] 结束推流后，SDK 会返回该值。
  @JsonValue(100)
  UnPublishOK,
}

/// RTMP 推流状态。
enum RtmpStreamingState {
  /// 推流未开始或已结束。成功调用 [RtcEngine.removePublishStreamUrl] 方法删除推流地址后，也会返回该状态。
  @JsonValue(0)
  Idle,

  /// 正在连接 Agora 推流服务器和 CDN 服务器。SDK 调用 [RtcEngine.addPublishStreamUrl] 方法后，会返回该状态。
  @JsonValue(1)
  Connecting,

  /// 推流正在进行。SDK 成功推流后，会返回该状态。
  @JsonValue(2)
  Running,

  /// 正在恢复推流。当 CDN 出现异常，或推流短暂中断时，SDK 会自动尝试恢复推流，并返回该状态。
  /// - 如成功恢复推流，则进入状态 `Running`。详见 [RtmpStreamingState.Running]。
  /// - 如服务器出错或 60 秒内未成功恢复，则进入状态 `Failure`。详见 [RtmpStreamingState.Failure]。
  /// - 如果觉得 60 秒太长，也可以主动调用 [RtcEngine.removePublishStreamUrl] 和 [RtcEngine.addPublishStreamUrl] 方法尝试重连。
  @JsonValue(3)
  Recovering,

  /// 推流失败。失败后，你可以通过返回的错误码排查出错原因；
  /// 也可以再次调用 [RtcEngine.addPublishStreamUrl] 重新尝试推流。
  @JsonValue(4)
  Failure,
}

/// 流回退选项。
enum StreamFallbackOptions {
  /// 上/下行网络较弱时，不对音视频流作回退处理，但不能保证音视频流的质量。
  @JsonValue(0)
  Disabled,

  /// 下行网络较弱时只接收视频小流。
  ///
  /// 该选项只对 [RtcEngine.setRemoteSubscribeFallbackOption] 方法有效，对 [RtcEngine.setLocalPublishFallbackOption] 方法无效。
  @JsonValue(1)
  VideoStreamLow,

  /// 上行网络较弱时，只发布音频流。下行网络较弱时，先尝试只接收视频小流；
  /// 如果网络环境无法显示视频，则再回退到只接收远端订阅的音频流。
  @JsonValue(2)
  AudioOnly,
}

/// 用户离线原因。
enum UserOfflineReason {
  /// 用户主动离开。
  @JsonValue(0)
  Quit,

  /// 因过长时间收不到对方数据包，超时掉线。注意：由于 SDK 使用的是不可靠通道，
  /// 也有可能对方主动离开本方没收到对方离开消息而误判为超时掉线。
  @JsonValue(1)
  Dropped,

  /// （直播场景中）用户身份从主播切换为观众时触发。
  @JsonValue(2)
  BecomeAudience,
}

/// 远端用户的优先级。
enum UserPriority {
  /// 远端用户的优先级为高。
  @JsonValue(50)
  High,

  /// （默认） 远端用户的优先级为低。
  @JsonValue(100)
  Normal,
}

/// 用于旁路直播的输出视频的编码规格。
enum VideoCodecProfileType {
  /// Baseline 级别的视频编码规格，一般用于低阶或需要额外容错的应用，比如视频通话、手机视频等。
  @JsonValue(66)
  BaseLine,

  /// Main 级别的视频编码规格，一般用于主流消费类电子产品，如 mp4、便携的视频播放器、PSP 和 iPad 等。
  @JsonValue(77)
  Main,

  ///（默认）High 级别的视频编码规格，一般用于广播及视频碟片存储，高清电视。
  @JsonValue(100)
  High,
}

/// 视频编码的帧率。
enum VideoFrameRate {
  /// 最低视频编码帧率（fps）。
  @JsonValue(-1)
  Min,

  /// 每秒钟 1 帧。
  @JsonValue(1)
  Fps1,

  /// 每秒钟 7 帧。
  @JsonValue(7)
  Fps7,

  /// 每秒钟 10 帧。
  @JsonValue(10)
  Fps10,

  /// 每秒钟 15 帧。
  @JsonValue(15)
  Fps15,

  /// 每秒钟 24 帧。
  @JsonValue(24)
  Fps24,

  /// 每秒钟 30 帧。
  @JsonValue(30)
  Fps30,

  /// 每秒钟 60 帧。（仅适用于 macOS）
  @JsonValue(60)
  Fps60,
}

/// 视频编码的码率。单位为 Kbps。你可以根据场景需要，参考下面的视频基准码率参考表，手动设置你想要的码率。若设置的视频码率超出合理范围，SDK 会自动按照合理区间处理码率。
///
/// **视频码率参考表**
/// <table>
///     <tr>
///         <th>分辨率</th>
///         <th>帧率 <p> (fps)</th>
///         <th>基准码率 <p>（通信场景，Kbps）</th>
///         <th>直播码率 <p>（直播场景，Kbps）</th>
///     </tr>
///     <tr>
///         <td>160*120</td>
///         <td>15</td>
///         <td>65</td>
///         <td>130</td>
///     </tr>
///     <tr>
///         <td>120*120</td>
///         <td>15</td>
///         <td>50</td>
///         <td>100</td>
///     </tr>
///     <tr>
///         <td>320*180</td>
///         <td>15</td>
///         <td>140</td>
///         <td>280</td>
///     </tr>
///     <tr>
///         <td>180*180</td>
///         <td>15</td>
///         <td>100</td>
///         <td>200</td>
///     </tr>
///     <tr>
///         <td>240*180</td>
///         <td>15</td>
///         <td>120</td>
///         <td>240</td>
///     </tr>
///     <tr>
///         <td>320*240</td>
///         <td>15</td>
///         <td>200</td>
///         <td>400</td>
///     </tr>
///     <tr>
///         <td>240*240</td>
///         <td>15</td>
///         <td>140</td>
///         <td>280</td>
///     </tr>
///     <tr>
///         <td>424*240</td>
///         <td>15</td>
///         <td>220</td>
///         <td>440</td>
///     </tr>
///     <tr>
///         <td>640*360</td>
///         <td>15</td>
///         <td>400</td>
///         <td>800</td>
///     </tr>
///     <tr>
///         <td>360*360</td>
///         <td>15</td>
///         <td>260</td>
///         <td>520</td>
///     </tr>
///     <tr>
///         <td>640*360</td>
///         <td>30</td>
///         <td>600</td>
///         <td>1200</td>
///     </tr>
///     <tr>
///         <td>360*360</td>
///         <td>30</td>
///         <td>400</td>
///         <td>800</td>
///     </tr>
///     <tr>
///         <td>480*360</td>
///         <td>15</td>
///         <td>320</td>
///         <td>640</td>
///     </tr>
///     <tr>
///         <td>480*360</td>
///         <td>30</td>
///         <td>490</td>
///         <td>980</td>
///     </tr>
///     <tr>
///         <td>640*480</td>
///         <td>15</td>
///         <td>500</td>
///         <td>1000</td>
///     </tr>
///     <tr>
///         <td>480*480</td>
///         <td>15</td>
///         <td>400</td>
///         <td>800</td>
///     </tr>
///     <tr>
///         <td>640*480</td>
///         <td>30</td>
///         <td>750</td>
///         <td>1500</td>
///     </tr>
///     <tr>
///         <td>480*480</td>
///         <td>30</td>
///         <td>600</td>
///         <td>1200</td>
///     </tr>
///     <tr>
///         <td>848*480</td>
///         <td>15</td>
///         <td>610</td>
///         <td>1220</td>
///     </tr>
///     <tr>
///         <td>848*480</td>
///         <td>30</td>
///         <td>930</td>
///         <td>1860</td>
///     </tr>
///     <tr>
///         <td>640*480</td>
///         <td>10</td>
///         <td>400</td>
///         <td>800</td>
///     </tr>
///     <tr>
///         <td>1280*720</td>
///         <td>15</td>
///         <td>1130</td>
///         <td>2260</td>
///     </tr>
///     <tr>
///         <td>1280*720</td>
///         <td>30</td>
///         <td>1710</td>
///         <td>3420</td>
///     </tr>
///     <tr>
///         <td>960*720</td>
///         <td>15</td>
///         <td>910</td>
///         <td>1820</td>
///     </tr>
///     <tr>
///         <td>960*720</td>
///         <td>30</td>
///         <td>1380</td>
///         <td>2760</td>
///     </tr>
/// </table>
///
/// **Note**
///
/// 该表中的基准码率适用于通信场景。直播场景下通常需要较大码率来提升视频质量。
/// Agora 推荐通过设置 `Standard` 来实现。你也可以直接将码率值设为基准码率值 x 2。
///
/// 你也可以直接选择如下任意一种模式进行设置：

enum BitRate {
  /// （推荐）标准码率模式。该模式下，视频在通信和直播场景下的码率有所不同：
  /// - 通信场景下，码率与基准码率一致。
  /// - 直播场景下，码率对照基准码率翻倍。
  @JsonValue(0)
  Standard,

  /// 适配码率模式。该模式下，视频在通信和直播场景下的码率均与基准码率一致。直播下如果选择该模式，视频帧率可能会低于设置的值。
  @JsonValue(-1)
  Compatible,
}

/// 视频镜像模式。
enum VideoMirrorMode {
  /// （默认） 由 SDK 决定镜像模式。
  @JsonValue(0)
  Auto,

  /// 启用镜像模式。
  @JsonValue(1)
  Enabled,

  /// 关闭镜像模式。
  @JsonValue(2)
  Disabled,
}

/// 视频输出方向模式。
enum VideoOutputOrientationMode {
  /// 自适应布局（默认）
  /// 该模式下 SDK 输出的视频方向与采集到的视频方向一致。
  /// 接收端会根据收到的视频旋转信息对视频进行旋转。该模式适用于接收端可以调整视频方向的场景:
  /// - 如果采集的视频是横屏模式，则输出的视频也是横屏模式。
  /// - 如果采集的视频是竖屏模式，则输出的视频也是竖屏模式。
  @JsonValue(0)
  Adaptative,

  /// 横屏布局。
  /// 该模式下 SDK 固定输出风景（横屏）模式的视频。如果采集到的视频是竖屏模式，
  /// 则视频编码器会对其进行裁剪。该模式适用于当接收端无法调整视频方向时，如使用旁路推流场景下。
  @JsonValue(1)
  FixedLandscape,

  /// 竖屏布局。
  /// 该模式下 SDK 固定输出人像（竖屏）模式的视频。如果采集到的视频是横屏模式，则视频编码器会对其进行裁剪。该模式适用于当接收端无法调整视频方向时，如使用旁路推流场景下。
  @JsonValue(2)
  FixedPortrait,
}

/// 自上次统计后本地视频质量的自适应情况（基于目标帧率和目标码率）。
enum VideoQualityAdaptIndication {
  /// 本地视频质量不变。
  @JsonValue(0)
  AdaptNone,

  /// 因网络带宽增加，本地视频质量改善。
  @JsonValue(1)
  AdaptUpBandwidth,

  /// 因网络带宽减少，本地视频质量变差。
  @JsonValue(2)
  AdaptDownBandwidth,
}

/// 远端视频流状态。
enum VideoRemoteState {
  /// 远端视频默认初始状态。在
  /// - [VideoRemoteStateReason.LocalMuted]、
  /// - [VideoRemoteStateReason.RemoteMuted] 或
  /// - [VideoRemoteStateReason.RemoteOffline] 的情况下，会报告该状态。
  @JsonValue(0)
  Stopped,

  /// 本地用户已接收远端视频首包。
  @JsonValue(1)
  Starting,

  /// 远端视频流正在解码，正常播放。在
  /// - [VideoRemoteStateReason.NetworkRecovery]、
  /// - [VideoRemoteStateReason.LocalUnmuted]、
  /// - [VideoRemoteStateReason.RemoteUnmuted] 或
  /// - [VideoRemoteStateReason.AudioFallbackRecovery] 的情况下，会报告该状态。
  @JsonValue(2)
  Decoding,

  /// 远端视频流卡顿。在
  /// - [VideoRemoteStateReason.NetworkCongestion] 或
  /// - [VideoRemoteStateReason.AudioFallback] 的情况下，会报告该状态。
  @JsonValue(3)
  Frozen,

  /// 远端视频流播放失败。在 [VideoRemoteStateReason.Internal] 的情况下，会报告该状态。
  @JsonValue(4)
  Failed,
}

/// 远端视频流状态改变的具体原因。
enum VideoRemoteStateReason {
  /// 内部原因。
  @JsonValue(0)
  Internal,

  /// 网络阻塞。
  @JsonValue(1)
  NetworkCongestion,

  /// 网络恢复正常。
  @JsonValue(2)
  NetworkRecovery,

  /// 本地用户停止接收远端视频流或本地用户禁用视频模块。
  @JsonValue(3)
  LocalMuted,

  /// 本地用户恢复接收远端视频流或本地用户启动视频模块。
  @JsonValue(4)
  LocalUnmuted,

  /// 远端用户停止发送视频流或远端用户禁用视频模块。
  @JsonValue(5)
  RemoteMuted,

  /// 远端用户恢复发送视频流或远端用户启用视频模块。
  @JsonValue(6)
  RemoteUnmuted,

  /// 远端用户离开频道。
  @JsonValue(7)
  RemoteOffline,

  /// 远端视频流已回退为音频流。
  @JsonValue(8)
  AudioFallback,

  /// 回退的远端音频流恢复为视频流。
  @JsonValue(9)
  AudioFallbackRecovery,
}

/// 视频显示模式。
enum VideoRenderMode {
  /// 视频尺寸等比缩放。优先保证视窗被填满。因视频尺寸与显示视窗尺寸不一致而多出的视频将被截掉。
  @JsonValue(1)
  Hidden,

  /// 视频尺寸等比缩放。优先保证视频内容全部显示。因视频尺寸与显示视窗尺寸不一致造成的视窗未被填满的区域填充黑色。
  @JsonValue(2)
  Fit,

  /// **Deprecated** 该模式已废弃。
  @deprecated
  @JsonValue(3)
  Adaptive,

  /// 视频尺寸进行缩放和拉伸以充满显示视窗。
  @JsonValue(4)
  FILL,
}

/// 视频流类型。
enum VideoStreamType {
  /// 高码率、高分辨率视频。
  @JsonValue(0)
  High,

  /// 低码率、低分辨率视频。
  @JsonValue(1)
  Low,
}

/// 警告回调表示 SDK 运行时出现了（网络或媒体相关的）警告。通常情况下，SDK 上报的警告信息 App 可以忽略，
/// SDK 会自动恢复。比如和服务器失去连接时，SDK 可能会上报 [WarningCode.OpenChannelTimeout] 警告，同时自动尝试重连。
enum WarningCode {
  /// 指定的 view 无效，使用视频功能时需要指定 view，如果 view 尚未指定，则返回该警告。
  @JsonValue(8)
  InvalidView,

  /// 初始化视频功能失败。有可能是因视频资源被占用导致的。用户无法看到视频画面，但不影响语音通信。
  @JsonValue(16)
  InitVideo,

  /// 请求处于待定状态。一般是由于某个模块还没准备好，请求被延迟处理。
  @JsonValue(20)
  Pending,

  /// 没有可用的频道资源。可能是因为服务端没法分配频道资源。
  @JsonValue(103)
  NoAvailableChannel,

  /// 查找频道超时。在加入频道时 SDK 先要查找指定的频道，出现该警告一般是因为网络太差，连接不到服务器。
  @JsonValue(104)
  LookupChannelTimeout,

  /// 查找频道请求被服务器拒绝。服务器可能没有办法处理这个请求或请求是非法的。
  ///
  /// **Deprecated** 已废弃。请改用 `connectionStateChanged` 回调
  /// 中的 `RejectedByServer`(10)。
  /// 详见 [ConnectionChangedReason.RejectedByServer] 和 [RtcEngineEventHandler.connectionStateChanged]。
  @deprecated
  @JsonValue(105)
  LookupChannelRejected,

  /// 打开频道超时。查找到指定频道后，SDK 接着打开该频道，超时一般是因为网络太差，连接不到服务器。
  @JsonValue(106)
  OpenChannelTimeout,

  /// 打开频道请求被服务器拒绝。服务器可能没有办法处理该请求或该请求是非法的。
  @JsonValue(107)
  OpenChannelRejected,

  /// 切换直播视频超时。
  @JsonValue(111)
  SwitchLiveVideoTimeout,

  /// 直播场景下设置用户角色超时。
  @JsonValue(118)
  SetClientRoleTimeout,

  /// 用户角色未授权。
  @JsonValue(119)
  SetClientRoleNotAuthorized,

  /// TICKET 非法，打开频道失败。
  @JsonValue(121)
  OpenChannelInvalidTicket,

  /// 尝试打开另一个服务器。
  @JsonValue(122)
  OpenChannelTryNextVos,

  /// 打开伴奏出错。
  @JsonValue(701)
  AudioMixingOpenError,

  /// 音频设备模块：运行时播放设备出现警告。
  @JsonValue(1014)
  AdmRuntimePlayoutWarning,

  /// 音频设备模块：运行时录音设备出现警告。
  @JsonValue(1016)
  AdmRuntimeRecordingWarning,

  /// 音频设备模块：没有采集到有效的声音数据。
  @JsonValue(1019)
  AdmRecordAudioSilence,

  /// 音频设备模块：播放设备异常。
  @JsonValue(1020)
  AdmPlaybackMalfunction,

  /// 音频设备模块：录音设备异常。
  @JsonValue(1021)
  AdmRecordMalfunction,

  /// 播放或录制音频时被系统事件（如来电）干扰。
  @JsonValue(1025)
  AdmInterruption,

  /// 在通话过程中，`AudioSessionCategory` 必须设置成 `AVAudioSessionCategoryPlayAndRecord`。
  /// SDK 会监控这个属性值。如果你将 `AudioSessionCategory` 设为其他值，SDK 会触发该警告，并强制设置回 `AVAudioSessionCategoryPlayAndRecord`。
  @JsonValue(1029)
  AdmCategoryNotPlayAndRecord,

  /// 音频设备模块：录到的声音太低。
  @JsonValue(1031)
  AdmRecordAudioLowlevel,

  /// 音频设备模块：播放的声音太低。
  @JsonValue(1032)
  AdmPlayoutAudioLowlevel,

  /// 音频设备模块：录制设备被占用。
  @JsonValue(1033)
  AdmRecordIsOccupied,

  /// 音频设备模块：音频驱动器发生异常。解决方案：
  /// - 禁用并重新启用音频设备
  /// - 重启 app 运行设备
  /// - 更新声卡驱动
  @JsonValue(1040)
  AdmNoDataReadyCallback,

  /// 音频设备模块：音频采集设备和播放设备不一致，可能引起回声，建议使用同一设备采集和播放音频。
  @JsonValue(1042)
  AdmInconsistentDevices,

  /// （仅通信场景）音频信号处理模块：录制音频时监测到啸叫。
  @JsonValue(1051)
  ApmHowling,

  /// 音频设备模块：音频播放会卡顿。
  @JsonValue(1052)
  AdmGlitchState,

  /// 音频设备模块：音频底层设置被修改。
  @JsonValue(1053)
  ApmResidualEcho,

  /// @nodoc
  @JsonValue(1610)
  SuperResolutionStreamOverLimitation,

  /// @nodoc
  @JsonValue(1611)
  SuperResolutionUserCountOverLimitation,

  /// @nodoc
  @JsonValue(1612)
  SuperResolutionDeviceNotSupported,
}

/// 直播音频所在声道。
enum AudioChannel {
  /// 默认混音设置，最多支持双声道，与主播端上行音频相关。
  @JsonValue(0)
  Channel0,

  /// 对应主播的音频，推流中位于 FL 声道。如果主播上行为双声道，会先把多声道混音成单声道。
  @JsonValue(1)
  Channel1,

  /// 对应主播的音频，推流中位于 FC 声道。如果主播上行为双声道，会先把多声道混音成单声道。
  @JsonValue(2)
  Channel2,

  /// 对应主播的音频，推流中位于 FR 声道。如果主播上行为双声道，会先把多声道混音成单声道。
  @JsonValue(3)
  Channel3,

  /// 对应主播的音频，推流中位于 BL 声道。如果主播上行为双声道，会先把多声道混音成单声道。
  @JsonValue(4)
  Channel4,

  /// 对应主播的音频，推流中位于 BR 声道。如果主播上行为双声道，会先把多声道混音成单声道。
  @JsonValue(5)
  Channel5,
}

/// 视频的编码类型。
enum VideoCodecType {
  /// 标准 VP8。
  @JsonValue(1)
  VP8,

  /// 标准 H264。
  @JsonValue(2)
  H264,

  /// 增强 VP8。
  @JsonValue(3)
  EVP,

  /// 增强 H264。
  @JsonValue(4)
  E264,
}

/// 发布状态。
enum StreamPublishState {
  /// 加入频道后的初始发布状态。
  @JsonValue(0)
  Idle,

  /// 发布失败。可能是因为：
  /// - 本地用户调用 [RtcEngine.muteLocalAudioStream] (`true`) 或 [RtcEngine.muteLocalVideoStream] (`true`) 停止发送本地媒体流。
  /// - 本地用户调用 [RtcEngine.disableAudio] 或 [RtcEngine.disableVideo] 关闭本地音频或视频模块。
  /// - 本地用户调用 [RtcEngine.enableLocalAudio] (`false`) 或 [RtcEngine.enableLocalVideo] (`false`) 关闭本地音频或视频采集。
  /// - 本地用户角色为观众。
  @JsonValue(1)
  NoPublished,

  /// 正在发布。
  @JsonValue(2)
  Publishing,

  /// 发布成功。
  @JsonValue(3)
  Published,
}

/// 订阅状态。
enum StreamSubscribeState {
  /// 加入频道后的初始订阅状态。
  @JsonValue(0)
  Idle,

  /// 订阅失败。可能是因为：
  /// - 远端用户：
  ///   - 调用 [RtcEngine.muteLocalAudioStream] (`true`) 或 [RtcEngine.muteLocalVideoStream] (`true`) 停止发送本地媒体流。
  ///   - 调用 [RtcEngine.disableAudio] 或 [RtcEngine.disableVideo] 关闭本地音频或视频模块。
  ///   - 调用 [RtcEngine.enableLocalAudio] (`false`) 或 [RtcEngine.enableLocalVideo] (`false`) 关闭本地音频或视频采集。
  ///   - 用户角色为观众。
  /// - 本地用户调用以下方法停止接收远端媒体流：
  ///   - 调用 [RtcEngine.muteRemoteAudioStream] (`true`)、[RtcEngine.muteAllRemoteAudioStreams] (`true`) 或 [RtcEngine.setDefaultMuteAllRemoteAudioStreams] (`true`) 停止接收远端音频流。
  ///   - 调用 [RtcEngine.muteRemoteVideoStream] (`true`)、[RtcEngine.muteAllRemoteVideoStreams] (`true`) 或 [RtcEngine.setDefaultMuteAllRemoteVideoStreams] (`true`) 停止接收远端视频流。
  @JsonValue(1)
  NoSubscribed,

  /// 正在订阅。
  @JsonValue(2)
  Subscribing,

  /// 收到了远端流，订阅成功。
  @JsonValue(3)
  Subscribed,
}

/// RTMP 推流事件码。
enum RtmpStreamingEvent {
  /// RTMP 推流时，添加背景图或水印出错。
  @JsonValue(1)
  FailedLoadImage,

  /// 该推流 URL 已用于推流。如果你想开始新的推流，请使用新的推流 URL。
  @JsonValue(2)
  UrlAlreadyInUse,
}

/// 音频会话控制权限
enum AudioSessionOperationRestriction {
  /// 没有限制，SDK 可以完全控制 Audio Session 操作。
  @JsonValue(0)
  None,

  /// SDK 不能更改 Audio Session 的 category。
  @JsonValue(1)
  SetCategory,

  /// SDK 不能更改 Audio Session 的 category，mode，categoryOptions。
  @JsonValue(1 << 1)
  ConfigureSession,

  /// 离开某个频道时，SDK 会保持 Audio Session 处于活动状态。
  @JsonValue(1 << 2)
  DeactivateSession,

  /// 限制 SDK 对 Audio Session 进行任何操作，SDK 将不能再对 Audio Session 进行任何配置。
  @JsonValue(1 << 7)
  All,
}

/// 预设的音效选项。
enum AudioEffectPreset {
  /// 原声，即关闭人声音效。
  @JsonValue(0x00000000)
  AudioEffectOff,

  /// KTV。
  ///
  /// **Note**
  ///
  /// 为获取更好的人声效果，Agora 建议你在使用该枚举前将 [RtcEngine.setAudioProfile] 的 `profile` 参数设置为 `MusicHighQuality(4)` 或 `MusicHighQualityStereo(5)`。
  @JsonValue(0x02010100)
  RoomAcousticsKTV,

  /// 演唱会。
  ///
  /// **Note**
  ///
  /// 为获取更好的人声效果，Agora 建议你在使用该枚举前将 [RtcEngine.setAudioProfile] 的 `profile` 参数设置为 `MusicHighQuality(4)` 或 `MusicHighQualityStereo(5)`。
  @JsonValue(0x02010200)
  RoomAcousticsVocalConcert,

  /// 录音棚。
  ///
  /// **Note**
  ///
  /// 为获取更好的人声效果，Agora 建议你在使用该枚举前将 [RtcEngine.setAudioProfile] 的 `profile` 参数设置为 `MusicHighQuality(4)` 或 `MusicHighQualityStereo(5)`。
  @JsonValue(0x02010300)
  RoomAcousticsStudio,

  /// 留声机。
  ///
  /// **Note**
  ///
  /// 为获取更好的人声效果，Agora 建议你在使用该枚举前将 [RtcEngine.setAudioProfile] 的 `profile` 参数设置为 `MusicHighQuality(4)` 或 `MusicHighQualityStereo(5)`。
  @JsonValue(0x02010400)
  RoomAcousticsPhonograph,

  /// 虚拟立体声，即 SDK 将单声道的音频渲染出双声道的音效。
  ///
  /// **Note**
  ///
  /// 你需要在使用该枚举前将 [RtcEngine.setAudioProfile] 的 `profile` 参数设置为 `MusicStandardStereo(3)` 或 `MusicHighQualityStereo(5)`，否则该枚举设置无效。
  @JsonValue(0x02010500)
  RoomAcousticsVirtualStereo,

  /// 空旷。
  ///
  /// **Note**
  ///
  /// 为获取更好的人声效果，Agora 建议你在使用该枚举前将 [RtcEngine.setAudioProfile] 的 `profile` 参数设置为 `MusicHighQuality(4)` 或 `MusicHighQualityStereo(5)`。
  @JsonValue(0x02010600)
  RoomAcousticsSpacial,

  /// 空灵。
  ///
  /// **Note**
  ///
  /// 为获取更好的人声效果，Agora 建议你在使用该枚举前将 [RtcEngine.setAudioProfile] 的 `profile` 参数设置为 `MusicHighQuality(4)` 或 `MusicHighQualityStereo(5)`。
  @JsonValue(0x02010700)
  RoomAcousticsEthereal,

  /// 3D 人声，即 SDK 将音频渲染出在用户周围环绕的效果，环绕周期为 10 秒。设置该音效后，你还可以调用 [RtcEngine.setAudioEffectParameters] 修改环绕周期。
  ///
  /// **Note**
  ///
  /// - 你需要在使用该枚举前将 [RtcEngine.setAudioProfile] 的 `profile` 参数设置为 `MusicStandardStereo(3)` 或 `MusicHighQualityStereo(5)`，否则该枚举设置无效。
  /// - 启用 3D 人声后，用户需要使用支持双声道的音频播放设备才能听到预期效果。
  @JsonValue(0x02010800)
  RoomAcoustics3DVoice,

  /// 大叔。
  ///
  /// **Note**
  ///
  /// - 建议用于处理男声，否则无法达到预期效果。
  /// - 为获取更好的人声效果，Agora 建议你在使用该枚举前将 [RtcEngine.setAudioProfile] 的 `profile` 参数设置为 `MusicHighQuality(4)` 或 `MusicHighQualityStereo(5)`。
  @JsonValue(0x02020100)
  VoiceChangerEffectUncle,

  /// 老年男性。
  ///
  /// **Note**
  ///
  /// - 建议用于处理男声，否则无法达到预期效果。
  /// - 为获取更好的人声效果，Agora 建议你在使用该枚举前将 [RtcEngine.setAudioProfile] 的 `profile` 参数设置为 `MusicHighQuality(4)` 或 `MusicHighQualityStereo(5)`。
  @JsonValue(0x02020200)
  VoiceChangerEffectOldMan,

  /// 男孩。
  ///
  /// **Note**
  ///
  /// - 建议用于处理男声，否则无法达到预期效果。
  /// - 为获取更好的人声效果，Agora 建议你在使用该枚举前将 [RtcEngine.setAudioProfile] 的 `profile` 参数设置为 `MusicHighQuality(4)` 或 `MusicHighQualityStereo(5)`。
  @JsonValue(0x02020300)
  VoiceChangerEffectBoy,

  /// 少女。
  ///
  /// **Note**
  ///
  /// - 建议用于处理女声，否则无法达到预期效果。
  /// - 为获取更好的人声效果，Agora 建议你在使用该枚举前将 [RtcEngine.setAudioProfile] 的 `profile` 参数设置为 `MusicHighQuality(4)` 或 `MusicHighQualityStereo(5)`。
  @JsonValue(0x02020400)
  VoiceChangerEffectSister,

  /// 女孩。
  ///
  /// **Note**
  ///
  /// - 建议用于处理女声，否则无法达到预期效果。
  /// - 为获取更好的人声效果，Agora 建议你在使用该枚举前将 [RtcEngine.setAudioProfile] 的 `profile` 参数设置为 `MusicHighQuality(4)` 或 `MusicHighQualityStereo(5)`。
  @JsonValue(0x02020500)
  VoiceChangerEffectGirl,

  /// 猪八戒。
  ///
  /// **Note**
  ///
  /// - 为获取更好的人声效果，Agora 建议你在使用该枚举前将 [RtcEngine.setAudioProfile] 的 `profile` 参数设置为 `MusicHighQuality(4)` 或 `MusicHighQualityStereo(5)`。
  @JsonValue(0x02020600)
  VoiceChangerEffectPigKing,

  /// 绿巨人。
  ///
  /// **Note**
  ///
  /// - 为获取更好的人声效果，Agora 建议你在使用该枚举前将 [RtcEngine.setAudioProfile] 的 `profile` 参数设置为 `MusicHighQuality(4)` 或 `MusicHighQualityStereo(5)`。
  @JsonValue(0x02020700)
  VoiceChangerEffectHulk,

  /// R&B。
  ///
  /// **Note**
  ///
  /// - 为获取更好的人声效果，Agora 建议你在使用该枚举前将 [RtcEngine.setAudioProfile] 的 `profile` 参数设置为 `MusicHighQuality(4)` 或 `MusicHighQualityStereo(5)`。
  @JsonValue(0x02030100)
  StyleTransformationRnB,

  /// 流行。
  ///
  /// **Note**
  ///
  /// - 为获取更好的人声效果，Agora 建议你在使用该枚举前将 [RtcEngine.setAudioProfile] 的 `profile` 参数设置为 `MusicHighQuality(4)` 或 `MusicHighQualityStereo(5)`。
  @JsonValue(0x02030200)
  StyleTransformationPopular,

  /// 电音，即 SDK 以主音音高为 C 的自然大调为基础修正音频的实际音高。设置该音效后，你还可以调用 [RtcEngine.setAudioEffectParameters] 调整修音的基础调式和主音音高。
  ///
  /// **Note**
  ///
  /// - 为获取更好的人声效果，Agora 建议你在使用该枚举前将 [RtcEngine.setAudioProfile] 的 `profile` 参数设置为 `MusicHighQuality(4)` 或 `MusicHighQualityStereo(5)`。
  @JsonValue(0x02040100)
  PitchCorrection,
}

/// 预设的美声效果选项。
enum VoiceBeautifierPreset {
  /// 原声，即关闭美声效果。
  @JsonValue(0x00000000)
  VoiceBeautifierOff,

  /// 磁性（男）。
  ///
  /// **Note**
  ///
  /// 该设置仅对男声有效。请勿用于设置女声，否则音频会失真。
  @JsonValue(0x01010100)
  ChatBeautifierMagnetic,

  /// 清新（女）。
  ///
  /// 该设置仅对女声有效。请勿用于设置男声，否则音频会失真。
  @JsonValue(0x01010200)
  ChatBeautifierFresh,

  /// 活力（女）。
  ///
  /// 该设置仅对女声有效。请勿用于设置男声，否则音频会失真。
  @JsonValue(0x01010300)
  ChatBeautifierVitality,

  /// 浑厚。
  @JsonValue(0x01030100)
  TimbreTransformationVigorous,

  /// 低沉。
  @JsonValue(0x01030200)
  TimbreTransformationDeep,

  /// 圆润。
  @JsonValue(0x01030300)
  TimbreTransformationMellow,

  /// 假音。
  @JsonValue(0x01030400)
  TimbreTransformationFalsetto,

  /// 饱满。
  @JsonValue(0x01030500)
  TimbreTransformationFull,

  /// 清澈。
  @JsonValue(0x01030600)
  TimbreTransformationClear,

  /// 高亢。
  @JsonValue(0x01030700)
  TimbreTransformationResounding,

  /// 嘹亮。
  @JsonValue(0x01030800)
  TimbreTransformationRinging,
}

/// 直播频道中观众端（用户角色为观众的客户端）的延时级别。
///
/// **Note**
///
/// 仅在用户角色设为 `Broadcaster` 时才生效。
enum AudienceLatencyLevelType {
  /// 1: 低延时。
  @JsonValue(1)
  LowLatency,

  /// 2: （默认）超低延时。
  @JsonValue(2)
  UltraLowLatency,
}

///  Agora SDK 的日志输出等级。
enum LogLevel {
  /// 不输出任何日志。
  @JsonValue(0x0000)
  None,

  /// (Default) （默认）输出 `Fatal`、`Error`、`Warn`、`Info` 级别的日志。
  /// 我们推荐你将日志级别设为该等级。
  @JsonValue(0x0001)
  Info,

  /// 输出 `Fatal`、`Error`、`Warn` 级别的日志。
  @JsonValue(0x0002)
  Warn,

  /// 输出 `Fatal` 和 `Error` 级别的日志。
  @JsonValue(0x0004)
  Error,

  /// 输出 `Fatal` 级别的日志。
  @JsonValue(0x0008)
  Fatal,
}

/// 本地采集的画质亮度级别。
enum CaptureBrightnessLevelType {
  ///  SDK 未检测出本地采集的画质亮度级别。
  /// 请等待几秒，通过下一次回调的 [CaptureBrightnessLevelType] 获取亮度级别。
  @JsonValue(-1)
  Invalid,

  /// 本地采集的画质亮度正常。
  @JsonValue(0)
  Normal,

  /// 本地采集的画质亮度偏亮。
  @JsonValue(1)
  Bright,

  /// 本地采集的画质亮度偏暗。
  @JsonValue(2)
  Dark,
}

/// @nodoc The reason why the super-resolution algorithm is not successfully enabled.
enum SuperResolutionStateReason {
  /// 0: The super-resolution algorithm is successfully enabled.
  @JsonValue(0)
  Success,

  /// 1: The origin resolution of the remote video is beyond the range where the super-resolution algorithm can be applied.
  @JsonValue(1)
  StreamOverLimitation,

  /// 2: Another user is already using the super-resolution algorithm.
  @JsonValue(2)
  UserCountOverLimitation,

  /// 3: The device does not support the super-resolution algorithm.
  @JsonValue(3)
  DeviceNotSupported,
}

/// @nodoc
enum UploadErrorReason {
  @JsonValue(0)
  Success,

  @JsonValue(1)
  NetError,

  @JsonValue(2)
  ServerError,
}

/// 云代理类型。
enum CloudProxyType {
  /// 不使用云代理。
  @JsonValue(0)
  None,

  /// UDP 协议的云代理。
  @JsonValue(1)
  UDP,

  /// @nodoc TCP 协议的云代理。
  @JsonValue(2)
  TCP,
}

/// 接收远端音频时，本地用户的主观体验质量。
enum ExperienceQualityType {
  /// 主观体验质量较好。
  @JsonValue(0)
  Good,

  /// 主观体验质量较差。
  @JsonValue(1)
  Bad,
}

/// 接收远端音频时，本地用户主观体验质量较差的原因。
enum ExperiencePoorReason {
  /// 无原因，说明主观体验质量较好。
  @JsonValue(0)
  None,

  /// 远端用户的网络较差。
  @JsonValue(1)
  RemoteNetworkQualityPoor,

  /// 本地用户的网络较差。
  @JsonValue(2)
  LocalNetworkQualityPoor,

  /// 本地用户的 Wi-Fi 或者移动数据网络信号弱。
  @JsonValue(4)
  WirelessSignalPoor,

  /// 本地用户同时开启 Wi-Fi 和蓝牙，二者信号互相干扰，导致音频传输质量下降。
  @JsonValue(8)
  WifiBluetoothCoexist,
}

/// 预设的变声效果选项。
enum VoiceConversionPreset {
  /// 原声，即关闭变声效果。
  @JsonValue(0)
  Off,

  /// 中性。为避免音频失真，请确保仅对女声设置该效果。
  @JsonValue(50397440)
  Neutral,

  /// 甜美。为避免音频失真，请确保仅对女声设置该效果。
  @JsonValue(50397696)
  Sweet,

  /// 稳重。为避免音频失真，请确保仅对男声设置该效果。
  @JsonValue(50397952)
  Solid,

  /// 低沉。为避免音频失真，请确保仅对男声设置该效果。
  @JsonValue(50398208)
  Bass,
}
