import 'dart:ui' show Color;

import 'package:json_annotation/json_annotation.dart';

import 'enums.dart';

part 'classes.g.dart';

/// 标识用户信息的 `UserInfo` 对象。
@JsonSerializable(explicitToJson: true)
class UserInfo {
  /// 用户 ID。
  int uid;

  /// 用户 Account。
  String userAccount;

  /// Constructs a [UserInfo]
  UserInfo();

  // @nodoc ignore: public_member_api_docs
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  // @nodoc ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

/// 视频编码像素。
@JsonSerializable(explicitToJson: true)
class VideoDimensions {
  /// 视频帧在横轴上的像素。
  int width;

  /// 视频帧在纵轴上的像素。
  int height;

  /// Constructs a [VideoDimensions]
  VideoDimensions(this.width, this.height);

  // @nodoc ignore: public_member_api_docs
  factory VideoDimensions.fromJson(Map<String, dynamic> json) =>
      _$VideoDimensionsFromJson(json);

  // @nodoc ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$VideoDimensionsToJson(this);
}

/// 视频编码属性的定义。
@JsonSerializable(explicitToJson: true)
class VideoEncoderConfiguration {

  /// 视频编码的分辨率 (px)，用于衡量编码质量，以长 × 宽表示，默认值为 640 × 360。
  /// 用户可以自行设置分辨率，也可以在如下列表中直接选择想要的分辨率：
  /// - 120x120
  /// - 160x120
  /// - 180x180
  /// - 240x180
  /// - 320x180
  /// - 240x240
  /// - 320x240
  /// - 424x240
  /// - 360x360
  /// - 480x360
  /// - 640x360
  /// - 480x480
  /// - 640x480
  /// - 840x480
  /// - 960x720
  /// - 1280x720
  ///
  /// **Note**
  /// - 该值不代表最终视频输出的方向。请查阅 [VideoOutputOrientationMode] 了解设置视频方向。
  /// - 视频能否达到 720P 的分辨率取决于设备的性能，在性能配备较低的设备上有可能无法实现。如果采用 720P 分辨率而设备性能跟不上，则有可能出现帧率过低的情况。
  @JsonKey(includeIfNull: false)
  VideoDimensions dimensions;

  /// 视频编码的帧率（fps），默认值为 15。用户可以自行设置帧率，也可以在 [VideoFrameRate] 直接选择想要的帧率。建议不要超过 30 帧。
  @JsonKey(includeIfNull: false)
  VideoFrameRate frameRate;

  /// 最低视频编码帧率（fps）。默认值为 [VideoFrameRate.Min]，表示使用系统默认的最低编码帧率。
  @JsonKey(includeIfNull: false)
  VideoFrameRate minFrameRate;

  /// 视频编码的码率。单位为 Kbps。你可以根据场景需要，参考下面的视频基准码率参考表，手动设置你想要的码率。
  /// 若设置的视频码率超出合理范围，SDK 会自动按照合理区间处理码率。
  ///
  /// 你也可以直接选择如下任意一种模式进行设置：
  /// - `Standard`：（推荐）标准码率模式。该模式下，视频在通信和直播场景下的码率有所不同：
  ///    - 通信场景下，码率与基准码率一致。
  ///    - 直播场景下，码率对照基准码率翻倍。
  /// - `Compatible`：适配码率模式。该模式下，视频在通信和直播场景下的码率均与基准码率一致。直播下如果选择该模式，视频帧率可能会低于设置的值。
  ///
  /// Agora 在通信和直播场景下采用不同的编码方式，以提升不同场景下的用户体验。通信场景保证流畅，而直播场景则更注重画面质量，因此直播场景对码率的需求大于通信场景。所以 Agora 推荐将该参数设置为 `0` ([BitRate.Standard])。
  ///
  /// **视频码率参考表**
  ///
  /// |分辨率                   | 帧率 (fps)       | 基准码率 (通信场景，Kbps)                | 直播码率 (直播场景，Kbps)               |
  /// |------------------------|------------------|----------------------------------------|----------------------------------------|
  /// | 160 * 120              | 15               | 65                                     | 130                                    |
  /// | 120 * 120              | 15               | 50                                     | 100                                    |
  /// | 320 * 180              | 15               | 140                                    | 280                                    |
  /// | 180 * 180              | 15               | 100                                    | 200                                    |
  /// | 240 * 180              | 15               | 120                                    | 240                                    |
  /// | 320 * 240              | 15               | 200                                    | 400                                    |
  /// | 240 * 240              | 15               | 140                                    | 280                                    |
  /// | 424 * 240              | 15               | 220                                    | 440                                    |
  /// | 640 * 360              | 15               | 400                                    | 800                                    |
  /// | 360 * 360              | 15               | 260                                    | 520                                    |
  /// | 640 * 360              | 30               | 600                                    | 1200                                   |
  /// | 360 * 360              | 30               | 400                                    | 800                                    |
  /// | 480 * 360              | 15               | 320                                    | 640                                    |
  /// | 480 * 360              | 30               | 490                                    | 980                                    |
  /// | 640 * 480              | 15               | 500                                    | 1000                                   |
  /// | 480 * 480              | 15               | 400                                    | 800                                    |
  /// | 640 * 480              | 30               | 750                                    | 1500                                   |
  /// | 480 * 480              | 30               | 600                                    | 1200                                   |
  /// | 848 * 480              | 15               | 610                                    | 1220                                   |
  /// | 848 * 480              | 30               | 930                                    | 1860                                   |
  /// | 640 * 480              | 10               | 400                                    | 800                                    |
  /// | 1280 * 720             | 15               | 1130                                   | 2260                                   |
  /// | 1280 * 720             | 30               | 1710                                   | 3420                                   |
  /// | 960 * 720              | 15               | 910                                    | 1820                                   |
  /// | 960 * 720              | 30               | 1380                                   | 2760                                   |
  ///
  /// **Note**
  /// 该表中的基准码率适用于通信场景。直播场景下通常需要较大码率来提升视频质量。
  /// Agora 推荐通过设置 `0`来实现。你也可以直接将码率值设为基准码率值 x 2。
  @JsonKey(includeIfNull: false)
  int bitrate;

  /// 最低视频编码码率。单位为 Kbps。
  /// Agora SDK 会根据网络条件进行码率自适应。 该参数强制视频编码器输出高质量图片。如果将参数设为高于默认值，
  /// 在网络状况不佳情况下可能会导致网络丢包，并影响视频播放的流畅度。因此如非对画质有特殊需求，Agora 建议不要修改该参数的值。
  @JsonKey(includeIfNull: false)
  int minBitrate;

