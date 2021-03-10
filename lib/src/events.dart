import 'classes.dart';
import 'enum_converter.dart';
import 'enums.dart';

typedef EmptyCallback = void Function();
typedef WarningCallback = void Function(WarningCode warn);
typedef ErrorCallback = void Function(ErrorCode err);
typedef ApiCallCallback = void Function(
    ErrorCode error, String api, String result);
typedef UidWithElapsedAndChannelCallback = void Function(
    String channel, int uid, int elapsed);
typedef RtcStatsCallback = void Function(RtcStats stats);
typedef UserAccountCallback = void Function(int uid, String userAccount);
typedef UserInfoCallback = void Function(int uid, UserInfo userInfo);
typedef ClientRoleCallback = void Function(
    ClientRole oldRole, ClientRole newRole);
typedef UidWithElapsedCallback = void Function(int uid, int elapsed);
typedef UserOfflineCallback = void Function(int uid, UserOfflineReason reason);
typedef ConnectionStateCallback = void Function(
    ConnectionStateType state, ConnectionChangedReason reason);
typedef NetworkTypeCallback = void Function(NetworkType type);
typedef TokenCallback = void Function(String token);
typedef AudioVolumeCallback = void Function(
    List<AudioVolumeInfo> speakers, int totalVolume);
typedef UidCallback = void Function(int uid);
typedef ElapsedCallback = void Function(int elapsed);
typedef VideoFrameCallback = void Function(int width, int height, int elapsed);
typedef UidWithMutedCallback = void Function(int uid, bool muted);
typedef VideoSizeCallback = void Function(
    int uid, int width, int height, int rotation);
typedef RemoteVideoStateCallback = void Function(int uid,
    VideoRemoteState state, VideoRemoteStateReason reason, int elapsed);
typedef LocalVideoStateCallback = void Function(
    LocalVideoStreamState localVideoState, LocalVideoStreamError error);
typedef RemoteAudioStateCallback = void Function(int uid,
    AudioRemoteState state, AudioRemoteStateReason reason, int elapsed);
typedef LocalAudioStateCallback = void Function(
    AudioLocalState state, AudioLocalError error);
typedef FallbackCallback = void Function(bool isFallbackOrRecover);
typedef FallbackWithUidCallback = void Function(
    int uid, bool isFallbackOrRecover);
typedef AudioRouteCallback = void Function(AudioOutputRouting routing);
typedef RectCallback = void Function(Rect rect);
typedef NetworkQualityCallback = void Function(NetworkQuality quality);
typedef NetworkQualityWithUidCallback = void Function(
    int uid, NetworkQuality txQuality, NetworkQuality rxQuality);
typedef LastmileProbeCallback = void Function(LastmileProbeResult result);
typedef LocalVideoStatsCallback = void Function(LocalVideoStats stats);
typedef LocalAudioStatsCallback = void Function(LocalAudioStats stats);
typedef RemoteVideoStatsCallback = void Function(RemoteVideoStats stats);
typedef RemoteAudioStatsCallback = void Function(RemoteAudioStats stats);
typedef AudioMixingStateCallback = void Function(
    AudioMixingStateCode state, AudioMixingErrorCode errorCode);
typedef SoundIdCallback = void Function(int soundId);
typedef RtmpStreamingStateCallback = void Function(
    String url, RtmpStreamingState state, RtmpStreamingErrorCode errCode);
typedef StreamInjectedStatusCallback = void Function(
    String url, int uid, InjectStreamStatus status);
typedef StreamMessageCallback = void Function(
    int uid, int streamId, String data);
typedef StreamMessageErrorCallback = void Function(
    int uid, int streamId, ErrorCode error, int missed, int cached);
typedef MediaRelayStateCallback = void Function(
    ChannelMediaRelayState state, ChannelMediaRelayError code);
typedef MediaRelayEventCallback = void Function(ChannelMediaRelayEvent code);
typedef VideoFrameWithUidCallback = void Function(
    int uid, int width, int height, int elapsed);
typedef UrlWithErrorCallback = void Function(String url, ErrorCode error);
typedef UrlCallback = void Function(String url);
typedef TransportStatsCallback = void Function(
    int uid, int delay, int lost, int rxKBitRate);
typedef UidWithEnabledCallback = void Function(int uid, bool enabled);
typedef EnabledCallback = void Function(bool enabled);
typedef AudioQualityCallback = void Function(
    int uid, int quality, int delay, int lost);
typedef MetadataCallback = void Function(
    String buffer, int uid, int timeStampMs);
typedef FacePositionCallback = void Function(
    int imageWidth, int imageHeight, List<FacePositionInfo> faces);
typedef StreamPublishStateCallback = void Function(
    String channel,
    StreamPublishState oldState,
    StreamPublishState newState,
    int elapseSinceLastState);
typedef StreamSubscribeStateCallback = void Function(
    String channel,
    int uid,
    StreamSubscribeState oldState,
    StreamSubscribeState newState,
    int elapseSinceLastState);
typedef RtmpStreamingEventCallback = void Function(
    String url, RtmpStreamingEvent eventCode);
typedef UserSuperResolutionEnabledCallback = void Function(
    int uid, bool enabled, SuperResolutionStateReason reason);
typedef UploadLogResultCallback = void Function(
    String requestId, bool success, UploadErrorReason reason);

/// 主回调事件。
///
/// [RtcEngineEventHandler] 接口类用于 SDK 向 App 发送回调事件通知，
/// App 通过继承该接口类的方法获取 SDK 的事件通知。 接口类的所有方法都有缺省（空）实现，
/// App 可以根据需要只继承关心的事件。在回调方法中，App 不应该做耗时或者调用可能会引起阻塞的 API（如 SendMessage），否则可能影响 SDK 的运行。
class RtcEngineEventHandler {
  /// 发生警告回调。
  ///
  /// 该回调方法表示 SDK 运行时出现了（网络或媒体相关的）警告。通常情况下，
  /// SDK 上报的警告信息 App 可以忽略，SDK 会自动恢复。 例如和服务器失去连接时，SDK 可能会
  /// 上报 [WarningCode.LookupChannelTimeout] 警告，同时自动尝试重连。
  ///
  /// `WarningCallback` 包含如下参数：
  /// - [WarningCode] `warn`：警告码。详见 [WarningCode]。
  WarningCallback warning;

  /// 发生错误回调。
  ///
  /// 表示 SDK 运行时出现了（网络或媒体相关的）错误。通常情况下，SDK 上报的错误意味着 SDK 无法自动恢复，
  /// 需要 App 干预或提示用户。例如启动通话失败时，SDK 会上报 [ErrorCode.StartCall] 错误。
  /// App 可以提示用户启动通话失败，并调用 [RtcEngine.leaveChannel] 退出频道。
  ///
  /// `ErrorCallback` 包含如下参数：
  /// - [ErrorCode] `err`：错误码。详见 [ErrorCode]。
  ErrorCallback error;

  /// API 方法已执行回调。
  ///
  /// `ApiCallCallback` 包含如下参数：
  /// - [ErrorCode] `error`：错误码。如果方法调用失败，会返回错误码 [ErrorCode]。
  /// - [String] `api`：SDK 所调用的 API。
  /// - [String] `result`：SDK 调用 API 的调用结果。
  ///
  ApiCallCallback apiCallExecuted;

  /// 加入频道回调。
  ///
  /// 表示客户端已经登入服务器，且分配了频道 ID 和用户 ID。频道 ID 的分配是
  /// 根据 [RtcEngine.joinChannel] 方法中指定的频道名称。如果调用 [RtcEngine.joinChannel] 时并未指定用户 ID，服务器就会分配一个。
  ///
  /// `UidWithElapsedAndChannelCallback` 包含如下参数：
  /// - [String] `channel`：频道名。
  /// - [int] `uid`：用户 ID。
  /// - [int] `elapsed`：从 [RtcEngine.joinChannel] 开始到发生此事件过去的时间（毫秒)。
  ///
  UidWithElapsedAndChannelCallback joinChannelSuccess;

  /// 重新加入频道回调。
  ///
  /// 有时候由于网络原因，客户端可能会和服务器失去连接，SDK 会进行自动重连，自动重连成功后触发此回调方法。
  ///
  /// `UidWithElapsedAndChannelCallback` 包含如下参数：
  /// - [String] `channel`：频道名。
  /// - [int] `uid`：用户 ID。
  /// - [int] `elapsed`：从 [RtcEngine.joinChannel] 开始到发生此事件过去的时间（毫秒)。
  UidWithElapsedAndChannelCallback rejoinChannelSuccess;

  /// 离开频道回调。
  ///
  /// App 调用 [RtcEngine.leaveChannel]  方法时，SDK 提示 App 离开频道成功。
  /// 在该回调方法中，App 可以得到此次通话的总通话时长、SDK 收发数据的流量等信息。
  ///
  /// `RtcStatsCallback` 包含如下参数：
  /// - [RtcStats] `stats`：通话相关的统计信息。
  RtcStatsCallback leaveChannel;

  /// 本地用户成功注册 User Account 回调。
  ///
  /// 本地用户成功调用 [RtcEngine.registerLocalUserAccount] 方法注册用户 User Account，或调用 [RtcEngine.joinChannelWithUserAccount] 加入频道后，SDK 会触发该回调，
  /// 并告知本地用户的 UID 和 User Account。
  ///
  /// `UserAccountCallback` 包含如下参数：
  /// - [int] `uid`：本地用户的 ID。
  /// - [String] `userAccount`；本地用户的 User Account。
  UserAccountCallback localUserRegistered;

  /// 远端用户信息已更新回调。
  ///
  /// 远端用户加入频道后， SDK 会获取到该远端用户的 UID 和 User Account，然后缓存一个包含了远端用户 UID 和 User Account 的 Mapping 表，
  /// 并在本地触发该回调。
  ///
  /// `UserAccountCallback` 包含如下参数：
  /// - [int] `uid`：远端用户 ID。
  /// - [UserInfo] `userInfo`；标识用户信息的 `UserInfo` 对象，包含用户 UID 和 User Account。
  UserInfoCallback userInfoUpdated;

  /// 直播场景下用户角色已切换回调。如从观众切换为主播，反之亦然。
  ///
  /// 该回调由本地用户在加入频道后调用 [RtcEngine.setClientRole] 改变用户角色触发的。
  ///
  /// `ClientRoleCallback` 包含如下参数：
  /// - [ClientRole] `oldRole`：切换前的角色。
  /// - [ClientRole] `newRole`：切换后的角色。
  ClientRoleCallback clientRoleChanged;

  /// 远端用户（通信场景）/主播（直播场景）加入当前频道回调。
  ///
  /// - 通信场景下，该回调提示有远端用户加入了频道，并返回新加入用户的 ID；如果加入之前，已经有其他用户在频道中了，
  /// 新加入的用户也会收到这些已有用户加入频道的回调。
  /// - 直播场景下，该回调提示有主播加入了频道，并返回该主播的用户 ID。如果在加入之前，已经有主播在频道中了，
  /// 新加入的用户也会收到已有主播加入频道的回调。Agora 建议连麦主播不超过 17 人。
  ///
  /// 该回调在如下情况下会被触发：
  ///
  /// - 远端用户/主播调用 [RtcEngine.joinChannel] 方法加入频道。
  /// - 远端用户加入频道后调用 [RtcEngine.setClientRole] 将用户角色改变为主播。
  /// - 远端用户/主播网络中断后重新加入频道。
  /// - 主播通过调用 [RtcEngine.addInjectStreamUrl] 方法成功输入在线媒体流。
  ///
  /// **Note**
  ///
  /// 直播场景下：
  /// - 主播间能相互收到新主播加入频道的回调，并能获得该主播的用户 ID。
  /// - 观众也能收到新主播加入频道的回调，并能获得该主播的用户 ID。
  /// - 当 Web 端加入直播频道时，只要 Web 端有推流，SDK 会默认该 Web 端为主播，并触发该回调。
  ///
  /// `UidWithElapsedCallback` 包含如下参数：
  /// - [int] `uid`：新加入频道的远端用户/主播 ID。
  /// - [int] `elapsed`：从本地用户调用 [RtcEngine.joinChannel] 或 [RtcEngine.setClientRole] 到触发该回调的延迟（毫秒）。
  UidWithElapsedCallback userJoined;