  /// 视频编码的方向模式。
  /// 详见 [VideoOutputOrientationMode]。
  @JsonKey(includeIfNull: false)
  VideoOutputOrientationMode orientationMode;

  /// 带宽受限时，视频编码降级偏好。
  /// 详见 [DegradationPreference]。
  @JsonKey(includeIfNull: false)
  DegradationPreference degradationPrefer;

  /// 本地发送视频的镜像模式，只影响远端用户看到的视频画面。
  /// 详见 [VideoMirrorMode]。
  @JsonKey(includeIfNull: false)
  VideoMirrorMode mirrorMode;

  /// Constructs a [VideoEncoderConfiguration]
  VideoEncoderConfiguration({
    this.dimensions,
    this.frameRate,
    this.minFrameRate,
    this.bitrate,
    this.minBitrate,
    this.orientationMode,
    this.degradationPrefer,
    this.mirrorMode});

  // @nodoc ignore: public_member_api_docs
  factory VideoEncoderConfiguration.fromJson(Map<String, dynamic> json) =>
      _$VideoEncoderConfigurationFromJson(json);

  // @nodoc ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$VideoEncoderConfigurationToJson(this);
}

/// 美颜效果选项。
@JsonSerializable(explicitToJson: true)
class BeautyOptions {
  /// 亮度明暗对比度。与 [lighteningLevel] 参数搭配使用。// 检查一下 RN 为什么没有？
  @JsonKey(includeIfNull: false)
  LighteningContrastLevel lighteningContrastLevel;

  /// 亮度，取值范围为 [0.0,1.0]，其中 0.0 表示原始亮度，默认值为 0.7。可用来实现美白等视觉效果。
  @JsonKey(includeIfNull: false)
  double lighteningLevel;

  /// 平滑度，取值范围为 [0.0,1.0]，其中 0.0 表示原始平滑等级，默认值为 0.5。可用来实现祛痘、磨皮等视觉效果。
  @JsonKey(includeIfNull: false)
  double smoothnessLevel;

  /// 红色度，取值范围为 [0.0,1.0]，其中 0.0 表示原始红色度，默认值为 0.1。可用来实现红润肤色等视觉效果。
  @JsonKey(includeIfNull: false)
  double rednessLevel;

  /// Constructs a [BeautyOptions]
  BeautyOptions(
    {this.lighteningContrastLevel,
    this.lighteningLevel,
    this.smoothnessLevel,
    this.rednessLevel});

  // @nodoc ignore: public_member_api_docs
  factory BeautyOptions.fromJson(Map<String, dynamic> json) =>
      _$BeautyOptionsFromJson(json);

  // @nodoc ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$BeautyOptionsToJson(this);
}

/// Agora 图像属性。用于设置直播视频的水印和背景图片的属性。
@JsonSerializable(explicitToJson: true)
class AgoraImage {
  /// 直播视频上图片的 HTTP/HTTPS 地址，字符长度不得超过 1024 字节。
  String url;

  /// 图片左上角在视频帧上的横轴坐标。
  int x;

  /// 图片左上角在视频帧上的纵轴坐标。
  int y;

  /// 图片在视频帧上的宽度。
  int width;

  /// 图片在视频帧上的高度。
  int height;

  /// Constructs a [AgoraImage]
  AgoraImage(this.url, this.x, this.y, this.width, this.height);

  // @nodoc ignore: public_member_api_docs
  factory AgoraImage.fromJson(Map<String, dynamic> json) =>
      _$AgoraImageFromJson(json);

  // @nodoc ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$AgoraImageToJson(this);
}

/// TranscodingUser 类用于管理参与旁路直播的音视频转码合图的用户。最多支持 17 人同时参与转码合图。
@JsonSerializable(explicitToJson: true)
class TranscodingUser {
  /// 旁路主播的用户 ID。
  int uid;

  /// 屏幕里该区域相对左上角的横坐标绝对值 (pixel)。取值范围为转码配置参数定义中设置的 [0,width]。
  int x;

  /// 屏幕里该区域相对左上角的纵坐标绝对值 (pixel)。取值范围为转码配置参数定义中设置的 [0,height]。
  int y;

  /// 视频帧宽度 (pixel)。 默认值为 360。
  @JsonKey(includeIfNull: false)
  int width;

  /// 视频帧高度 (pixel)。默认值为 640。
  @JsonKey(includeIfNull: false)
  int height;

  /// 视频帧图层编号。取值范围为 [0,100] 中的整型。支持将 `zOrder` 设置为 `0`。
  /// - 0: （默认）表示该区域图像位于最下层。
  /// - 100: 表示该区域图像位于最上层。
  ///
  /// **Note**
  /// 如果取值小于 0 或大于 100，会返回错误 [ErrorCode.InvalidArgument]。
  @JsonKey(includeIfNull: false)
  int zOrder;

  /// 直播视频上用户视频的透明度。取值范围为 [0.0,100.0]:
  /// - 0.0: 该区域图像完全透明。
  /// - 1.0:（默认）该区域图像完全不透明。
  @JsonKey(includeIfNull: false)
  double alpha;

  /// 直播音频所在声道。取值范围为 [0,5]，默认值为 0。
  /// 详见 [AudioChannel]。
  ///
  /// **Note**
  /// 选项不为 0 时，需要特殊的播放器支持。
  @JsonKey(includeIfNull: false)
  AudioChannel audioChannel;

  /// Constructs a [TranscodingUser]
  TranscodingUser(
        this.uid,
        this.x,
        this.y, {
        this.width,
        this.height,
        this.zOrder,
        this.alpha,
        this.audioChannel,
      });

  // @nodoc ignore: public_member_api_docs
  factory TranscodingUser.fromJson(Map<String, dynamic> json) =>
      _$TranscodingUserFromJson(json);

  // @nodoc ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$TranscodingUserToJson(this);
}

/// 管理 CDN 直播推流转码的接口。
@JsonSerializable(explicitToJson: true)
class LiveTranscoding {
  /// 推流视频的总宽度，默认值 360，单位为像素。
  /// - 如果推视频流，`width` 值不得低于 64，否则 Agora 会调整为 64。
  /// - 如果推音频流，请将 `width` 和 `height` 设为 0。
  @JsonKey(includeIfNull: false)
  int width;

  /// 推流视频的总高度，默认值 640，单位为像素。
  /// - 如果推视频流，`height` 值不得低于 64，否则 Agora 会调整为 64。
  /// - 如果推音频流，请将 `width` 和 `height` 设为 0。
  @JsonKey(includeIfNull: false)
  int height;

  /// 用于旁路推流的输出视频的码率。 单位为 Kbps。 400 Kbps 为默认值。用户可以根据 [VideoEncoderConfiguration.bitrate]（码率参考表）参考表中的码率值进行设置；
  @JsonKey(includeIfNull: false)
  int videoBitrate;

  /// 用于旁路推流的输出视频的帧率。取值范围是 (0,30]，单位为 fps。默认值为 15 fps。
  @JsonKey(includeIfNull: false)
  VideoFrameRate videoFramerate;

  /// **Deprecated** 已废弃。Agora 不推荐使用。
  /// - `true`： 低延时，不保证画质。
  /// - `false`：（默认值）高延时，保证画质。
  @deprecated
  @JsonKey(includeIfNull: false)
  bool lowLatency;

  /// 用于旁路直播的输出视频的 GOP。单位为帧。默认值为 30 fps。
  @JsonKey(includeIfNull: false)
  int videoGop;

  /// 用于旁路直播的输出视频上的水印图片。添加后所有旁路直播的观众都可以看到水印。必须为 PNG 格式。
  /// 详见 [AgoraImage]。
  @JsonKey(includeIfNull: false)
  AgoraImage watermark;

  /// 用于旁路直播的输出视频上的背景图片。添加后所有旁路直播的观众都可以看到背景图片。
  /// 详见 [AgoraImage]。
  @JsonKey(includeIfNull: false)
  AgoraImage backgroundImage;

  /// 自定义音频采样率。详见 [AudioSampleRateType]。
  @JsonKey(includeIfNull: false)
  AudioSampleRateType audioSampleRate;

  /// 用于旁路推流的输出音频的码率。单位为 Kbps，默认值为 48，最大值为 128。
  @JsonKey(includeIfNull: false)
  int audioBitrate;

  /// 用于旁路推流的输出音频的声道数，取值范围为 [1,5] 中的整型，默认值为 1。建议取 1 或 2，如果取值为 3、4或5，需要特殊播放器支持：
  /// - 1：单声道
  /// - 2：双声道
  /// - 3：三声道
  /// - 4：四声道
  /// - 5：五声道
  @JsonKey(includeIfNull: false)
  AudioChannel audioChannels;

  /// 用于旁路推流的输出音频的编码规格。详见 [AudioCodecProfileType]。 可以设置为 `LCAAC` 或 `HEAAC`。默认为 `LCAAC`。
  @JsonKey(includeIfNull: false)
  AudioCodecProfileType audioCodecProfile;

  /// 用于旁路直播的输出视频的编码规格。详见 [VideoCodecProfileType]。
  /// 可以设置为 `BASELINE`、`MAIN` 或 `HIGH` （默认值）级别。如果设置其他值，Agora 服务器会统一设为默认值 `HIGH`。
  @JsonKey(includeIfNull: false)
  VideoCodecProfileType videoCodecProfile;

  /// 背景色，格式为 RGB 定义下的 Hex 值，不要带 # 号，如 0xFFB6C1 表示浅粉色。默认0x000000，黑色。// RN 优化
  /// 详见 [Color]。
  @JsonKey(
      includeIfNull: false, fromJson: _$ColorFromJson, toJson: _$ColorToJson)
  Color backgroundColor;

  /// 预留参数。 用户自定义的发送到旁路推流客户端的信息，用于填充 H264/H265 视频中 SEI 帧内容。长度限制：4096字节。
  @JsonKey(includeIfNull: false)
  String userConfigExtraInfo;

  /// 用于管理参与直播推流的视频转码合图的用户。最多支持 17 人同时参与转码合图。
  List<TranscodingUser> transcodingUsers;

  /// Constructs a [LiveTranscoding]
  LiveTranscoding(
    this.transcodingUsers, {
    this.width,
    this.height,
    this.videoBitrate,
    this.videoFramerate,
    this.lowLatency,
    this.videoGop,
    this.watermark,
    this.backgroundImage,
    this.audioSampleRate,
    this.audioBitrate,
    this.audioChannels,
    this.audioCodecProfile,
    this.videoCodecProfile,
    this.backgroundColor,
    this.userConfigExtraInfo,
  });

  // @nodoc ignore: public_member_api_docs
  factory LiveTranscoding.fromJson(Map<String, dynamic> json) =>
      _$LiveTranscodingFromJson(json);

  // @nodoc ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$LiveTranscodingToJson(this);

  static Color _$ColorFromJson(Map<String, dynamic> json) {
    return Color.fromRGBO(
        json['red'] as int, json['green'] as int, json['blue'] as int, 1.0);
  }

  static Map<String, dynamic> _$ColorToJson(Color instance) =>
      <String, dynamic>{
        'red': instance.red,
        'green': instance.green,
        'blue': instance.blue,
      };
}

/// `ChannelMediaInfo` 类。
@JsonSerializable(explicitToJson: true)
class ChannelMediaInfo {
  /// 频道名。
  @JsonKey(includeIfNull: false)
  String channelName;

  /// 能加入频道的 Token。
  @JsonKey(includeIfNull: false)
  String token;

  /// 用户 ID。
  int uid;

  /// Constructs a [ChannelMediaInfo]
  ChannelMediaInfo(this.uid, {this.channelName, this.token});

  // @nodoc ignore: public_member_api_docs
  factory ChannelMediaInfo.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaInfoFromJson(json);

  // @nodoc ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$ChannelMediaInfoToJson(this);
}

/// 配置跨频道媒体流转发的 `ChannelMediaRelayConfiguration` 类。
@JsonSerializable(explicitToJson: true)
class ChannelMediaRelayConfiguration {
  /// 源频道信息： [ChannelMediaInfo]，包含如下成员：
  /// - `channelName`：源频道名。默认值为 NULL，表示 SDK 填充当前的频道名。
  /// - `uid`：标识源频道中想要转发流的主播 ID。默认值为 0，表示 SDK 随机分配一个 UID。请确保设为 0。
  /// - `token`：能加入源频道的 Token。由你在 `srcInfo` 中设置的 `channelName` 和 `uid` 生成。
  ///   - 如未启用 App Certificate，可直接将该参数设为默认值 NULL，表示 SDK 填充 App ID。
  ///   - 如已启用 App Certificate，则务必填入使用 `channelName` 和 `uid` 生成的 Token，且其中的 `uid` 必须为 0。
  ChannelMediaInfo srcInfo;