  /// 远端用户（通信场景）/主播（直播场景）离开当前频道回调。
  ///
  /// 提示有远端用户/主播离开了频道（或掉线）。用户离开频道有两个原因，即正常离开和超时掉线：
  /// - 正常离开的时候，远端用户/主播会收到类似“再见”的消息，接收此消息后，判断用户离开频道。
  /// - 超时掉线的依据是，在一定时间内（约 20 秒），用户没有收到对方的任何数据包，则判定为对方掉线。在网络较差的情况下，
  /// 有可能会误报。Agora 建议使用 Agora 实时消息 SDK 来做可靠的掉线检测。
  ///
  /// `UserOfflineCallback` 包含如下参数：
  /// - [int] `uid`：主播 ID。
  /// - [UserOfflineReason] `reason`：离线原因。
  UserOfflineCallback userOffline;

  /// 网络连接状态已改变回调。
  ///
  /// 该回调在网络连接状态发生改变的时候触发，并告知用户当前的网络连接状态，和引起网络状态改变的原因。
  ///
  /// `ConnectionStateCallback` 包含如下参数：
  /// - [ConnectionStateType] `state`：当前的网络连接状态。
  /// - [ConnectionChangedReason] `reason`：引起当前网络连接状态发生改变的原因。
  ConnectionStateCallback connectionStateChanged;

  /// 本地网络类型发生改变回调。
  ///
  /// 本地网络连接类型发生改变时，SDK 会触发该回调，并在回调中明确当前的网络连接类型。
  /// 你可以通过该回调获取正在使用的网络类型；当连接中断时，该回调能辨别引起中断的原因是网络切换还是网络条件不好。
  ///
  /// `NetworkTypeCallback` 包含如下参数：
  /// - [NetworkType] `type`：网络连接类型。
  NetworkTypeCallback networkTypeChanged;

  /// 网络连接中断，且 SDK 无法在 10 秒内连接服务器回调。
  ///
  /// SDK 在调用 [RtcEngine.joinChannel] 后，无论是否加入成功，只要 10 秒和服务器无法连接就会触发该回调。
  ///
  /// 如果 SDK 在断开连接后，20 分钟内还是没能重新加入频道，SDK 会停止尝试重连。
  EmptyCallback connectionLost;

  /// Token 服务即将过期回调。
  ///
  /// 在调用 [RtcEngine.joinChannel] 时如果指定了 Token，
  /// 由于 Token 具有一定的时效，在通话过程中如果 Token 即将失效，SDK 会提前 30 秒触发该回调，提醒 App 更新 Token。
  /// 当收到该回调时，你需要重新在服务端生成新的 Token，然后调用 [RtcEngine.renewToken] 将新生成的 Token 传给 SDK。
  ///
  /// `TokenCallback` 包含如下参数：
  /// - [String] `token`：即将服务失效的 Token。
  TokenCallback tokenPrivilegeWillExpire;

  /// Token 过期回调。
  ///
  /// 在调用 [RtcEngine.joinChannel] 时如果指定了 Token，
  /// 由于 Token 具有一定的时效，在通话过程中 SDK 可能由于网络原因和服务器失去连接，重连时可能需要新的 Token。该回调通知 App 需要生成新的 Token，
  /// 并需调用 [RtcEngine.joinChannel] 重新加入频道。
  EmptyCallback requestToken;

  /// 提示频道内谁正在说话、说话者音量及本地用户是否在说话的回调。
  ///
  /// 该回调提示频道内瞬时音量最高的几个用户（最多三个）的用户 ID、他们的音量及本地用户是否在说话。
  ///
  /// 该回调默认禁用。可以通过启用说话者音量提示 [RtcEngine.enableAudioVolumeIndication] 方法开启；
  /// 开启后，无论频道内是否有人说话，都会按方法中设置的时间间隔返回提示音量。
  ///
  /// 每次触发，用户会收到两个独立的 `audioVolumeIndication` 回调，其中一个包含本地用户的音量信息，另一个包含远端所有用户的音量信息，详见下方参数描述。
  ///
  /// **Note**
  /// - 若需使用该回调 `speakers` 数组中的 `vad` 参数（即本地人声检测功能），请在 [RtcEngine.enableAudioVolumeIndication] 方法中设置 `report_vad` 为 `true`。
  /// - 用户调用 [RtcEngine.muteLocalAudioStream] 方法会对 SDK 行为产生影响：
  ///   - 本地用户调用该方法后 SDK 即不再返回本地用户的音量提示回调。
  ///   - 远端用户调用该方法后 20 秒，远端说话者的音量提示回调将不再包含该用户；如果所有远端用户调用该方法后 20 秒，
  /// SDK 即不再返回远端说话者的音量提示回调。
  ///
  /// `AudioVolumeCallback` 包含如下参数：
  /// - [List]<[AudioVolumeInfo]> `speakers`：每个说话者的用户 ID 和音量信息的数组。
  ///
  ///   - 在本地用户的回调中，此数组中包含以下成员:
  ///     - `uid` = 0;
  ///     - `volume` 等于 `totalVolume`，报告本地用户混音后的音量;
  ///     - `vad`，报告本地用户人声状态。
  ///
  ///   - 在远端用户的回调中，此数组中包含以下成员：
  ///     - `uid`，表示每位说话者的用户 ID；
  ///     - `volume`，表示各说话者混音后的音量；
  ///     - `vad` = 0，人声检测对远端用户无效。
  ///
  /// 如果报告的 `speakers` 数组为空，则表示远端此时没有人说话。
  ///
  /// - [int] `totalVolume`：（混音后的）总音量（0~255）。
  ///   - 在本地用户的回调中，`totalVolume` 为本地用户混音后的音量。
  ///   - 在远端用户的回调中，`totalVolume` 为所有说话者混音后的总音量。
  AudioVolumeCallback audioVolumeIndication;

  /// 监测到活跃用户回调。
  ///
  /// 该回调获取当前时间段内累积音量最大者。
  /// 如果该用户开启了 [RtcEngine.enableAudioVolumeIndication] 功能，
  /// 则当音量检测模块监测到频道内有新的活跃用户说话时，会通过本回调返回该用户的 `uid`。
  ///
  /// **Note**
  /// - 你需要开启 [RtcEngine.enableAudioVolumeIndication] 方法才能收到该回调。
  /// - `uid` 返回的是当前时间段内声音最大的用户 ID，而不是瞬时声音最大的用户 ID。
  ///
  /// `UidCallback` 包含如下参数：
  /// - [int] `uid`：当前时间段声音最大的用户的 `uid`。如果返回的 `uid` 为 0，则默认为本地用户。
  UidCallback activeSpeaker;

  /// 已发送本地音频首帧回调。
  ///
  /// `ElapsedCallback` 包含如下参数：
  /// - [int] `elapsed`：从本地用户调用 [RtcEngine.joinChannel] 方法直至该回调被触发的延迟（毫秒）。
  ElapsedCallback firstLocalAudioFrame;

  /// 已显示本地视频首帧回调。
  ///
  /// 第一帧本地视频显示在本地视图上时，触发此回调。
  ///
  /// `VideoFrameCallback` 包含如下参数：
  /// - [int] `width`：本地渲染视频的宽（px）。
  /// - [int] `height`：本地渲染视频的高（px）。
  /// - [int] `elapsed`：从本地用户调用 [RtcEngine.joinChannel] 方法直至该回调被触发的延迟（毫秒）。
  ///      如果在 [RtcEngine.joinChannel] 之前
  ///      调用了 [RtcEngine.startPreview]，则返回的是从调用 [RtcEngine.startPreview] 直至该回调被触发的延迟（毫秒）。
  VideoFrameCallback firstLocalVideoFrame;

  /// 远端用户停止/恢复发送视频流回调。
  ///
  /// **Deprecated**
  ///
  /// 该回调已废弃。请改用 [RtcEngineEventHandler.remoteVideoStateChanged] 回调中的如下参数实现相同功能：
  /// - [VideoRemoteState.Stopped] 和 [VideoRemoteStateReason.RemoteMuted]。
  /// - [VideoRemoteState.Decoding] 和 [VideoRemoteStateReason.RemoteUnmuted]。
  /// 该回调是由远端用户调用 [RtcEngine.muteLocalVideoStream] 方法关闭或开启视频发送触发的。
  ///
  /// **Note**
  ///
  /// 当频道内的用户（通信场景）或主播（直播场景）的人数超过 17 时，Agora 建议你不要使用该回调。
  ///
  /// `VideoFrameCallback` 包含如下参数：
  /// - [int] `uid`：用户 ID，提示是哪个用户的视频流。
  /// - [bool] `muted`：该用户是否暂停发送其视频流：
  ///   - `true`: 该用户已暂停发送视频流。
  ///   - `false`: 该用户已恢复发送视频流。
  @deprecated
  UidWithMutedCallback userMuteVideo;

  /// 本地或远端视频大小或旋转信息发生改变回调。
  ///
  /// `VideoSizeCallback` 包含如下参数：
  /// - [int] `uid`：图像尺寸和旋转信息发生变化的用户 ID。如果返回的 uid 为 0，则表示本地用户。
  /// - [int] `width`：视频流的宽度（像素）。
  /// - [int] `height`：视频流的高度（像素）。
  /// - [int] `rotation`：旋转信息 [0,360)。
  VideoSizeCallback videoSizeChanged;

  /// 远端用户视频状态发生已变化回调。
  ///
  /// `RemoteVideoStateCallback` 包含如下参数：
  /// - [int] `uid`：视频状态发生改变的远端用户 ID。
  /// - [VideoRemoteState] `state`：远端视频流状态。
  /// - [VideoRemoteStateReason] `reason`：远端视频流状态改变的具体原因。
  /// - [int] `elapsed`：从本地用户调用 [RtcEngine.joinChannel] 方法到发生本事件经历的时间，单位为 ms。
  RemoteVideoStateCallback remoteVideoStateChanged;

  /// 本地视频状态发生改变回调。
  ///
  /// 本地视频的状态发生改变时，SDK 会触发该回调返回当前的本地视频状态；
  /// 当状态为 [LocalVideoStreamState.Failed] 时，你可以在 `error` 参数中查看返回的错误信息。
  /// 该接口在本地视频出现故障时，方便你了解当前视频的状态以及出现故障的原因，方便排查问题。
  ///
  /// 该回调报告本地视频的当前状态。在 `RtcEngine` 生命周期内，该状态并非一成不变。因此我们建议记录该回调报告的状态，
  /// 并在启动相机前， 判断本地视频状态。如果状态为 [LocalVideoStreamError.CaptureFailure]，则说明相机权限被收回，或被抢占未释放。
  /// 可以通过先调用 [RtcEngine.enableLocalVideo] (`false`)，再调 [RtcEngine.enableLocalVideo] (`true`) 恢复相机。
  ///
  /// `LocalVideoStateCallback` 包含如下参数：
  /// - [LocalVideoStreamState] `localVideoState`：当前的本地视频状态。
  /// - [LocalVideoStreamError] `error`：本地视频出错原因。
  LocalVideoStateCallback localVideoStateChanged;

  /// 远端音频状态发生改变回调。
  ///
  /// 远端用户（通信场景）或主播（直播场景）音频状态发生改变时，SDK 会触发该回调向本地用户报告当前的远端音频流状态。
  ///
  /// **Note**
  ///
  /// 当频道内的用户（通信场景）或主播（直播场景）的人数超过 17 时，该回调可能不准确。
  ///
  /// `RemoteAudioStateCallback` 包含如下参数：
  /// - [int] `uid`：发生音频状态改变的远端用户 ID。
  /// - [AudioRemoteState] `state`：远端音频流状态。
  /// - [AudioRemoteStateReason] `reason`：远端音频流状态改变的具体原因。
  /// - [int] `elapsed`：从本地用户调用 [RtcEngine.joinChannel] 方法到发生本事件经历的时间，单位为 ms。
  RemoteAudioStateCallback remoteAudioStateChanged;

  /// 本地音频状态发生改变回调。
  ///
  /// 本地音频的状态发生改变时（包括本地麦克风录制状态和音频编码状态），SDK 会触发该回调报告当前的本地音频状态。
  /// 在本地音频出现故障时，该回调可以帮助你了解当前音频的状态以及出现故障的原因，方便你排查问题。
  ///
  /// **Note**
  ///
  ///  当状态为 [AudioLocalState.Failed] 时，你可以在 `error` 参数中查看返回的错误信息。
  ///
  /// `LocalAudioStateCallback` 包含如下参数：
  /// - [AudioLocalState] `state`：当前的本地音频状态。
  /// - [AudioLocalError] `error`：本地音频出错原因。
  LocalAudioStateCallback localAudioStateChanged;