  /// 目标频道信息： [ChannelMediaInfo]，包含如下成员：
  ///- `channelName`：目标频道的频道名。
  ///- `uid`：标识转发流到目标频道的主播 ID。取值范围为 0 到（2<sup>32</sup>-1），请确保与目标频道中的所有 UID 不同。默认值为 0，表示 SDK 随机分配一个 UID。
  ///  - `token`：能加入目标频道的 token。由你在 `destInfo` 中设置的 `channelName` 和 `uid` 生成。
  ///    - 如未启用 App Certificate，可直接将该参数设为默认值 NULL，表示 SDK 填充 App ID。
  ///    - 如已启用 App Certificate，则务必填入使用 `channelName` 和 `uid` 生成的 token，且其中的 `uid` 必须为 0。
  List<ChannelMediaInfo> destInfos;

  /// Constructs a [ChannelMediaRelayConfiguration]
  ChannelMediaRelayConfiguration(this.srcInfo, this.destInfos);

  // @nodoc ignore: public_member_api_docs
  factory ChannelMediaRelayConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaRelayConfigurationFromJson(json);

  // @nodoc ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$ChannelMediaRelayConfigurationToJson(this);
}

/// Last-mile 网络探测配置。
@JsonSerializable(explicitToJson: true)
class LastmileProbeConfig {
  /// 是否探测上行网络。有些用户，如直播频道中的普通观众，不需要进行网络探测。
  bool probeUplink;

  /// 是否探测下行网络。
  bool probeDownlink;

  /// 用户期望的最高发送码率，单位为 bps，范围为 [100000,5000000]。
  /// Agora 推荐参考 [RtcEngine.setVideoEncoderConfiguration] 中的码率值设置该参数的值。
  int expectedUplinkBitrate;

  /// 用户期望的最高接收码率，单位为 bps，范围为 [100000,5000000]。
  int expectedDownlinkBitrate;

  /// Constructs a [LastmileProbeConfig]
  LastmileProbeConfig(this.probeUplink, this.probeDownlink,
      this.expectedUplinkBitrate, this.expectedDownlinkBitrate);

  // @nodoc ignore: public_member_api_docs
  factory LastmileProbeConfig.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeConfigFromJson(json);

  // @nodoc ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$LastmileProbeConfigToJson(this);
}

/// 水印图片的位置和大小。
@JsonSerializable(explicitToJson: true)
class Rectangle {
  /// 左上角的横向偏移。
  int x;

  /// 左上角的纵向偏移
  int y;

  /// 水印图片的宽（px）。
  int width;

  /// 水印图片的高（px)。
  int height;

  /// Constructs a [Rectangle]
  Rectangle(this.x, this.y, this.width, this.height);

  // @nodoc ignore: public_member_api_docs
  factory Rectangle.fromJson(Map<String, dynamic> json) =>
      _$RectangleFromJson(json);

  // @nodoc ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$RectangleToJson(this);
}

/// 待添加的水印图片的设置选项。
@JsonSerializable(explicitToJson: true)
class WatermarkOptions {
  /// 是否将水印设为预览时本地可见：
  /// - `true`：(默认) 预览时水印本地可见。
  /// - `false`：预览时水印本地不可见。
  @JsonKey(includeIfNull: false)
  bool visibleInPreview;

  /// 视频编码模式为横屏时的水印坐标。
  /// 详见 [Rectangle]。
  Rectangle positionInLandscapeMode;

  /// 视频编码模式为竖屏时的水印坐标。
  /// 详见 [Rectangle]。
  Rectangle positionInPortraitMode;

  /// Constructs a [WatermarkOptions]
  WatermarkOptions(this.positionInLandscapeMode, this.positionInPortraitMode,
      {this.visibleInPreview});

  // @nodoc ignore: public_member_api_docs
  factory WatermarkOptions.fromJson(Map<String, dynamic> json) =>
      _$WatermarkOptionsFromJson(json);

  // @nodoc ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$WatermarkOptionsToJson(this);
}

/// 外部导入音视频流定义。
@JsonSerializable(explicitToJson: true)
class LiveInjectStreamConfig {
  /// 添加进入直播的外部视频源宽度，单位为像素。默认值为 0，即保留视频源原始宽度。
  int width;

  /// 添加进入直播的外部视频源高度，单位为像素。默认值为 0，即保留视频源原始高度。
  int height;

  /// 添加进入直播的外部视频源 GOP。默认值为 30 帧。
  @JsonKey(includeIfNull: false)
  int videoGop;

  /// 添加进入直播的外部视频源帧率。默认值为 15 fps。
  @JsonKey(includeIfNull: false)
  VideoFrameRate videoFramerate;

  /// 添加进入直播的外部视频源码率。默认设置为 400 Kbps。
  @JsonKey(includeIfNull: false)
  int videoBitrate;

  /// 添加进入直播的外部音频采样率。默认值为 44100，详见 [AudioSampleRateType]。
  ///
  /// **Note**
  /// 声网建议目前采用默认值，不要自行设置。
  @JsonKey(includeIfNull: false)
  AudioSampleRateType audioSampleRate;

  /// 添加进入直播的外部音频码率。单位为 Kbps，默认值为 48。
  ///
  /// **Note**
  /// 声网建议目前采用默认值，不要自行设置。
  @JsonKey(includeIfNull: false)
  int audioBitrate;

  /// 添加进入直播的外部音频频道数。取值范围为 1 或 2，默认值为 1。
  ///
  /// **Note** 声网建议目前采用默认值，不要自行设置。
  @JsonKey(includeIfNull: false)
  AudioChannel audioChannels;

  /// Constructs a [LiveInjectStreamConfig]
  LiveInjectStreamConfig(
    {this.width,
    this.height,
    this.videoGop,
    this.videoFramerate,
    this.videoBitrate,
    this.audioSampleRate,
    this.audioBitrate,
    this.audioChannels});

  // @nodoc ignore: public_member_api_docs
  factory LiveInjectStreamConfig.fromJson(Map<String, dynamic> json) =>
      _$LiveInjectStreamConfigFromJson(json);

  // @nodoc ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$LiveInjectStreamConfigToJson(this);
}

/// CameraCapturerConfiguration 的定义。
@JsonSerializable(explicitToJson: true)
class CameraCapturerConfiguration {
  /// 摄像头采集偏好。
  /// 详见 [CameraCaptureOutputPreference]。
  CameraCaptureOutputPreference preference;

  /// 本地采集的视频宽度 (px)。如果你需要自定义本地采集的视频宽度，请先将 [preference] 设为 `Manual(3)` ，再通过 [captureWidth] 设置采集的视频宽度。
  @JsonKey(includeIfNull: false)
  int captureWidth;

  /// 本地采集的视频高度 (px)。如果你需要自定义本地采集的视频高度，请先将 [preference] 设为 `Manual(3)` ，再通过 [captureHeight] 设置采集的视频高度。
  @JsonKey(includeIfNull: false)
  int captureHeight;

  /// 摄像头方向。
  /// 详见 [CameraDirection]。
  CameraDirection cameraDirection;

  /// Constructs a [CameraCapturerConfiguration]
  CameraCapturerConfiguration(this.preference, this.cameraDirection,
      {this.captureWidth, this.captureHeight});

  // @nodoc ignore: public_member_api_docs
  factory CameraCapturerConfiguration.fromJson(Map<String, dynamic> json) =>
      _$CameraCapturerConfigurationFromJson(json);

  // @nodoc ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$CameraCapturerConfigurationToJson(this);
}

/// 频道媒体设置选项。
@JsonSerializable(explicitToJson: true)
class ChannelMediaOptions {
  /// 设置加入频道时是否自动订阅音频流：
  /// - `true`：（默认）订阅。
  /// - `false`：不订阅。
  ///
  /// 该成员功能与 [RtcEngine.muteAllRemoteAudioStreams] 相同。
  /// 加入频道后，你可以通过 `muteAllRemoteAudioStreams` 方法重新设置是否订阅频道内的远端音频流。
  bool autoSubscribeAudio;

  /// 设置加入频道是是否自动订阅视频流：
  /// - `true`：（默认）订阅。
  /// - `false`：不订阅。
  ///
  /// 该成员功能与 [RtcEngine.muteAllRemoteVideoStreams] 相同。
  /// 加入频道后，你可以通过 `muteAllRemoteVideoStreams` 方法重新设置是否订阅频道内的远端视频流。
  bool autoSubscribeVideo;

  /// Constructs a [ChannelMediaOptions]
  ChannelMediaOptions(this.autoSubscribeAudio, this.autoSubscribeVideo);

  // @nodoc ignore: public_member_api_docs
  factory ChannelMediaOptions.fromJson(Map<String, dynamic> json) =>
      _$ChannelMediaOptionsFromJson(json);

  // @nodoc ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$ChannelMediaOptionsToJson(this);
}

/// 内置加密配置。
///
///
@JsonSerializable(explicitToJson: true)
class EncryptionConfig {
  /// 内置加密模式，默认为 `AES128XTS` 加密模式。详见 [EncryptionMode]。
  EncryptionMode encryptionMode;

  /// 内置加密密钥，字符串类型。
  ///
  /// **Note**
  ///
  /// 如果未指定该参数或将该参数设置为空，则无法启用内置加密，且 SDK 会返回错误码 `InvalidArgument`。
  String encryptionKey;

  /// Constructs a [EncryptionConfig]
  EncryptionConfig(this.encryptionMode, this.encryptionKey);

  /// @nodoc
  factory EncryptionConfig.fromJson(Map<String, dynamic> json) =>
      _$EncryptionConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$EncryptionConfigToJson(this);
}

/// 通话相关的统计信息。
@JsonSerializable(explicitToJson: true)
class RtcStats {
  /// 通话时长，单位为秒，累计值。
  int totalDuration;

  /// 发送字节数（bytes），累计值。
  int txBytes;

  /// 接收字节数（bytes），累计值。
  int rxBytes;

  /// 发送音频字节数（bytes），累计值。
  int txAudioBytes;

  /// 发送视频字节数（bytes），累计值。
  int txVideoBytes;

  /// 接收音频字节数（bytes），累计值。
  int rxAudioBytes;

  /// 接收视频字节数（bytes），累计值。
  int rxVideoBytes;

  /// 发送码率（Kbps），瞬时值。
  int txKBitRate;

  /// 接收码率（Kbps），瞬时值。
  int rxKBitRate;

  /// 音频包的发送码率（Kbps），瞬时值。
  int txAudioKBitRate;

  /// 音频接收码率（Kbps），瞬时值。
  int rxAudioKBitRate;

  /// 视频发送码率（Kbps），瞬时值。
  int txVideoKBitRate;

  /// 视频接收码率（Kbps），瞬时值。
  int rxVideoKBitRate;

  /// 频道内的人数。
  /// - 通信场景下，返回当前频道内的人数。
  /// - 直播场景下：
  ///   - 如果本地用户为观众，则返回频道内的主播数 + 1。
  ///   - 如果本地用户为主播，则返回频道内的总主播数。
  int users;

  /// 客户端到服务器的延迟（毫秒)。
  int lastmileDelay;

  /// 网络对抗前，本地客户端到边缘服务器的丢包率 (%)。
  int txPacketLossRate;

  /// 网络对抗前，边缘服务器到本地客户端的丢包率 (%)。
  int rxPacketLossRate;

  /// 当前系统的 CPU 使用率 (%)。
  double cpuTotalUsage;

  /// 当前 App 的 CPU 使用率 (%)。
  double cpuAppUsage;

  /// 客户端到本地路由器的往返时延 (ms)。
  int gatewayRtt;

  /// 当前 App 的内存占比 (%)。
  ///
  /// **Note** 该值仅作参考。受系统限制可能无法获取。
  double memoryAppUsageRatio;

  /// 当前系统的内存占比 (%)。
  ///
  /// **Note** 该值仅作参考。受系统限制可能无法获取。
  double memoryTotalUsageRatio;

  /// 当前 App 的内存大小 (KB)。
  ///
  /// **Note** 该值仅作参考。受系统限制可能无法获取。
  int memoryAppUsageInKbytes;

  /// Constructs a [RtcStats]
  RtcStats();

  // @nodoc ignore: public_member_api_docs
  factory RtcStats.fromJson(Map<String, dynamic> json) =>
      _$RtcStatsFromJson(json);

  // @nodoc ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$RtcStatsToJson(this);
}

/// 声音音量信息。 一个数组，包含每个说话者的用户 ID 和音量信息。
@JsonSerializable(explicitToJson: true)
class AudioVolumeInfo {
  /// 说话者的用户 ID。如果返回的 `uid` 为 0，则默认为本地用户。
  int uid;

  /// 说话者的音量，范围为 0（最低）- 255（最高）。
  int volume;

  /// 本地用户的人声状态。
  /// - 0：本地用户不在说话。
  /// - 1：本地用户在说话。
  ///
  ///
  /// **Note**
  /// - `vad` 无法报告远端用户的人声状态。对于远端用户，`vad` 的值始终为 0.
  /// 若需使用此参数，请在 [RtcEngine.enableAudioVolumeIndication] 方法中设置 `report_vad` 为 `true`。
  int vad;