  /// 本地发布流已回退为音频流回调。
  ///
  /// 如果你调用了设置本地推流回退选项 [RtcEngine.setLocalPublishFallbackOption] 接口并将 `option` 设置为 [StreamFallbackOptions.AudioOnly] 时，当上行网络环境不理想、本地发布的媒体流回退为音频流时，
  /// 或当上行网络改善、媒体流恢复为音视频流时，会触发该回调。
  ///
  /// 如果本地推流已回退为音频流，远端的 App 上会收到 [remoteVideoStateChanged] 的回调。
  ///
  /// `FallbackCallback` 包含如下参数：
  /// - [bool] `isFallbackOrRecover`：本地推流已回退或恢复：
  ///  - `true`: 由于网络环境不理想，本地发布的媒体流已回退为音频流。
  ///  - `false`: 由于网络环境改善，发布的音频流已恢复为音视频流。
  FallbackCallback localPublishFallbackToAudioOnly;

  /// 远端订阅流已回退为音频流回调或因网络质量改善，恢复为音视频流。
  ///
  /// 如果你调用了设置远端订阅流回退选项 [RtcEngine.setRemoteSubscribeFallbackOption] 接口并
  /// 将 `option` 设置为 [StreamFallbackOptions.AudioOnly] 时，当下行网络环境不理想、仅接收远端音频流时，
  /// 或当下行网络改善、恢复订阅音视频流时，会触发该回调。
  ///
  /// **Note**
  ///
  /// 远端订阅流因弱网环境不能同时满足音视频而回退为小流时，你可以使用 `remoteVideoStats` 来监控远端视频大小流的切换。
  ///
  /// `FallbackWithUidCallback` 包含如下参数：
  /// - [int] `uid`：远端用户的 ID。
  /// - [bool] `isFallbackOrRecover`：远端订阅流已回退或恢复：
  ///  - `true`: 由于网络环境不理想，远端订阅流已回退为音频流。
  ///  - `false`: 由于网络环境改善，订阅的音频流已恢复为音视频流。
  FallbackWithUidCallback remoteSubscribeFallbackToAudioOnly;

  /// 语音路由已变更回调。
  ///
  /// 该回调返回当前的音频路由已切换至听筒、扬声器、耳机或蓝牙。
  /// 关于语音路由的定义，详见 [AudioOutputRouting]。
  ///
  /// `AudioRouteCallback` 包含如下参数：
  /// - [AudioOutputRouting] `routing`：音频输出路由。
  AudioRouteCallback audioRouteChanged;

  /// 摄像头对焦区域已改变回调。
  ///
  /// 该回调是由本地用户调用 [RtcEngine.setCameraFocusPositionInPreview] 方法改变对焦位置触发的。
  ///
  /// `RectCallback` 包含如下参数：
  /// - [Rect] `rect`：镜头内表示对焦的区域。
  RectCallback cameraFocusAreaChanged;

  /// 摄像头曝光区域已改变回调。
  ///
  /// 该回调是由本地用户调用 [RtcEngine.setCameraExposurePosition] 方法改变曝光位置触发的。
  ///
  /// `RectCallback` 包含如下参数：
  /// - [Rect] `rect`：镜头内表示曝光的区域。
  RectCallback cameraExposureAreaChanged;

  /// 报告本地人脸检测结果。
  ///
  /// 调用 [RtcEngine.enableFaceDetection] 开启本地人脸检测后，你可以通过该回调实时获取以下人脸检测的信息：
  /// - 摄像头采集的画面大小。
  /// - 人脸在画面中的位置。
  /// - 人脸距设备屏幕的距离。
  ///
  /// 其中，人脸距设备屏幕的距离由 SDK 通过摄像头采集的画面大小和人脸在画面中的位置拟合计算得出。
  ///
  /// **Note**
  /// - 当检测到摄像头前没有人脸时，该回调触发频率会降低，以节省设备耗能。
  /// - 当人脸距离设备屏幕过近时，SDK 不会触发该回调。
  /// - Android 平台上，人脸距设备屏幕的距离（`distance`）值有一定误差，请不要用它进行精确计算。
  ///
  /// `FacePositionCallback` 包含如下参数：
  /// - [int] `imageWidth`：摄像头采集画面的宽度 (px)。
  /// - [int] `imageHeight`：摄像头采集画面的高度 (px)。
  /// - [List]<[FacePositionInfo]> `faces`：检测到的人脸信息，详见 [FacePositionInfo]。
  /// 检测到几张人脸，就会报告几个 `FacePositionInfo` 数组。数组长度可以为 0，表示没有检测到摄像头前出现人脸。
  FacePositionCallback facePositionChanged;

  ///
  /// 当前通话统计回调。
  /// 该回调在通话中每两秒触发一次。
  ///
  /// `RtcStatsCallback` 包含如下参数：
  /// - [RtcStats] `stats`：通话相关的统计信息。
  RtcStatsCallback rtcStats;

  /// 通话前网络上下行 last mile 质量报告回调。
  ///
  /// 该回调描述本地用户在加入频道前的 last mile 网络探测的结果，其中 last mile 是指设备到 Agora 边缘服务器的网络状态。
  /// 在 [RtcEngine.enableLastmileTest] 之后，该回调函数每 2 秒触发一次。
  ///
  /// `NetworkQualityCallback` 包含如下参数：
  /// - [NetworkQuality] `quality`：网络上下行质量，基于上下行网络的丢包率和抖动计算，探测结果主要反映上行网络的状态。
  NetworkQualityCallback lastmileQuality;

  /// 通话中每个用户的网络上下行 last mile 质量报告回调。
  ///
  /// 该回调描述每个用户在通话中的 last mile 网络状态，其中 last mile 是指设备到 Agora 边缘服务器的网络状态。
  /// 该回调每 2 秒触发一次。如果远端有多个用户/主播，该回调每 2 秒会被触发多次。
  ///
  /// `NetworkQualityWithUidCallback` 包含如下参数：
  /// - [int] `uid`：用户 ID。表示该回调报告的是持有该 ID 的用户的网络质量。当 `uid` 为 0 时，返回的是本地用户的网络质量。
  /// - [NetworkQuality] `txQuality`：该用户的上行网络质量，基于上行视频的发送码率、上行丢包率、平均往返时延和网络抖动计算。
  /// 该值代表当前的上行网络质量，帮助判断是否可以支持当前设置的视频编码属性。假设上行码率是 1000 Kbps，
  /// 那么支持 640 &times; 480 的分辨率、30 fps 的帧率没有问题，但是支持 1280 x 720 的分辨率就会有困难。
  /// - [NetworkQuality] `rxQuality`：该用户的下行网络质量，基于下行网络的丢包率、平均往返延时和网络抖动计算。
  NetworkQualityWithUidCallback networkQuality;

  /// 通话前网络上下行 Last mile 质量探测报告回调。
  ///
  /// 在调用 [RtcEngine.startLastmileProbeTest] 之后，SDK 会在约 30 秒内返回该回调。
  ///
  /// `LastmileProbeCallback` 包含如下参数：
  /// - [LastmileProbeResult] `result`：上下行 Last mile 质量探测结果。
  ///
  /// (result: LastmileProbeResult)
  LastmileProbeCallback lastmileProbeResult;

  /// 通话中本地视频流的统计信息回调。
  ///
  /// 该回调描述本地设备发送视频流的统计信息，每 2 秒触发一次。
  ///
  /// `LocalVideoStatsCallback` 包含如下参数：
  /// - [LocalVideoStats] `stats`：本地视频统计数据。
  LocalVideoStatsCallback localVideoStats;

  /// 通话中本地音频流的统计信息回调。
  ///
  /// 该回调描述本地设备发送音频流的统计信息。SDK 每 2 秒触发该回调一次。
  /// `LocalAudioStatsCallback` 包含如下参数：
  /// - [LocalAudioStats] `stats`：本地音频统计数据。
  LocalAudioStatsCallback localAudioStats;

  /// 通话中远端视频流的统计信息回调。
  ///
  /// 该回调描述远端用户在通话中端到端的视频流状态，针对每个远端用户/主播每 2 秒触发一次。
  /// 如果远端同时存在多个用户/主播，该回调每 2 秒会被触发多次。
  ///
  /// `RemoteVideoStatsCallback` 包含如下参数：
  /// - [RemoteVideoStats] `stats`：远端视频统计数据。
  RemoteVideoStatsCallback remoteVideoStats;

  /// 通话中远端音频流的统计信息回调。
  ///
  /// 该回调描述远端用户在通话中端到端的音频流统计信息，针对每个远端用户/主播每 2 秒触发一次。
  /// 如果远端同时存在多个用户/主播，该回调每 2 秒会被触发多次。
  ///
  /// 当网络发生丢包时，因 FEC（Forward Error Correction，向前纠错码）或重传恢复，最终的音频丢帧率不高，则可以认为整个质量较好。
  ///
  /// `RemoteAudioStatsCallback` 包含如下参数：
  /// - [RemoteAudioStats] `stats`：接收到的远端音频统计数据。
  RemoteAudioStatsCallback remoteAudioStats;

  /// 本地音乐文件播放已结束回调。
  ///
  /// **Deprecated**
  /// 该回调已废弃。我们建议你使用 [RtcEngineEventHandler.audioMixingStateChanged]。
  ///
  /// 当调用 [RtcEngine.startAudioMixing] 播放伴奏音乐结束后，会触发该回调。
  ///
  /// 如果该方法调用失败，会在 [warning] 回调里，返回警告码 [WarningCode.AudioMixingOpenError]。
  @deprecated
  EmptyCallback audioMixingFinished;

  /// 本地用户的音乐文件播放状态改变。
  /// 调用 [RtcEngine.startAudioMixing] 播放混音音乐文件后，当音乐文件的播放状态发生改变时，会触发该回调。
  ///
  ///    - 如果正常播放、暂停或停止播放音乐文件，会返回状态码 `710`、`711` 或 `713`，`errorCode` 返回 `0`。
  ///    - 如果播放出错，则返回状态码 `714`，`errorCode` 返回相应的出错原因。
  ///    - 如果本地音乐文件不存在、文件格式不支持、无法访问在线音乐文件 URL 都会返回警告码 [WarningCode.AudioMixingOpenError] = 701。
  ///
  /// `AudioMixingStateCallback` 包含如下参数：
  /// - [AudioMixingStateCode] `state`：状态码。
  /// - [AudioMixingErrorCode] `errorCode`：错误码。
  AudioMixingStateCallback audioMixingStateChanged;

  /// 本地音效文件播放已结束回调。
  ///
  /// 当调用 [RtcEngine.playEffect] 播放音效结束后，会触发该回调。
  ///
  /// `SoundIdCallback` 包含如下参数：
  /// - [int] `soundId`：指定音效的 ID。每个音效均有唯一的 ID。
  SoundIdCallback audioEffectFinished;

  /// RTMP 推流状态发生改变回调。该回调返回本地用户调用 [RtcEngine.addPublishStreamUrl]
  /// 或 [RtcEngine.removePublishStreamUrl] 方法的结果。
  ///
  /// RTMP/RTMPS 推流状态发生改变时，SDK 会触发该回调，并在回调中明确状态发生改变的 URL 地址及当前推流状态；当推流状态为 [RtmpStreamingState.Failure] 时，你可以在 `errCode` 参数中查看返回的错误信息。
  /// 该回调方便推流用户了解当前的推流状态；推流出错时，你可以通过返回的错误码了解出错的原因，方便排查问题。
  ///
  /// `RtmpStreamingStateCallback` 包含如下参数：
  /// - [String] `url`：推流状态发生改变的 URL 地址。
  /// - [RtmpStreamingState] `state`：当前的推流状态。
  /// - [RtmpStreamingErrorCode] `errCode`：详细的推流错误信息。
  RtmpStreamingStateCallback rtmpStreamingStateChanged;

  /// 旁路推流设置被更新回调。
  ///
  /// [RtcEngine.setLiveTranscoding] 方法中的直播转码参数 `LiveTranscoding` 更新时，该回调会被触发，并向主播报告更新信息。
  ///
  /// **Note**
  ///
  /// 首次调用 [RtcEngine.setLiveTranscoding] 方法设置转码参数时，不会触发该回调。
  EmptyCallback transcodingUpdated;

  /// 输入在线媒体流状态回调。该回调表明向直播输入的外部视频流的状态。
  ///
  /// `StreamInjectedStatusCallback` 包含如下参数：
  /// - [String] `url`：推流状态发生改变的 URL 地址。
  /// - [int] `uid`：用户 ID。
  /// - [InjectStreamStatus] `status`：输入的外部视频源状态。
  StreamInjectedStatusCallback streamInjectedStatus;

  /// 接收到对方数据流消息的回调。
  ///
  /// 该回调表示本地用户收到了远端用户调用 [RtcEngine.sendStreamMessage] 方法发送的流消息。
  ///
  /// `StreamMessageCallback` 包含如下参数：
  /// - [int] `uid`：用户 ID。
  /// - [int] `streamId`：数据流。
  /// - [String] `data`：接收到的数据。
  StreamMessageCallback streamMessage;