  /// 频道 ID，表明当前说话者在哪个频道。
  String channelId;

  /// Constructs a [AudioVolumeInfo]
  AudioVolumeInfo();

  // @nodoc ignore: public_member_api_docs
  factory AudioVolumeInfo.fromJson(Map<String, dynamic> json) =>
      _$AudioVolumeInfoFromJson(json);

  // @nodoc ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$AudioVolumeInfoToJson(this);
}

/// 长方形区域。
@JsonSerializable(explicitToJson: true)
class Rect {
  /// 长方形区域的左边所对应的横坐标。
  int left;

  /// 长方形区域的上边所对应的纵坐标。
  int top;

  /// 长方形区域的右边所对应的横坐标。
  int right;

  /// 长方形区域的底边所对应的纵坐标。
  int bottom;

  /// Constructs a [Rect]
  Rect();

  // @nodoc ignore: public_member_api_docs
  factory Rect.fromJson(Map<String, dynamic> json) => _$RectFromJson(json);

  // @nodoc ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$RectToJson(this);
}

/// The one-way last-mile probe result.单向 Last-mile 质量探测结果。
@JsonSerializable(explicitToJson: true)
class LastmileProbeOneWayResult {
  /// 丢包率。
  int packetLossRate;

  /// 网络抖动，单位为毫秒。
  int jitter;

  /// 可用网络带宽预计，单位为 bps。
  int availableBandwidth;

  /// Constructs a [LastmileProbeOneWayResult]
  LastmileProbeOneWayResult();

  // @nodoc ignore: public_member_api_docs
  factory LastmileProbeOneWayResult.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeOneWayResultFromJson(json);

  // @nodoc ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$LastmileProbeOneWayResultToJson(this);
}

/// 上下行 Last-mile 质量探测结果。
@JsonSerializable(explicitToJson: true)
class LastmileProbeResult {
  /// Last-mile 质量探测结果的状态。
  /// 详见 [LastmileProbeResultState]。
  LastmileProbeResultState state;

  /// 往返时延，单位为毫秒。
  int rtt;

  /// 上行网络质量报告。
  /// 详见 [LastmileProbeOneWayResult]。
  LastmileProbeOneWayResult uplinkReport;

  /// 下行网络质量报告。
  /// 详见 [LastmileProbeOneWayResult]。
  LastmileProbeOneWayResult downlinkReport;

  /// Constructs a [LastmileProbeResult]
  LastmileProbeResult();

  // @nodoc ignore: public_member_api_docs
  factory LastmileProbeResult.fromJson(Map<String, dynamic> json) =>
      _$LastmileProbeResultFromJson(json);

  // @nodoc ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$LastmileProbeResultToJson(this);
}

/// 本地音频统计数据。
@JsonSerializable(explicitToJson: true)
class LocalAudioStats {
  /// 声道数。
  int numChannels;

  /// 发送的采样率，单位为 Hz。
  int sentSampleRate;

  /// 发送码率的平均值，单位为 Kbps。
  int sentBitrate;

  /// 网络对抗前，本地客户端到边缘服务器的丢包率 (%)。
  int txPacketLossRate;

  /// Constructs a [LocalAudioStats]
  LocalAudioStats();

  // @nodoc ignore: public_member_api_docs
  factory LocalAudioStats.fromJson(Map<String, dynamic> json) =>
      _$LocalAudioStatsFromJson(json);

  // @nodoc ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$LocalAudioStatsToJson(this);
}

/// 本地视频相关的统计信息。
@JsonSerializable(explicitToJson: true)
class LocalVideoStats {
  /// 实际发送码率，单位为 Kbps，不包含丢包后重传视频等的发送码率。
  int sentBitrate;

  /// 实际发送帧率，单位为 fps，不包含丢包后重传视频等的发送帧率。
  int sentFrameRate;

  /// 本地编码器的输出帧率，单位为 fps。
  int encoderOutputFrameRate;

  /// 本地渲染器的输出帧率，单位为 fps。
  int rendererOutputFrameRate;

  /// 当前编码器的目标编码码率，单位为 Kbps，该码率为 SDK 根据当前网络状况预估的一个值。
  int targetBitrate;

  /// 当前编码器的目标编码帧率，单位为 fps。
  int targetFrameRate;

  /// 自上次统计后本地视频质量的自适应情况（基于目标帧率和目标码率）。
  /// 详见 [VideoQualityAdaptIndication]。
  VideoQualityAdaptIndication qualityAdaptIndication;

  /// 视频编码码率（Kbps）。该参数不包含丢包后重传视频等的编码码率。
  int encodedBitrate;

  /// 视频编码宽度（px）。
  int encodedFrameWidth;

  /// 视频编码高度（px）。
  int encodedFrameHeight;

  /// 视频发送的帧数，累计值。
  int encodedFrameCount;

  /// 视频的编码类型。
  /// 详见 [VideoCodecType]。
  VideoCodecType codecType;

  /// 弱网对抗前本地客户端到 Agora 边缘服务器的视频丢包率 (%)。
  int txPacketLossRate;

  /// 本地视频采集帧率 (fps)。
  int captureFrameRate;


  /// Constructs a [LocalVideoStats]
  LocalVideoStats();

  // @nodoc ignore: public_member_api_docs
  factory LocalVideoStats.fromJson(Map<String, dynamic> json) =>
      _$LocalVideoStatsFromJson(json);

  // @nodoc ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$LocalVideoStatsToJson(this);
}

/// 远端音频统计信息。
@JsonSerializable(explicitToJson: true)
class RemoteAudioStats {
  /// 用户 ID，指定是哪个用户/主播的音频流。
  int uid;

  /// 远端用户发送的音频流质量。
  /// 详见 [NetworkQuality]。
  NetworkQuality quality;

  /// 音频发送端到接收端的网络延迟（毫秒）。
  int networkTransportDelay;

  /// 接收端到网络抖动缓冲的网络延迟 (ms)。
  ///
  /// **Note**
  ///
  /// 当接收端为观众且 [AudienceLatencyLevelType] 为 `1` 时，该参数不生效。
  int jitterBufferDelay;

  ///  统计周期内的远端音频流的丢帧率 (%)。
  int audioLossRate;

  /// 声道数。
  int numChannels;

  /// 统计周期内接收到的远端音频采样率（Hz）。
  int receivedSampleRate;

  /// 接收流在统计周期内的平均码率（Kbps）。
  int receivedBitrate;

  /// 远端用户在加入频道后发生音频卡顿的累计时长 (ms)。
  /// 一个统计周期内，音频丢帧率达到 4% 即记为一次音频卡顿。
  int totalFrozenTime;

  /// 远端用户在加入频道后发生音频卡顿的累计时长占音频总有效时长的百分比 (%)。
  int frozenRate;

  /// 远端用户在音频通话开始到本次回调之间的有效时长（ms）。
  /// 有效时长是指去除了远端用户进入 mute 状态的总时长。
  int totalActiveTime;

  /// 远端音频流的累计发布时长（毫秒）。
  int publishDuration;

  /// 接收远端音频时，本地用户的主观体验质量。详见 [ExperienceQuality]。
  ExperienceQualityType qoeQuality;

  /// 接收远端音频时，本地用户的主观体验质量较差的原因。详见 [ExperiencePoorReason]。
  ExperiencePoorReason qualityChangedReason;

  /// 统计周期内，Agora 实时音频 MOS（平均主观意见分）评估方法对接收到的远端音频流的质量评分。
  /// 返回值范围为 [0,500]。返回值除以 100 即可得到 MOS 分数，范围为 [0,5] 分，分数越高，音频质量越好。
  ///
  /// Agora 实时音频 MOS 评分对应的主观音质感受如下:
  ///
  /// <table border="1">
  /// <thead>
  /// <tr>
  ///   <th>MOS 分数</th>
  ///   <th>音质感受</th>
  /// </tr>
  /// </thead>
  /// <tbody>
  /// <tr>
  /// <td>大于 4 分</td>
  /// <td>- 音频质量佳，清晰流畅。</td>
  /// </tr>
  /// <tr>
  /// <td>3.5 - 4 分</td>
  /// <td>音频质量较好，偶有音质损伤，但依然清晰。</td>
  /// </tr>
  /// <tr>
  /// <td>3 - 3.5 分</td>
  /// <td>音频质量一般，偶有卡顿，不是非常流畅，需要一点注意力才能听清。</td>
  /// </tr>
  /// <tr>
  /// <td>2.5 - 3 分</td>
  /// <td>音频质量较差，卡顿频繁，需要集中精力才能听清。</td>
  /// </tr>
  /// <tr>
  /// <td>2 - 2.5 分</td>
  /// <td>音频质量很差，偶有杂音，部分语义丢失，难以交流。</td>
  /// </tr>
  /// <tr>
  /// <td>小于 2 分</td>
  /// <td>音频质量非常差，杂音频现，大量语义丢失，完全无法交流。</td>
  /// </tr>
  /// </tbody>
  /// </table>
  int mosValue;

  /// Constructs a [RemoteAudioStats]
  RemoteAudioStats();

  // @nodoc ignore: public_member_api_docs
  factory RemoteAudioStats.fromJson(Map<String, dynamic> json) =>
      _$RemoteAudioStatsFromJson(json);

  // @nodoc ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$RemoteAudioStatsToJson(this);
}

/// 远端视频相关的统计信息。
@JsonSerializable(explicitToJson: true)
class RemoteVideoStats {
  /// 用户 ID，指定是哪个用户的视频流。
  int uid;

  /// 延迟，单位为毫秒。
  ///
  /// **Deprecated** 该参数已废弃。声网不建议你使用.
  /// 在有音画同步机制的音视频场景中，你可以参考 [RemoteAudioStats] 里的 `networkTransportDelay` 和 `jitterBufferDelay`成员的值，了解视频的延迟数据。
  @deprecated
  int delay;

  /// 远端视频流宽度，单位为像素。
  int width;

  /// 远端视频流高度，单位为像素。
  int height;

  /// 接收码率，单位为 Kbps。
  int receivedBitrate;

  /// 远端视频解码器的输出帧率，单位为 fps。
  int decoderOutputFrameRate;

  /// 远端视频渲染器的输出帧率，单位为 fps。
  int rendererOutputFrameRate;

  /// 远端视频在网络对抗之后的丢包率 (%)。
  int packetLossRate;

  /// 视频流类型，大流或小流。
  /// 详见 [VideoStreamType]。
  VideoStreamType rxStreamType;

  /// 远端用户在加入频道后发生视频卡顿的累计时长（毫秒）。
  /// 通话过程中，视频帧率设置不低于 5 fps 时，连续渲染的两帧视频之间间隔超过 500 ms，则记为一次视频卡顿。
  int totalFrozenTime;

  /// 远端用户在加入频道后发生视频卡顿的累计时长占视频总有效时长的百分比 (%)。
  int frozenRate;

  /// 视频总有效时长（毫秒）。
  /// 视频总有效时长是远端用户或主播加入频道后，既没有停止发送视频流，也没有禁用视频模块的通话时长。
  int totalActiveTime;

  /// 远端视频流的累计发布时长（毫秒）。
  int publishDuration;

  /// Constructs a [RemoteVideoStats]
  RemoteVideoStats();

  // @nodoc ignore: public_member_api_docs
  factory RemoteVideoStats.fromJson(Map<String, dynamic> json) =>
      _$RemoteVideoStatsFromJson(json);

  // @nodoc ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$RemoteVideoStatsToJson(this);
}

/// 检测到的人脸信息。
@JsonSerializable(explicitToJson: true)
class FacePositionInfo {
  /// 人脸在画面中的 x 坐标 (px)。以摄像头采集画面的左上角为原点，x 坐标为人脸左上角相对于原点的横向位移。
  int x;

  /// 人脸在画面中的 y 坐标 (px)。以摄像头采集画面的左上角为原点，y 坐标为人脸左上角相对原点的纵向位移。
  int y;

  /// 人脸在画面中的宽度 (px)。
  int width;

  /// 人脸在画面中的高度 (px)。
  int height;

  /// 人脸距设备屏幕的距离 (cm)。
  int distance;

  /// Constructs a [FacePositionInfo]
  FacePositionInfo();

  // @nodoc ignore: public_member_api_docs
  factory FacePositionInfo.fromJson(Map<String, dynamic> json) =>
      _$FacePositionInfoFromJson(json);

  // @nodoc ignore: public_member_api_docs
  Map<String, dynamic> toJson() => _$FacePositionInfoToJson(this);
}

/// 用户具体设置。
@JsonSerializable(explicitToJson: true)
class ClientRoleOptions {
  /// 观众端延时级别：
  AudienceLatencyLevelType audienceLatencyLevel;

  /// Constructs a [ClientRoleOptions]
  ClientRoleOptions(this.audienceLatencyLevel);