  /// 接收对方数据流消息发生错误的回调。
  ///
  /// 该回调表示本地用户未收到远端用户调用 [RtcEngine.sendStreamMessage] 方法发送的流消息。
  ///
  /// `StreamMessageErrorCallback` 包含如下参数：
  /// - [int] `uid`：用户 ID。
  /// - [int] `streamId`：数据流。
  /// - [ErrorCode] `error`：接收到的数据。
  /// - [int] `missed`：丢失的消息数量。
  /// - [int] `cached`：数据流中断时，后面缓存的消息数量。
  StreamMessageErrorCallback streamMessageError;

  /// 媒体引擎成功加载的回调。
  EmptyCallback mediaEngineLoadSuccess;

  /// 媒体引擎成功启动的回调。
  EmptyCallback mediaEngineStartCallSuccess;

  /// 跨频道媒体流转发状态发生改变回调。
  ///
  /// 当跨频道媒体流转发状态发生改变时，SDK 会触发该回调，并报告当前的转发状态以及相关的错误信息。
  ///
  /// `MediaRelayStateCallback` 包含如下参数：
  /// - [ChannelMediaRelayState] `state`：跨频道媒体流转发状态。
  /// - [ChannelMediaRelayError] `code`：跨频道媒体流转发出错的错误码。
  MediaRelayStateCallback channelMediaRelayStateChanged;

  /// 跨频道媒体流转发事件回调。
  ///
  /// 该回调报告跨频道媒体流转发过程中发生的事件。
  ///
  /// `MediaRelayEventCallback` 包含如下参数：
  /// - [ChannelMediaRelayEvent] `code`：跨频道媒体流转发事件码。
  MediaRelayEventCallback channelMediaRelayEvent;

  /// 已显示远端视频首帧回调。
  ///
  /// **Deprecated**
  ///
  /// 该回调已废弃。请改用 [remoteVideoStateChanged] 中的 [VideoRemoteState.Starting] 和 [VideoRemoteState.Decoding] 代替。
  ///
  /// 第一帧远端视频显示在视图上时，触发此调用。App 可在此调用中获知出图时间（elapsed）。
  ///
  /// `VideoFrameWithUidCallback` 包含如下参数：
  /// - [int] `uid`：用户 ID，指定是哪个用户的视频流。
  /// - [int] `width`：视频流宽（像素）。
  /// - [int] `height`：视频流高（像素）。
  /// - [int] `elapsed`：从本地用户调用 [RtcEngine.joinChannel] 加入频道开始到发生此事件过去的时间（毫秒）。
  @deprecated
  VideoFrameWithUidCallback firstRemoteVideoFrame;

  /// 已接收远端音频首帧回调。
  ///
  /// **Deprecated**
  ///
  /// 该回调已废弃。请改用 [remoteAudioStateChanged] 中的 [AudioRemoteState.Starting]。
  ///
  /// `UidWithElapsedCallback` 包含如下参数：
  /// - [int] `uid`：新加入频道的远端用户/主播 ID。
  /// - [int] `elapsed`：从本地用户调用 [RtcEngine.joinChannel] 或 [RtcEngine.setClientRole] 到触发该回调的延迟（毫秒）。
  @deprecated
  UidWithElapsedCallback firstRemoteAudioFrame;

  /// 已解码远端音频首帧回调。
  ///
  /// **Deprecated**
  ///
  /// 该回调已废弃，请改用 [remoteAudioStateChanged] 中的 [VideoRemoteState.Decoding]。
  ///
  /// SDK 完成远端音频首帧解码，并发送给音频模块用以播放时，会触发此回调。有两种情况：
  /// - 远端用户首次上线后发送音频。
  /// - 远端用户音频离线再上线发送音频。音频离线指本地在 15 秒内没有收到音频包，可能有如下原因：
  ///   - 远端用户离开频道。
  ///   - 远端用户掉线。
  ///   - 远端用户停止发送音频流（调用了 [RtcEngine.muteLocalAudioStream] 方法）。
  ///   - 远端用户关闭音频（调用了 [RtcEngine.disableAudio] 方法）。
  ///
  /// `UidWithElapsedCallback` 包含如下参数：
  /// - [int] `uid`：新加入频道的远端用户/主播 ID。
  /// - [int] `elapsed`：从本地用户调用 [RtcEngine.joinChannel] 或 [RtcEngine.setClientRole] 到触发该回调的延迟（毫秒）。
  @deprecated
  UidWithElapsedCallback firstRemoteAudioDecoded;

  /// 远端用户停止/恢复发送音频流回调。
  ///
  /// **Deprecated**
  ///
  /// 该回调已废弃，请改用 [remoteAudioStateChanged] 回调中的如下参数实现相同功能：
  /// - [VideoRemoteState.Stopped] 和 [VideoRemoteStateReason.RemoteMuted]
  /// - [VideoRemoteState.Decoding] 和 [VideoRemoteStateReason.RemoteUnmuted]
  ///
  /// 提示有其他用户将他的音频流静音/取消静音。
  ///
  /// 该回调是由远端用户调用 [RtcEngine.muteLocalAudioStream] 方法关闭或开启音频发送触发的。
  ///
  /// **Note**
  ///
  /// 当频道内的用户（通信场景）或主播（直播场景）的人数超过 17 时，Agora 建议你不要使用该回调。
  ///
  /// `UidWithMutedCallback` 包含如下参数：
  /// - [int] `uid`：用户 ID，提示是哪个用户的视频流。
  /// - [bool] `muted`：该用户是否暂停发送其视频流：
  ///   - `true`: 该用户已暂停发送视频流。
  ///   - `false`: 该用户已恢复发送视频流。
  @deprecated
  UidWithMutedCallback userMuteAudio;

  /// 开启旁路推流的结果回调。
  ///
  /// **Deprecated**
  ///
  /// 该回调已废弃。请改用 [RtcEngineEventHandler.rtmpStreamingStateChanged]。
  ///
  /// 该回调返回 [RtcEngine.addPublishStreamUrl] 方法的调用结果。
  /// 用于通知主播是否推流成功。如果不成功，你可以在 `error` 参数中查看详细的错误信息。
  ///
  /// `UrlWithErrorCallback` 包含如下参数：
  /// - [String] `url`：新增的推流地址。
  /// - [ErrorCode] `error`：详细的错误信息。
  @deprecated
  UrlWithErrorCallback streamPublished;

  /// 停止旁路推流的结果回调。
  ///
  ///
  /// **Deprecated**
  ///
  /// 该回调已废弃。请改用 [RtcEngineEventHandler.rtmpStreamingStateChanged]。
  ///
  /// 该回调返回 [RtcEngine.removePublishStreamUrl] 方法的调用结果。用于通知主播是否停止推流成功。
  ///
  /// `UrlCallback` 包含如下参数：
  /// - [String] `url`：主播停止推流的 RTMP 地址。
  @deprecated
  UrlCallback streamUnpublished;

  /// 通话中远端音频流传输的统计信息回调。
  ///
  ///
  /// **Deprecated**
  ///
  /// 该回调已废弃。请改用 [RtcEngineEventHandler.remoteAudioStats]。
  ///
  /// 该回调描述远端用户通话中端到端的网络统计信息，通过音频包计算，用客观的数据，如丢包、网络延迟等，展示当前网络状态。
  ///
  /// 通话中，当用户收到远端用户/主播发送的音频数据包后，会每 2 秒触发一次该回调。
  ///
  /// `TransportStatsCallback` 包含如下参数：
  /// - [int] `uid`：用户 ID，指定是哪个用户/主播的音频包。
  /// - [int] `delay`：音频包从发送端到接收端的延时（毫秒）。
  /// - [int] `lost`：音频包从发送端到接收端的丢包率 (%)。
  /// - [int] `rxKBitRate`：远端音频包的接收码率（Kbps）。
  @deprecated
  TransportStatsCallback remoteAudioTransportStats;

  /// 通话中远端视频流传输的统计信息回调。
  ///
  /// **Deprecated**
  ///
  /// 该回调已废弃。请改用 [RtcEngineEventHandler.remoteVideoStats]。
  ///
  /// 该回调描述远端用户通话中端到端的网络统计信息，通过视频包计算，用客观的数据，如丢包、网络延迟等 ，展示当前网络状态。
  ///
  /// 通话中，当用户收到远端用户/主播发送的视频数据包后，会每 2 秒触发一次该回调。
  ///
  /// `TransportStatsCallback` 包含如下参数：
  /// - [int] `uid`：用户 ID，指定是哪个用户/主播的视频包。
  /// - [int] `delay`：视频包从发送端到接收端的延时（毫秒）。
  /// - [int] `lost`：视频包从发送端到接收端的丢包率 (%)。
  /// - [int] `rxKBitRate`：远端视频包的接收码率（Kbps）。
  @deprecated
  TransportStatsCallback remoteVideoTransportStats;

  /// 其他用户开/关视频模块回调。
  ///
  /// **Deprecated**
  ///
  /// 该回调已废弃。请改用 [RtcEngineEventHandler.remoteVideoStateChanged] 回调中的如下参数：
  /// - [VideoRemoteState.Stopped] 和 [VideoRemoteStateReason.RemoteMuted]
  /// - [VideoRemoteState.Decoding] 和 [VideoRemoteStateReason.RemoteUnmuted]
  ///
  /// 提示有其他用户启用/关闭了视频功能。
  ///
  /// 该回调是由远端用户调用 [RtcEngine.enableVideo] 或 [RtcEngine.disableVideo][`enableVideo`] 方法开启或关闭视频模块触发的。
  ///
  /// **Note**
  ///
  /// 当频道内的用户（通信场景）或主播（直播场景）的人数超过 17 时，Agora 建议你不要使用该回调。
  ///
  /// `UidWithEnabledCallback` 包含如下参数：
  /// - [int] `uid`：用户 ID，提示是哪个用户的视频流。
  /// - [bool] `enabled`：是否启用视频功能：
  ///  - `true`: 该用户已启用视频功能。启用后，该用户可以进行视频通话或直播。
  ///  - `false`: 该用户已关闭视频功能。关闭后，该用户只能进行语音通话或直播，不能显示、发送自己的视频，也不能接收、显示别人的视频。
  @deprecated
  UidWithEnabledCallback userEnableVideo;

  /// 远端用户开/关本地视频采集回调。
  ///
  /// **Deprecated**
  ///
  /// 该回调已废弃。请改用 [RtcEngineEventHandler.remoteVideoStateChanged] 回调中的如下参数：
  /// - [VideoRemoteState.Stopped] 和 [VideoRemoteStateReason.RemoteMuted]
  /// - [VideoRemoteState.Decoding] 和 [VideoRemoteStateReason.RemoteUnmuted]
  ///
  /// 提示有其他用户启用/关闭了本地视频功能。
  ///
  /// 该回调是由远端用户调用 [RtcEngine.enableLocalVideo] 方法开启或关闭视频采集触发的。
  ///
  /// `UidWithEnabledCallback` 包含如下参数：
  /// - [int] `uid`：用户 ID，提示是哪个用户的视频流。
  /// - [bool] `enabled`：是否启用视频功能：
  ///  - `true`: 该用户已启用视频功能。启用后，该用户可以进行视频通话或直播。
  ///  - `false`: 该用户已关闭视频功能。关闭后，该用户只能进行语音通话或直播，不能显示、发送自己的视频，也不能接收、显示别人的视频。
  @deprecated
  UidWithEnabledCallback userEnableLocalVideo;

  /// 已完成远端视频首帧解码回调。
  ///
  /// **Deprecated**
  ///
  /// 该回调已废弃。请改用 [RtcEngineEventHandler.remoteVideoStateChanged] 回调中的 [VideoRemoteState.Starting] 或 [VideoRemoteState.Decoding]。
  ///
  /// 本地收到远端第一个视频帧并解码成功后，会触发该回调。有两种情况：
  ///
  /// - 远端用户首次上线后发送视频。
  /// - 远端用户视频离线再上线后发送视频。
  ///
  /// 其中，视频离线与用户离线不同。视频离线指本地在 15 秒内没有收到视频包，可能有如下原因：
  ///
  /// - 远端用户离开频道。
  /// - 远端用户掉线。
  /// - 远端用户停止发送本地视频流（调用了 [RtcEngine.muteLocalVideoStream]）。
  /// - 远端用户关闭本地视频模块（调用了 [RtcEngine.disableVideo]）。
  ///
  /// `VideoFrameWithUidCallback` 包含如下参数：
  /// - [int] `uid`：用户 ID，指定是哪个用户的视频流。
  /// - [int] `width`：视频流宽（像素）。
  /// - [int] `height`：视频流高（像素）。
  /// - [int] `elapsed`：从本地用户调用 [RtcEngine.joinChannel] 加入频道开始到发生此事件过去的时间（毫秒）。
  @deprecated
  VideoFrameWithUidCallback firstRemoteVideoDecoded;