  /// @nodoc
  factory ClientRoleOptions.fromJson(Map<String, dynamic> json) =>
      _$ClientRoleOptionsFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$ClientRoleOptionsToJson(this);
}

///  设置 Agora SDK 输出的日志文件。
@JsonSerializable(explicitToJson: true)
class LogConfig {
  /// 日志文件的绝对路径。日志文件的默认地址是 `/storage/emulated/0/Android/data/<package name>/files/agorasdk.log` (Android)； `App Sandbox/Library/caches/agorasdk.log` (iOS).
  ///
  /// App 必须保证你指定的目录存在而且可写。你可以使用此参数重命名日志文件。
  @JsonKey(includeIfNull: false)
  String filePath;

  /// 单个日志文件的大小，单位为 KB。
  ///
  /// 默认值为 1024 KB。如果你将 `fileSize` 设为 1024 KB，SDK 会最多输出总计 5 MB 的日志文件。 如果你将 `fileSize` 设为小于 1024 KB，设置不生效，单个日志文件最大仍为 1024 KB。
  @JsonKey(includeIfNull: false)
  int fileSize;

  /// 设置 Agora SDK 的日志输出等级。详见 [LogLevel]。
  ///
  /// 例如，如果你选择 `Warn` 级别，就可以看到在 `Fatal`、`Error` 和 `Warn` 级别的所有日志信息。
  @JsonKey(includeIfNull: false)
  LogLevel level;

  /// Constructs a [LogConfig]
  LogConfig({this.filePath, this.fileSize, this.level});

  /// @nodoc
  factory LogConfig.fromJson(Map<String, dynamic> json) =>
      _$LogConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$LogConfigToJson(this);
}

/// 数据流设置。
///
/// 下表展示了 [syncWithAudio] 参数和 [ordered] 参数的关系:
///
/// | [syncWithAudio] | [ordered] | SDK 行为                                                                                                                                                                                                                                                                                                                                                                                |
/// |---------------|---------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
/// | `false`       | `false`    | 接收端接收到数据包后，SDK 立刻触发 `streamMessage` 回调。                                                                                                                                                                                                                                                                            |
/// | `true`        | `false`    | <ul><li>如果数据包的延迟在音频延迟的范围内，SDK 会在播放音频的同时触发与该音频包同步的 <code>streamMessage</code> 回调。</li><li>如果某数据包的延迟超出了音频延迟，SDK 会在接收到该数据包时立刻触发 <code>streamMessage</code> 回调；此情况会造成音频包和数据包的不同步。</li></ul> |
/// | `false`       | `true`     | <ul><li>如果数据包的延迟在 5 秒以内，SDK 会修正数据包的乱序问题。</li><li>如果数据包的延迟超出 5 秒，SDK 会丢弃该数据包。</li></ul>                                                                                                                                                                                                   |
/// | `true`        | `true`     | <ul><li>如果数据包的延迟在音频延迟的范围内，SDK 会修正数据包的乱序问题。</li><li>如果数据包的延迟超出音频延迟，SDK 会丢弃该数据包。</li></ul>                                                                 |
@JsonSerializable(explicitToJson: true)
class DataStreamConfig {
  /// 是否与本地发送的音频流同步。
  ///
  /// - `true`: 数据流与音频流同步。
  /// - `false`: 数据流与音频流不同步。
  ///
  /// 设置为与音频同步后，如果数据包的延迟在音频延迟的范围内，SDK 会在播放音频的同时 触发与该音频包同步的 `streamMessage` 回调。
  ///  当需要数据包立刻到达接收端时，不能将该参数设置为 `true`。Agora 建议你仅在需要实现特殊场景，例如歌词同步时，设置为与音频同步。
  @JsonKey(includeIfNull: false)
  bool syncWithAudio;

  /// 是否保证接收到的数据按发送的顺序排列。
  ///
  /// - `true`: 保证 SDK 按照发送方发送的顺序输出数据包。
  /// - `false`: 不保证 SDK 按照发送方发送的顺序输出数据包。
  ///
  /// 当需要数据包立刻到达接收端时，不能将该参数设置为 `true`。
  @JsonKey(includeIfNull: false)
  bool ordered;

  /// Constructs a [DataStreamConfig]
  DataStreamConfig({this.syncWithAudio, this.ordered});

  /// @nodoc
  factory DataStreamConfig.fromJson(Map<String, dynamic> json) =>
      _$DataStreamConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$DataStreamConfigToJson(this);
}

/// RtcEngineConfig 实例的配置。
@JsonSerializable(explicitToJson: true)
class RtcEngineConfig {
  /// Agora 为 app 开发者签发的 App ID，详见[获取 App ID](https://docs.agora.io/cn/Agora%20Platform/token#get-an-app-id)。
  /// 使用同一个 App ID 的 app 才能进入同一个频道进行通话或直播。
  /// 一个 App ID 只能用于创建一个 `RtcEngine` 实例。如需更换 App ID，必须先调用 `destroy` 销毁当前 `RtcEngine` 实例，并在 destroy 成功返回后，
  /// 再调用 `createWithConfig` 重新创建 `RtcEngine`。
  String appId;

  /// 服务器的访问区域。该功能为高级设置，适用于有访问安全限制的场景。
  ///
  /// 支持的区域详见 [AreaCode]。指定访问区域后，Agora SDK 会连接指定区域内的 Agora 服务器。
  @JsonKey(includeIfNull: false)
  AreaCode areaCode;

  /// 设置 Agora SDK 输出的日志文件。详见 [LogConfig]。
  ///
  /// 默认情况下，SDK 会生成 `agorasdk.log`、`agorasdk_1.log`、`agorasdk_2.log`、 `agorasdk_3.log`、`agorasdk_4.log` 这 5 个日志文件。
  /// 每个文件的默认大小为 1024 KB。 日志文件为 UTF-8 编码。
  /// 最新的日志永远写在 `agorasdk.log` 中。`agorasdk.log` 写满后， SDK 会从 1-4 中删除修改时间最早的一个文件，然后将 `agorasdk.log` 重命名为该文件，并建立 新的 `agorasdk.log` 写入最新的日志。
  @JsonKey(includeIfNull: false)
  LogConfig logConfig;

  /// Constructs a [RtcEngineConfig]
  RtcEngineConfig(this.appId, {this.areaCode, this.logConfig});

  /// @nodoc
  factory RtcEngineConfig.fromJson(Map<String, dynamic> json) =>
      _$RtcEngineConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$RtcEngineConfigToJson(this);
}