  /// 麦克风状态已改变回调。
  ///
  /// **Deprecated**
  ///
  /// 该回调已废弃。请改用 [RtcEngineEventHandler.localAudioStateChanged] 回调中的 [AudioLocalState.Stopped] 或 [AudioLocalState.Recording]。
  ///
  /// 该回调由本地用户调用 [RtcEngine.enableLocalAudio] 方法开启或关闭本地音频采集触发的。
  ///
  /// `EnabledCallback` 包含如下参数：
  /// - [bool] `enabled`：是否启用麦克风：
  ///  - `true`：麦克风已启用。
  ///  - `false`：麦克风已禁用。
  @deprecated
  EnabledCallback microphoneEnabled;

  /// 网络连接中断回调。
  ///
  /// **Deprecated**
  ///
  /// 该回调已经废弃。请改用 [RtcEngineEventHandler.connectionStateChanged] 回调。
  ///
  /// SDK 在和服务器建立连接后，失去了网络连接超过 4 秒，会触发该回调。在触发事件后，SDK 会主动重连服务器，所以该事件可以用于 UI 提示。
  /// 与 [RtcEngineEventHandler.connectionLost] 回调的区别是：
  ///
  /// - [RtcEngineEventHandler.connectionInterrupted] 回调一定是发生在 [RtcEngine.joinChannel] 成功后，且 SDK 刚失去和服务器连接超过 4 秒时触发。
  /// - [RtcEngineEventHandler.connectionLost] 回调是无论之前 [RtcEngine.joinChannel] 是否连接成功，只要 10 秒内和服务器无法建立连接都会触发。
  ///
  /// 如果 SDK 在断开连接后，20 分钟内还是没能重新加入频道，SDK 会停止尝试重连。
  @deprecated
  EmptyCallback connectionInterrupted;

  /// 网络连接已被服务器禁止回调。
  ///
  ///  **Deprecated**
  ///
  /// 该回调已废弃。请改用 [RtcEngineEventHandler.connectionStateChanged] 回调。
  ///
  /// 当你被服务端禁掉连接的权限时，会触发该回调。
  @deprecated
  EmptyCallback connectionBanned;

  /// 远端音频质量回调。
  ///
  /// **Deprecated**
  ///
  /// 该回调已废弃。请改用 [RtcEngineEventHandler.remoteAudioStats] 方法。
  ///
  /// 该回调描述远端用户在通话中的音频质量，针对每个远端用户/主播每 2 秒触发一次。如果远端同时存在多个用户/主播，该回调每 2 秒会被触发多次。
  ///
  /// `EnabledCallback` 包含如下参数：
  /// - [int] `uid`：用户 ID，指定是谁发的音频流。
  /// - [int] `quality`：语音质量。
  /// - [int] `delay`：音频包从发送端到接收端的延迟（毫秒）。包括声音采样前处理、网络传输、网络抖动缓冲引起的延迟。
  /// - [int] `lost`：音频包从发送端到接收端的丢包率 (%)。
  @deprecated
  AudioQualityCallback audioQuality;

  /// 摄像头就绪回调。
  ///
  /// **Deprecated**
  ///
  /// 该回调已废弃。请改用 [RtcEngineEventHandler.localVideoStateChanged] 回调中的 [LocalVideoStreamState.Capturing]。
  /// 提示已成功打开摄像头，可以开始捕获视频。如果摄像头打开失败，可在 [Error] 中处理相应错误。
  @deprecated
  EmptyCallback cameraReady;

  /// 视频功能停止回调。
  ///
  /// **Deprecated**
  ///
  /// 该回调已废弃。请改用 [RtcEngineEventHandler.localVideoStateChanged] 回调中的 [LocalVideoStreamState.Stopped]。
  /// 提示视频功能已停止。 App 如需在停止视频后对 view 做其他处理（例如显示其他画面），可以在这个回调中进行。
  @deprecated
  EmptyCallback videoStopped;

  /// 接收端已接收 Metadata。
  ///
  /// `MetadataCallback` 包含如下参数：
  /// - [String] `buffer`：接收到的 Metadata 数据 Buffer。
  /// - [int] `uid`：发送该 Metadata 的远端用户的 ID。
  /// - [int] `timeStampMs`：接收到的 Metadata 的时间戳，单位为毫秒 。
  MetadataCallback metadataReceived;

  /// 已发布本地音频首帧回调。
  ///
  ///
  ///
  /// SDK 会在以下三种时机触发该回调：
  /// - 开启本地音频的情况下，调用 [RtcEngine.joinChannel] 成功加入频道后。
  /// - 调用 [RtcEngine.muteLocalAudioStream] (`true`)，再调用 [RtcEngine.muteLocalAudioStream] (`false`) 后。
  /// - 调用 [RtcEngine.disableAudio]，再调用 [RtcEngine.enableAudio] 后。
  ///
  /// `ElapsedCallback` 包含如下参数：
  /// - [int] `elapsed`：从本地用户调用 [RtcEngine.joinChannel] 方法直至该回调被触发的延迟（毫秒）。
  ElapsedCallback firstLocalAudioFramePublished;

  /// 已发布本地视频首帧回调。
  ///
  ///
  ///
  /// SDK 会在以下三种时机触发该回调：
  /// - 开启本地视频的情况下，调用 [RtcEngine.joinChannel] 成功加入频道后。
  /// - 调用 [RtcEngine.muteLocalVideoStream] (`true`)，再调用[RtcEngine.muteLocalVideoStream] (`false`) 后。
  /// - 调用 [RtcEngine.disableVideo]，再调用 [RtcEngine.enableVideo] 后。
  ElapsedCallback firstLocalVideoFramePublished;

  /// 音频发布状态改变回调。
  ///
  ///
  ///
  /// `StreamPublishStateCallback` 包含如下参数：
  /// - [String] `channel` 频道名。
  /// - [StreamPublishState] `oldState` 之前的发布状态。
  /// - [StreamPublishState] `newState` 当前的发布状态。
  /// - [int] `elapseSinceLastState` 两次状态变化时间间隔（毫秒）。
  StreamPublishStateCallback audioPublishStateChanged;

  /// 视频发布状态改变回调。
  ///
  ///
  ///
  /// `StreamPublishStateCallback` 包含如下参数：
  /// - [String] `channel` 频道名。
  /// - [StreamPublishState] `oldState` 之前的发布状态。
  /// - [StreamPublishState] `newState` 当前的发布状态。
  /// - [int] `elapseSinceLastState` 两次状态变化时间间隔（毫秒）。
  StreamPublishStateCallback videoPublishStateChanged;

  /// 音频订阅状态发生改变回调。
  ///
  ///
  ///
  /// `StreamSubscribeStateCallback` 包含如下参数：
  /// - [String] `channel` 频道名。
  /// - [StreamSubscribeState] `oldState` 之前的订阅状态。
  /// - [StreamSubscribeState] `newState` 当前的订阅状态。
  /// - [int] `elapseSinceLastState` 两次状态变化时间间隔（毫秒）。
  StreamSubscribeStateCallback audioSubscribeStateChanged;

  /// 视频订阅状态发生改变回调。
  ///
  ///
  ///
  /// `StreamSubscribeStateCallback` 包含如下参数：
  /// - [String] `channel` 频道名。
  /// - [StreamSubscribeState] `oldState` 之前的订阅状态。
  /// - [StreamSubscribeState] `newState` 当前的订阅状态。
  /// - [int] `elapseSinceLastState` 两次状态变化时间间隔（毫秒）。
  StreamSubscribeStateCallback videoSubscribeStateChanged;

  /// RTMP 推流事件回调。
  ///
  ///
  ///
  /// `RtmpStreamingEventCallback` 包含如下参数：
  /// - [String] `url` RTMP 推流 URL。
  /// - [RtmpStreamingEvent] `eventCode` RTMP 推流事件码。
  RtmpStreamingEventCallback rtmpStreamingEvent;

  /// Constructs a [RtcEngineEventHandler]
  RtcEngineEventHandler(
      {this.warning,
      this.error,
      this.apiCallExecuted,
      this.joinChannelSuccess,
      this.rejoinChannelSuccess,
      this.leaveChannel,
      this.localUserRegistered,
      this.userInfoUpdated,
      this.clientRoleChanged,
      this.userJoined,
      this.userOffline,
      this.connectionStateChanged,
      this.networkTypeChanged,
      this.connectionLost,
      this.tokenPrivilegeWillExpire,
      this.requestToken,
      this.audioVolumeIndication,
      this.activeSpeaker,
      this.firstLocalAudioFrame,
      this.firstLocalVideoFrame,
      this.userMuteVideo,
      this.videoSizeChanged,
      this.remoteVideoStateChanged,
      this.localVideoStateChanged,
      this.remoteAudioStateChanged,
      this.localAudioStateChanged,
      this.localPublishFallbackToAudioOnly,
      this.remoteSubscribeFallbackToAudioOnly,
      this.audioRouteChanged,
      this.cameraFocusAreaChanged,
      this.cameraExposureAreaChanged,
      this.facePositionChanged,
      this.rtcStats,
      this.lastmileQuality,
      this.networkQuality,
      this.lastmileProbeResult,
      this.localVideoStats,
      this.localAudioStats,
      this.remoteVideoStats,
      this.remoteAudioStats,
      this.audioMixingFinished,
      this.audioMixingStateChanged,
      this.audioEffectFinished,
      this.rtmpStreamingStateChanged,
      this.transcodingUpdated,
      this.streamInjectedStatus,
      this.streamMessage,
      this.streamMessageError,
      this.mediaEngineLoadSuccess,
      this.mediaEngineStartCallSuccess,
      this.channelMediaRelayStateChanged,
      this.channelMediaRelayEvent,
      this.firstRemoteVideoFrame,
      this.firstRemoteAudioFrame,
      this.firstRemoteAudioDecoded,
      this.userMuteAudio,
      this.streamPublished,
      this.streamUnpublished,
      this.remoteAudioTransportStats,
      this.remoteVideoTransportStats,
      this.userEnableVideo,
      this.userEnableLocalVideo,
      this.firstRemoteVideoDecoded,
      this.microphoneEnabled,
      this.connectionInterrupted,
      this.connectionBanned,
      this.audioQuality,
      this.cameraReady,
      this.videoStopped,
      this.metadataReceived,
      this.firstLocalAudioFramePublished,
      this.firstLocalVideoFramePublished,
      this.audioPublishStateChanged,
      this.videoPublishStateChanged,
      this.audioSubscribeStateChanged,
      this.videoSubscribeStateChanged,
      this.rtmpStreamingEvent,
      this.userSuperResolutionEnabled,
      this.uploadLogResult});

  // ignore: public_member_api_docs
  void process(String methodName, List<dynamic> data) {
    switch (methodName) {
      case 'Warning':
        warning?.call(WarningCodeConverter.fromValue(data[0]).e);
        break;
      case 'Error':
        error?.call(ErrorCodeConverter.fromValue(data[0]).e);
        break;
      case 'ApiCallExecuted':
        apiCallExecuted?.call(
            ErrorCodeConverter.fromValue(data[0]).e, data[1], data[2]);
        break;
      case 'JoinChannelSuccess':
        joinChannelSuccess?.call(data[0], data[1], data[2]);
        break;
      case 'RejoinChannelSuccess':
                rejoinChannelSuccess?.call(data[0], data[1], data[2]);
        break;
      case 'LeaveChannel':
        leaveChannel
            ?.call(RtcStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'LocalUserRegistered':
        localUserRegistered?.call(data[0], data[1]);
        break;
      case 'UserInfoUpdated':
        userInfoUpdated?.call(
            data[0], UserInfo.fromJson(Map<String, dynamic>.from(data[1])));
        break;
      case 'ClientRoleChanged':
        clientRoleChanged?.call(ClientRoleConverter.fromValue(data[0]).e,
            ClientRoleConverter.fromValue(data[1]).e);
        break;
      case 'UserJoined':
        userJoined?.call(data[0], data[1]);
        break;
      case 'UserOffline':
        userOffline?.call(
            data[0], UserOfflineReasonConverter.fromValue(data[1]).e);
        break;
      case 'ConnectionStateChanged':
        connectionStateChanged?.call(
            ConnectionStateTypeConverter.fromValue(data[0]).e,
            ConnectionChangedReasonConverter.fromValue(data[1]).e);
        break;
      case 'NetworkTypeChanged':
        networkTypeChanged?.call(NetworkTypeConverter.fromValue(data[0]).e);
        break;
      case 'ConnectionLost':
        connectionLost?.call();
        break;
      case 'TokenPrivilegeWillExpire':
        tokenPrivilegeWillExpire?.call(data[0]);
        break;
      case 'RequestToken':
        requestToken?.call();
        break;
      case 'AudioVolumeIndication':
        final list = List<Map>.from(data[0]);
        audioVolumeIndication?.call(
            List.generate(
                list.length,
                    (index) => AudioVolumeInfo.fromJson(
                        Map<String, dynamic>.from(list[index]))),
            data[1]);
        break;
      case 'ActiveSpeaker':
        activeSpeaker?.call(data[0]);
        break;
      case 'FirstLocalAudioFrame':
        firstLocalAudioFrame?.call(data[0]);
        break;
      case 'FirstLocalVideoFrame':
        firstLocalVideoFrame?.call(data[0], data[1], data[2]);
        break;
      case 'UserMuteVideo':
        userMuteVideo?.call(data[0], data[1]);
        break;
      case 'VideoSizeChanged':
        videoSizeChanged?.call(data[0], data[1], data[2], data[3]);
        break;
      case 'RemoteVideoStateChanged':
        remoteVideoStateChanged?.call(
            data[0],
            VideoRemoteStateConverter.fromValue(data[1]).e,
            VideoRemoteStateReasonConverter.fromValue(data[2]).e,
            data[3]);
        break;
      case 'LocalVideoStateChanged':
            localVideoStateChanged?.call(
            LocalVideoStreamStateConverter.fromValue(data[0]).e,
            LocalVideoStreamErrorConverter.fromValue(data[1]).e);
        break;
      case 'RemoteAudioStateChanged':
        remoteAudioStateChanged?.call(
            data[0],
            AudioRemoteStateConverter.fromValue(data[1]).e,
            AudioRemoteStateReasonConverter.fromValue(data[2]).e,
            data[3]);
        break;
      case 'LocalAudioStateChanged':
            localAudioStateChanged?.call(
            AudioLocalStateConverter.fromValue(data[0]).e,
            AudioLocalErrorConverter.fromValue(data[1]).e);
        break;
      case 'LocalPublishFallbackToAudioOnly':
        localPublishFallbackToAudioOnly?.call(data[0]);
        break;
      case 'RemoteSubscribeFallbackToAudioOnly':
        remoteSubscribeFallbackToAudioOnly?.call(data[0], data[1]);
        break;
      case 'AudioRouteChanged':
        audioRouteChanged
            ?.call(AudioOutputRoutingConverter.fromValue(data[0]).e);
        break;
      case 'CameraFocusAreaChanged':
        cameraFocusAreaChanged
            ?.call(Rect.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'CameraExposureAreaChanged':
        cameraExposureAreaChanged
            ?.call(Rect.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'FacePositionChanged':
        final list = List<Map>.from(data[2]);
        facePositionChanged?.call(
            data[0],
            data[1],
            List.generate(
                list.length,
                    (index) => FacePositionInfo.fromJson(
                        Map<String, dynamic>.from(list[index]))));
        break;
      case 'RtcStats':
        rtcStats?.call(RtcStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'LastmileQuality':
        lastmileQuality?.call(NetworkQualityConverter.fromValue(data[0]).e);
        break;
      case 'NetworkQuality':
        networkQuality?.call(
            data[0],
            NetworkQualityConverter.fromValue(data[1]).e,
            NetworkQualityConverter.fromValue(data[2]).e);
        break;
      case 'LastmileProbeResult':
        lastmileProbeResult?.call(
            LastmileProbeResult.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'LocalVideoStats':
        localVideoStats?.call(
            LocalVideoStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'LocalAudioStats':
        localAudioStats?.call(
            LocalAudioStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'RemoteVideoStats':
        remoteVideoStats?.call(
            RemoteVideoStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'RemoteAudioStats':
        remoteAudioStats?.call(
            RemoteAudioStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'AudioMixingFinished':
        audioMixingFinished?.call();
        break;
      case 'AudioMixingStateChanged':
        audioMixingStateChanged?.call(
          AudioMixingStateCodeConverter.fromValue(data[0]).e,
          AudioMixingErrorCodeConverter.fromValue(data[1]).e,
        );
        break;
      case 'AudioEffectFinished':
        audioEffectFinished?.call(data[0]);
        break;
      case 'RtmpStreamingStateChanged':
        rtmpStreamingStateChanged?.call(
          data[0],
          RtmpStreamingStateConverter.fromValue(data[1]).e,
          RtmpStreamingErrorCodeConverter.fromValue(data[2]).e,
        );
        break;
      case 'TranscodingUpdated':
        transcodingUpdated?.call();
        break;
      case 'StreamInjectedStatus':
        streamInjectedStatus?.call(
            data[0], data[1], InjectStreamStatusConverter.fromValue(data[2]).e);
        break;
      case 'StreamMessage':
        streamMessage?.call(data[0], data[1], data[2]);
        break;
      case 'StreamMessageError':
        streamMessageError?.call(data[0], data[1],
            ErrorCodeConverter.fromValue(data[2]).e, data[3], data[4]);
        break;
      case 'MediaEngineLoadSuccess':
        mediaEngineLoadSuccess?.call();
        break;
      case 'MediaEngineStartCallSuccess':
        mediaEngineStartCallSuccess?.call();
        break;
      case 'ChannelMediaRelayStateChanged':
        channelMediaRelayStateChanged?.call(
          ChannelMediaRelayStateConverter.fromValue(data[0]).e,
          ChannelMediaRelayErrorConverter.fromValue(data[1]).e,
        );
        break;
      case 'ChannelMediaRelayEvent':
        channelMediaRelayEvent
            ?.call(ChannelMediaRelayEventConverter.fromValue(data[0]).e);
        break;
      case 'FirstRemoteVideoFrame':
        firstRemoteVideoFrame?.call(data[0], data[1], data[2], data[3]);
        break;
      case 'FirstRemoteAudioFrame':
        firstRemoteAudioFrame?.call(data[0], data[1]);
        break;
      case 'FirstRemoteAudioDecoded':
        firstRemoteAudioDecoded?.call(data[0], data[1]);
        break;
      case 'UserMuteAudio':
        userMuteAudio?.call(data[0], data[1]);
        break;
      case 'StreamPublished':
        streamPublished?.call(data[0], ErrorCodeConverter.fromValue(data[1]).e);
        break;
      case 'StreamUnpublished':
        streamUnpublished?.call(data[0]);
        break;
      case 'RemoteAudioTransportStats':
        remoteAudioTransportStats?.call(data[0], data[1], data[2], data[3]);
        break;
      case 'RemoteVideoTransportStats':
        remoteVideoTransportStats?.call(data[0], data[1], data[2], data[3]);
        break;
      case 'UserEnableVideo':
        userEnableVideo?.call(data[0], data[1]);
        break;
      case 'UserEnableLocalVideo':
        userEnableLocalVideo?.call(data[0], data[1]);
        break;
      case 'FirstRemoteVideoDecoded':
        firstRemoteVideoDecoded?.call(data[0], data[1], data[2], data[3]);
        break;
      case 'MicrophoneEnabled':
        microphoneEnabled?.call(data[0]);
        break;
      case 'ConnectionInterrupted':
        connectionInterrupted?.call();
        break;
      case 'ConnectionBanned':
        connectionBanned?.call();
        break;
      case 'AudioQuality':
        audioQuality?.call(data[0], data[1], data[2], data[3]);
        break;
      case 'CameraReady':
        cameraReady?.call();
        break;
      case 'VideoStopped':
        videoStopped?.call();
        break;
      case 'MetadataReceived':
        metadataReceived?.call(data[0], data[1], data[2]);
        break;
        case 'FirstLocalAudioFramePublished':
        firstLocalAudioFramePublished?.call(data[0]);
        break;
      case 'FirstLocalVideoFramePublished':
        firstLocalVideoFramePublished?.call(data[0]);
        break;
      case 'AudioPublishStateChanged':
        audioPublishStateChanged?.call(
            data[0],
            StreamPublishStateConverter.fromValue(data[1]).e,
            StreamPublishStateConverter.fromValue(data[2]).e,
            data[3]);
        break;
      case 'VideoPublishStateChanged':
        videoPublishStateChanged?.call(
            data[0],
            StreamPublishStateConverter.fromValue(data[1]).e,
            StreamPublishStateConverter.fromValue(data[2]).e,
            data[3]);
        break;
      case 'AudioSubscribeStateChanged':
        audioSubscribeStateChanged?.call(
            data[0],
            data[1],
            StreamSubscribeStateConverter.fromValue(data[2]).e,
            StreamSubscribeStateConverter.fromValue(data[3]).e,
            data[4]);
        break;
      case 'VideoSubscribeStateChanged':
        videoSubscribeStateChanged?.call(
            data[0],
            data[1],
            StreamSubscribeStateConverter.fromValue(data[2]).e,
            StreamSubscribeStateConverter.fromValue(data[3]).e,
            data[4]);
        break;
      case 'RtmpStreamingEvent':
        rtmpStreamingEvent?.call(data[0], data[1]);
        break;
      case 'UserSuperResolutionEnabled':
        userSuperResolutionEnabled?.call(data[0], data[1],
            SuperResolutionStateReasonConverter.fromValue(data[2]).e);
        break;
      case 'UploadLogResult':
        uploadLogResult?.call(
            data[0], data[1], UploadErrorReasonConverter.fromValue(data[2]).e);
        break;
    }
  }
}

/// [RtcChannelEventHandler] 类。
class RtcChannelEventHandler {
  /// 报告 [RtcChannel] 对象发生的警告码。
  ///
  /// `WarningCallback` 包含如下参数：
  /// - [WarningCode] `warn`：警告码。详见 [WarningCode]。
  WarningCallback warning;

  /// 报告 [RtcChannel] 对象发生的错误码。
  ///
  /// `ErrorCallback` 包含如下参数：
  /// - [ErrorCode] `err`：错误码。详见 [ErrorCode]。
  ErrorCallback error;

  /// 加入频道回调。
  ///
  /// 表示客户端已经登入服务器，且分配了频道 ID 和用户 ID。频道 ID 的分配是
  /// 根据 [RtcChannel.joinChannel] 方法中指定的频道名称。如果调用 [RtcChannel.joinChannel] 时并未指定用户 ID，服务器就会分配一个。
  ///
  /// `UidWithElapsedCallback` 包含如下参数：
  /// - [int] `uid`：用户 ID。
  /// - [int] `elapsed`：从本地用户调用 `joinChannel` 到触发该回调的时间（毫秒）。
  UidWithElapsedAndChannelCallback joinChannelSuccess;

  /// 重新加入频道回调。
  ///
  /// 有时候由于网络原因，客户端可能会和服务器失去连接，SDK 会进行自动重连，自动重连成功后触发此回调方法。
  ///
  /// `UidWithElapsedCallback` 包含如下参数：
  /// - [int] `uid`：用户 ID。
  /// - [int] `elapsed`：从本地用户开始重连到触发该回调的时间（毫秒）。
  UidWithElapsedAndChannelCallback rejoinChannelSuccess;

  /// 离开频道回调。
  ///
  /// App 调用 [RtcChannel.leaveChannel] 方法时，SDK 提示 App 离开频道成功。
  ///
  /// 在该回调方法中，App 可以得到此次通话的总通话时长、SDK 收发数据的流量等信息。
  ///
  /// `RtcStatsCallback` 包含如下参数：
  /// - [RtcStats] `stats`：通话相关的统计信息。
  RtcStatsCallback leaveChannel;

  /// 直播场景下用户角色已切换回调。如从观众切换为主播，反之亦然。
  ///
  /// 该回调由本地用户在加入频道后调用 [RtcChannel.setClientRole] 改变用户角色触发的。
  ///
  /// `ClientRoleCallback` 包含如下参数：
  /// - [ClientRole] `oldRole`：切换前的角色。
  /// - [ClientRole] `newRole`：切换后的角色。
  ClientRoleCallback clientRoleChanged;

  /// 远端用户（通信场景）/主播（直播场景）加入当前频道回调。
  ///
  /// - 通信场景下，该回调提示有远端用户加入了频道，并返回新加入用户的 ID；如果加入之前，已经有其他用户在频道中了，新加入的用户也会收到这些已有用户加入频道的回调
  /// - 直播场景下，该回调提示有主播加入了频道，并返回该主播的用户 ID。如果在加入之前，已经有主播在频道中了，新加入的用户也会收到已有主播加入频道的回调。Agora 建议连麦主播不超过 17 人
  ///
  /// 该回调在如下情况下会被触发：
  ///
  /// - 远端用户/主播调用 [RtcChannel.joinChannel] 方法加入频道。
  /// - 远端用户加入频道后调用 [RtcChannel.setClientRole] 将用户角色改变为主播。
  /// - 远端用户/主播网络中断后重新加入频道。
  /// - 主播通过调用 [RtcChannel.addInjectStreamUrl] 方法成功输入在线媒体流。
  ///
  /// **Note**
  /// 直播场景下：
  /// - 主播间能相互收到新主播加入频道的回调，并能获得该主播的用户 ID。
  /// - 观众也能收到新主播加入频道的回调，并能获得该主播的用户 ID。
  /// - 当 Web 端加入直播频道时，只要 Web 端有推流，SDK 会默认该 Web 端为主播，并触发该回调。
  ///
  /// `UidWithElapsedCallback` 包含如下参数：
  /// - [int] `uid`：新加入频道的远端用户/主播 ID。
  /// - [int] `elapsed`：从本地用户调用 [RtcEngine.joinChannel] 或 [RtcEngine.setClientRole] 到触发该回调的延迟（毫秒）。
  UidWithElapsedCallback userJoined;

  /// 远端用户（通信场景）/主播（直播场景）离开当前频道回调。
  ///
  /// 提示有远端用户/主播离开了频道（或掉线）。用户离开频道有两个原因，即正常离开和超时掉线：
  /// - 正常离开的时候，远端用户/主播会收到类似“再见”的消息，接收此消息后，判断用户离开频道。
  /// - 超时掉线的依据是，在一定时间内（约 20 秒），用户没有收到对方的任何数据包，则判定为对方掉线。在网络较差的情况下，
  /// 有可能会误报。Agora 建议使用 Agora 实时消息 SDK 来做可靠的掉线检测。
  ///
  /// `UserOfflineCallback` 包含如下参数：
  /// - [int] `uid`：主播 ID。
  /// - [UserOfflineReason] `reason`：离线原因。
  UserOfflineCallback userOffline;

  /// 网络连接状态已改变回调。
  ///
  /// 该回调在网络连接状态发生改变的时候触发，并告知用户当前的网络连接状态，和引起网络状态改变的原因。
  ///
  /// `ConnectionStateCallback` 包含如下参数：
  /// - [ConnectionStateType] `state`：当前的网络连接状态。
  /// - [ConnectionChangedReason] `reason`：引起当前网络连接状态发生改变的原因。
  ConnectionStateCallback connectionStateChanged;

  /// 网络连接中断，且 SDK 无法在 10 秒内连接服务器回调。
  ///
  /// SDK 在调用 [RtcChannel.joinChannel] 后，无论是否加入成功，只要 10 秒和服务器无法连接就会触发该回调。
  ///
  /// 如果 SDK 在断开连接后，20 分钟内还是没能重新加入频道，SDK 会停止尝试重连。
  EmptyCallback connectionLost;

  /// Token 服务即将过期回调。
  ///
  /// 在调用 [RtcChannel.joinChannel] 时如果指定了 Token，
  /// 由于 Token 具有一定的时效，在通话过程中如果 Token 即将失效，SDK 会提前 30 秒触发该回调，提醒 App 更新 Token。
  /// 当收到该回调时，你需要重新在服务端生成新的 Token，然后调用 [RtcChannel.renewToken] 将新生成的 Token 传给 SDK。
  ///
  /// `TokenCallback` 包含如下参数：
  /// - [String] `token`：即将服务失效的 Token。
  TokenCallback tokenPrivilegeWillExpire;

  /// Token 过期回调。
  ///
  /// 在调用 [RtcChannel.joinChannel] 时如果指定了 Token，
  /// 由于 Token 具有一定的时效，在通话过程中 SDK 可能由于网络原因和服务器失去连接，重连时可能需要新的 Token。该回调通知 App 需要生成新的 Token，
  /// 并需调用 [RtcChannel.joinChannel] 重新加入频道。
  EmptyCallback requestToken;

  /// 监测到活跃用户回调。
  ///
  /// 该回调获取当前时间段内累积音量最大者。
  /// 如果该用户开启了 [RtcEngine.enableAudioVolumeIndication] 功能，
  /// 则当音量检测模块监测到频道内有新的活跃用户说话时，会通过本回调返回该用户的 uid。
  ///
  /// **Note**
  /// - 你需要开启 [RtcEngine.enableAudioVolumeIndication] 方法才能收到该回调。
  /// - `uid` 返回的是当前时间段内声音最大的用户 ID，而不是瞬时声音最大的用户 ID。
  ///
  /// `UidCallback` 包含如下参数：
  /// - [int] `uid`：当前时间段声音最大的用户的 `uid`。如果返回的 `uid` 为 0，则默认为本地用户。
  UidCallback activeSpeaker;

  /// 本地或远端视频大小或旋转信息发生改变回调。
  ///
  /// `VideoSizeCallback` 包含如下参数：
  /// - [int] `uid`：图像尺寸和旋转信息发生变化的用户 ID。如果返回的 uid 为 0，则表示本地用户。
  /// - [int] `width`：视频流的宽度（像素）。
  /// - [int] `height`：视频流的高度（像素）。
  /// - [int] `rotation`：旋转信息 [0,360)。
  VideoSizeCallback videoSizeChanged;

  /// 远端用户视频状态发生已变化回调。
  ///
  /// `RemoteVideoStateCallback` 包含如下参数：
  /// - [int] `uid`：视频状态发生改变的远端用户 ID。
  /// - [VideoRemoteState] `state`：远端视频流状态。
  /// - [VideoRemoteStateReason] `reason`：远端视频流状态改变的具体原因。
  /// - [int] `elapsed`：从本地用户调用 [RtcEngine.joinChannel] 方法到发生本事件经历的时间，单位为 ms。
  RemoteVideoStateCallback remoteVideoStateChanged;

  /// 远端音频状态发生改变回调。
  ///
  /// 远端用户（通信场景）或主播（直播场景）音频状态发生改变时，SDK 会触发该回调向本地用户报告当前的远端音频流状态。
  ///
  /// **Note**
  ///
  /// 当频道内的用户（通信场景）或主播（直播场景）的人数超过 17 时，该回调可能不准确。
  ///
  /// `RemoteAudioStateCallback` 包含如下参数：
  /// - [int] `uid`：发生音频状态改变的远端用户 ID。
  /// - [AudioRemoteState] `state`：远端音频流状态。
  /// - [AudioRemoteStateReason] `reason`：远端音频流状态改变的具体原因。
  /// - [int] `elapsed`：从本地用户调用 [RtcEngine.joinChannel] 方法到发生本事件经历的时间，单位为 ms。
  RemoteAudioStateCallback remoteAudioStateChanged;

  /// 本地发布流已回退为音频流回调。
  ///
  /// 如果你调用了设置本地推流回退选项 [RtcEngine.setLocalPublishFallbackOption] 接口并
  /// 将 `option` 设置为 [StreamFallbackOptions.AudioOnly] 时，当上行网络环境不理想、本地发布的媒体流回退为音频流时，
  /// 或当上行网络改善、媒体流恢复为音视频流时，会触发该回调。
  ///
  /// `FallbackCallback` 包含如下参数：
  /// - [bool] `isFallbackOrRecover`：本地推流已回退或恢复：
  ///  - `true`: 由于网络环境不理想，本地发布的媒体流已回退为音频流。
  ///  - `false`: 由于网络环境改善，发布的音频流已恢复为音视频流。
  FallbackCallback localPublishFallbackToAudioOnly;

  /// 远端订阅流已回退为音频流回调或因网络质量改善，恢复为音视频流。
  ///
  /// 如果你调用了设置远端订阅流回退选项 [RtcEngine.setRemoteSubscribeFallbackOption] 接口并
  /// 将 `option` 设置为 [StreamFallbackOptions.AudioOnly] 时，当下行网络环境不理想、仅接收远端音频流时，
  /// 或当下行网络改善、恢复订阅音视频流时，会触发该回调。
  ///
  /// **Note**
  ///
  /// 远端订阅流因弱网环境不能同时满足音视频而回退为小流时，你可以使用 [RtcEngineEventHandler.remoteVideoStats] 方法来监控远端视频大小流的切换。
  ///
  /// `FallbackWithUidCallback` 包含如下参数：
  /// - [int] `uid`：远端用户的 ID。
  /// - [bool] `isFallbackOrRecover`：远端订阅流已回退或恢复：
  ///  - `true`: 由于网络环境不理想，远端订阅流已回退为音频流。
  ///  - `false`: 由于网络环境改善，订阅的音频流已恢复为音视频流。
  FallbackWithUidCallback remoteSubscribeFallbackToAudioOnly;

  /// 当前通话统计回调。
  /// 该回调在通话中每两秒触发一次。
  ///
  /// `RtcStatsCallback` 包含如下参数：
  /// - [RtcStats] `stats`：通话相关的统计信息。
  RtcStatsCallback rtcStats;

  /// 通话中每个用户的网络上下行 last mile 质量报告回调。
  ///
  /// 该回调描述每个用户在通话中的 last mile 网络状态，其中 last mile 是指设备到 Agora 边缘服务器的网络状态。
  /// 该回调每 2 秒触发一次。如果远端有多个用户/主播，该回调每 2 秒会被触发多次。
  ///
  /// `NetworkQualityWithUidCallback` 包含如下参数：
  /// - [int] `uid`：用户 ID。表示该回调报告的是持有该 ID 的用户的网络质量。当 `uid` 为 0 时，返回的是本地用户的网络质量。
  /// - [NetworkQuality] `txQuality`：该用户的上行网络质量，基于上行视频的发送码率、上行丢包率、平均往返时延和网络抖动计算。
  /// 该值代表当前的上行网络质量，帮助判断是否可以支持当前设置的视频编码属性。假设上行码率是 1000 Kbps，
  /// 那么支持 640 &times; 480 的分辨率、30 fps 的帧率没有问题，但是支持 1280 x 720 的分辨率就会有困难。
  /// - [NetworkQuality] `rxQuality`：该用户的下行网络质量，基于下行网络的丢包率、平均往返延时和网络抖动计算。
  NetworkQualityWithUidCallback networkQuality;

  /// 通话中远端视频流的统计信息回调。
  ///
  /// 该回调描述远端用户在通话中端到端的视频流状态，针对每个远端用户/主播每 2 秒触发一次。
  /// 如果远端同时存在多个用户/主播，该回调每 2 秒会被触发多次。
  ///
  /// `RemoteVideoStatsCallback` 包含如下参数：
  /// - [RemoteVideoStats] `stats`：远端视频统计数据。
  RemoteVideoStatsCallback remoteVideoStats;

  /// 通话中远端音频流的统计信息回调。
  ///
  /// 该回调描述远端用户在通话中端到端的音频流统计信息，针对每个远端用户/主播每 2 秒触发一次。
  /// 如果远端同时存在多个用户/主播，该回调每 2 秒会被触发多次。
  ///
  /// 当网络发生丢包时，因 FEC（Forward Error Correction，向前纠错码）或重传恢复，最终的音频丢帧率不高，则可以认为整个质量较好。
  ///
  /// `RemoteAudioStatsCallback` 包含如下参数：
  /// - [RemoteAudioStats] `stats`：接收到的远端音频统计数据。
  RemoteAudioStatsCallback remoteAudioStats;

  /// RTMP 推流状态发生改变回调。该回调返回本地用户调用 [RtcChannel.addPublishStreamUrl]
  /// 或 [RtcChannel.removePublishStreamUrl] 方法的结果。
  ///
  /// RTMP 推流状态发生改变时，SDK 会触发该回调，并在回调中明确状态发生改变的 URL 地址及当前推流状态；当推流状态为 [RtmpStreamingState.Failure] 时，你可以在 `errCode` 参数中查看返回的错误信息。
  /// 该回调方便推流用户了解当前的推流状态；推流出错时，你可以通过返回的错误码了解出错的原因，方便排查问题。
  ///
  /// `RtmpStreamingStateCallback` 包含如下参数：
  /// - [String] `url`：推流状态发生改变的 URL 地址。
  /// - [RtmpStreamingState] `state`：当前的推流状态。
  /// - [RtmpStreamingErrorCode] `errCode`：详细的推流错误信息。
  RtmpStreamingStateCallback rtmpStreamingStateChanged;

  /// 旁路推流设置被更新回调。
  ///
  /// [RtcChannel.setLiveTranscoding] 方法中的直播转码参数 `LiveTranscoding` 更新时，该回调会被触发， 并向主播报告更新信息。
  ///
  /// **Note**
  ///
  /// 首次调用 [RtcChannel.setLiveTranscoding] 方法设置转码参数时，不会触发该回调。
  EmptyCallback transcodingUpdated;

  /// 输入在线媒体流状态回调。该回调表明向直播输入的外部视频流的状态。
  ///
  /// `StreamInjectedStatusCallback` 包含如下参数：
  /// - [String] `url`：推流状态发生改变的 URL 地址。
  /// - [int] `uid`：用户 ID。
  /// - [InjectStreamStatus] `status`：输入的外部视频源状态。
  StreamInjectedStatusCallback streamInjectedStatus;

  /// 接收到对方数据流消息的回调。
  ///
  /// 该回调表示本地用户收到了远端用户调用 [RtcChannel.sendStreamMessage] 方法发送的流消息。
  ///
  /// `StreamMessageCallback` 包含如下参数：
  /// - [int] `uid`：用户 ID。
  /// - [int] `streamId`：数据流。
  /// - [String] `data`：接收到的数据。
  StreamMessageCallback streamMessage;

  /// 接收对方数据流消息发生错误的回调。
  ///
  /// 该回调表示本地用户未收到远端用户调用 [RtcChannel.sendStreamMessage] 方法发送的流消息。
  ///
  /// `StreamMessageErrorCallback` 包含如下参数：
  /// - [int] `uid`：用户 ID。
  /// - [int] `streamId`：数据流。
  /// - [ErrorCode] `error`：接收到的数据。
  /// - [int] `missed`：丢失的消息数量。
  /// - [int] `cached`：数据流中断时，后面缓存的消息数量。
  StreamMessageErrorCallback streamMessageError;

  /// 跨频道媒体流转发状态发生改变回调。
  ///
  /// 当跨频道媒体流转发状态发生改变时，SDK 会触发该回调，并报告当前的转发状态以及相关的错误信息。
  ///
  /// `MediaRelayStateCallback` 包含如下参数：
  /// - [ChannelMediaRelayState] `state`：跨频道媒体流转发状态。
  /// - [ChannelMediaRelayError] `code`：跨频道媒体流转发出错的错误码。
  MediaRelayStateCallback channelMediaRelayStateChanged;

  /// 跨频道媒体流转发事件回调。该回调报告跨频道媒体流转发过程中发生的事件。
  ///
  /// `MediaRelayEventCallback` 包含如下参数：
  /// - [ChannelMediaRelayEvent] `code`：跨频道媒体流转发事件码。
  MediaRelayEventCallback channelMediaRelayEvent;

  /// 接收端已接收 Metadata。
  ///
  /// `MetadataCallback` 包含如下参数：
  /// - [String] `buffer`：接收到的 Metadata 数据 Buffer。
  /// - [int] `uid`：发送该 Metadata 的远端用户的 ID。
  /// - [int] `timeStampMs`：接收到的 Metadata 的时间戳，单位为毫秒 。
  MetadataCallback metadataReceived;

  /// 音频发布状态改变回调。
  ///
  ///
  ///
  /// `StreamPublishStateCallback` 包含如下参数：
  /// - [String] `channel` 频道名。
  /// - [StreamPublishState] `oldState` 之前的发布状态。
  /// - [StreamPublishState] `newState` 当前的发布状态。
  /// - [int] `elapseSinceLastState` 两次状态变化时间间隔（毫秒）。
  StreamPublishStateCallback audioPublishStateChanged;

  /// 视频发布状态发生改变回调。
  ///
  ///
  ///
  /// `StreamPublishStateCallback` 包含如下参数：
  /// - [String] `channel` 频道名。
  /// - [StreamPublishState] `oldState` 之前的发布状态。
  /// - [StreamPublishState] `newState` 当前的发布状态。
  /// - [int] `elapseSinceLastState` 两次状态变化时间间隔（毫秒）。
  StreamPublishStateCallback videoPublishStateChanged;

  /// 音频订阅状态发生改变回调。
  ///
  ///
  ///
  /// `StreamSubscribeStateCallback` 包含如下参数：
  /// - [String] `channel` 频道名。
  /// - [StreamSubscribeState] `oldState` 之前的订阅状态。
  /// - [StreamSubscribeState] `newState` 当前的订阅状态。
  /// - [int] `elapseSinceLastState` 两次状态变化时间间隔（毫秒）。
  StreamSubscribeStateCallback audioSubscribeStateChanged;

  /// 视频订阅状态发生改变回调。
  ///
  ///
  ///
  /// `StreamSubscribeStateCallback` 包含如下参数：
  /// - [String] `channel` 频道名。
  /// - [StreamSubscribeState] `oldState` 之前的订阅状态。
  /// - [StreamSubscribeState] `newState` 当前的订阅状态。
  /// - [int] `elapseSinceLastState` 两次状态变化时间间隔（毫秒）。
  StreamSubscribeStateCallback videoSubscribeStateChanged;

  /// RTMP 推流事件回调。
  ///
  ///
  ///
  /// `RtmpStreamingEventCallback` 包含如下参数：
  /// - [String] `url` RTMP 推流 URL。
  /// - [RtmpStreamingEvent] `eventCode` RTMP 推流事件码。
  RtmpStreamingEventCallback rtmpStreamingEvent;

  ///  @nodoc
  UserSuperResolutionEnabledCallback userSuperResolutionEnabled;

  /// Constructs a [RtcChannelEventHandler]
     RtcChannelEventHandler(
      {this.warning,
      this.error,
      this.joinChannelSuccess,
      this.rejoinChannelSuccess,
      this.leaveChannel,
      this.clientRoleChanged,
      this.userJoined,
      this.userOffline,
      this.connectionStateChanged,
      this.connectionLost,
      this.tokenPrivilegeWillExpire,
      this.requestToken,
      this.activeSpeaker,
      this.videoSizeChanged,
      this.remoteVideoStateChanged,
      this.remoteAudioStateChanged,
      this.localPublishFallbackToAudioOnly,
      this.remoteSubscribeFallbackToAudioOnly,
      this.rtcStats,
      this.networkQuality,
      this.remoteVideoStats,
      this.remoteAudioStats,
      this.rtmpStreamingStateChanged,
      this.transcodingUpdated,
      this.streamInjectedStatus,
      this.streamMessage,
      this.streamMessageError,
      this.channelMediaRelayStateChanged,
      this.channelMediaRelayEvent,
      this.metadataReceived,
      this.audioPublishStateChanged,
      this.videoPublishStateChanged,
      this.audioSubscribeStateChanged,
      this.videoSubscribeStateChanged,
      this.rtmpStreamingEvent,
      this.userSuperResolutionEnabled});

  // ignore: public_member_api_docs
  void process(String methodName, List<dynamic> data) {
    switch (methodName) {
      case 'Warning':
        warning?.call(WarningCodeConverter.fromValue(data[0]).e);
        break;
      case 'Error':
        error?.call(ErrorCodeConverter.fromValue(data[0]).e);
        break;
      case 'JoinChannelSuccess':
        joinChannelSuccess?.call(data[0], data[1], data[2]);
        break;
      case 'RejoinChannelSuccess':
        rejoinChannelSuccess?.call(data[0], data[1], data[2]);
        break;
      case 'LeaveChannel':
        leaveChannel
            ?.call(RtcStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'ClientRoleChanged':
        clientRoleChanged?.call(ClientRoleConverter.fromValue(data[0]).e,
            ClientRoleConverter.fromValue(data[1]).e);
        break;
      case 'UserJoined':
        userJoined?.call(data[0], data[1]);
        break;
      case 'UserOffline':
        userOffline?.call(
            data[0], UserOfflineReasonConverter.fromValue(data[1]).e);
        break;
      case 'ConnectionStateChanged':
        connectionStateChanged?.call(
            ConnectionStateTypeConverter.fromValue(data[0]).e,
            ConnectionChangedReasonConverter.fromValue(data[1]).e);
        break;
      case 'ConnectionLost':
        connectionLost?.call();
        break;
      case 'TokenPrivilegeWillExpire':
        tokenPrivilegeWillExpire?.call(data[0]);
        break;
      case 'RequestToken':
        requestToken?.call();
        break;
      case 'ActiveSpeaker':
        activeSpeaker?.call(data[0]);
        break;
      case 'VideoSizeChanged':
        videoSizeChanged?.call(data[0], data[1], data[2], data[3]);
        break;
      case 'RemoteVideoStateChanged':
        remoteVideoStateChanged?.call(
            data[0],
            VideoRemoteStateConverter.fromValue(data[1]).e,
            VideoRemoteStateReasonConverter.fromValue(data[2]).e,
            data[3]);
        break;
      case 'RemoteAudioStateChanged':
        remoteAudioStateChanged?.call(
            data[0],
            AudioRemoteStateConverter.fromValue(data[1]).e,
            AudioRemoteStateReasonConverter.fromValue(data[2]).e,
            data[3]);
        break;
      case 'LocalPublishFallbackToAudioOnly':
        localPublishFallbackToAudioOnly?.call(data[0]);
        break;
      case 'RemoteSubscribeFallbackToAudioOnly':
        remoteSubscribeFallbackToAudioOnly?.call(data[0], data[1]);
        break;
      case 'RtcStats':
        rtcStats?.call(RtcStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'NetworkQuality':
        networkQuality?.call(
            data[0],
            NetworkQualityConverter.fromValue(data[1]).e,
            NetworkQualityConverter.fromValue(data[2]).e);
        break;
      case 'RemoteVideoStats':
        remoteVideoStats?.call(
            RemoteVideoStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'RemoteAudioStats':
        remoteAudioStats?.call(
            RemoteAudioStats.fromJson(Map<String, dynamic>.from(data[0])));
        break;
      case 'RtmpStreamingStateChanged':
        rtmpStreamingStateChanged?.call(
          data[0],
          RtmpStreamingStateConverter.fromValue(data[1]).e,
          RtmpStreamingErrorCodeConverter.fromValue(data[2]).e,
        );
        break;
      case 'TranscodingUpdated':
        transcodingUpdated?.call();
        break;
      case 'StreamInjectedStatus':
        streamInjectedStatus?.call(
            data[0], data[1], InjectStreamStatusConverter.fromValue(data[2]).e);
        break;
      case 'StreamMessage':
        streamMessage?.call(data[0], data[1], data[2]);
        break;
      case 'StreamMessageError':
        streamMessageError?.call(data[0], data[1],
            ErrorCodeConverter.fromValue(data[2]).e, data[3], data[4]);
        break;
      case 'ChannelMediaRelayStateChanged':
        channelMediaRelayStateChanged?.call(
          ChannelMediaRelayStateConverter.fromValue(data[0]).e,
          ChannelMediaRelayErrorConverter.fromValue(data[1]).e,
        );
        break;
      case 'ChannelMediaRelayEvent':
        channelMediaRelayEvent
            ?.call(ChannelMediaRelayEventConverter.fromValue(data[0]).e);
        break;
      case 'MetadataReceived':
        metadataReceived?.call(data[0], data[1], data[2]);
        break;
        case 'AudioPublishStateChanged':
        audioPublishStateChanged?.call(
            data[0],
            StreamPublishStateConverter.fromValue(data[1]).e,
            StreamPublishStateConverter.fromValue(data[2]).e,
            data[3]);
        break;
      case 'VideoPublishStateChanged':
        videoPublishStateChanged?.call(
            data[0],
            StreamPublishStateConverter.fromValue(data[1]).e,
            StreamPublishStateConverter.fromValue(data[2]).e,
            data[3]);
        break;
      case 'AudioSubscribeStateChanged':
        audioSubscribeStateChanged?.call(
            data[0],
            data[1],
            StreamSubscribeStateConverter.fromValue(data[2]).e,
            StreamSubscribeStateConverter.fromValue(data[3]).e,
            data[4]);
        break;
      case 'VideoSubscribeStateChanged':
        videoSubscribeStateChanged?.call(
            data[0],
            data[1],
            StreamSubscribeStateConverter.fromValue(data[2]).e,
            StreamSubscribeStateConverter.fromValue(data[3]).e,
            data[4]);
        break;
      case 'RtmpStreamingEvent':
        rtmpStreamingEvent?.call(data[0], data[1]);
        break;
      case 'UserSuperResolutionEnabled':
        userSuperResolutionEnabled?.call(data[0], data[1],
            SuperResolutionStateReasonConverter.fromValue(data[2]).e);
        break;
    }
  }
}
