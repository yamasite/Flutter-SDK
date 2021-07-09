import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'enum_converter.dart';
import 'enums.dart';

final Map<int, MethodChannel> _channels = {};

/// （仅适用于 Android）SurfaceView 类。
///
/// **Note**
/// 在 iOS 平台，请使用 [UIView](https://developer.apple.com/documentation/uikit/uiview)。
class RtcSurfaceView extends StatefulWidget {
  /// 用户 ID。
  final int uid;

  /// 标识通话的频道名称，长度在 64 字节以内的字符串。以下为支持的字符集范围（共 89 个字符）：
  /// - 26 个小写英文字母 a-z
  /// - 26 个大写英文字母 A-Z
  /// - 10 个数字 0-9
  /// - 空格
  /// - "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "\[", "\]", "^", "_", " {", "}", "|", "~", ","
  ///
  /// **Note**
  /// - 该参数的默认值为空字符 ""。如果用户是通过 [RtcEngine] 类的 [RtcEngine.joinChannel] 方法加入频道的， 则将参数设为默认值，表示该用户在频道内的渲染视图。
  /// - 如果用户是通过 [RtcChannel] 类的 [RtcChannel.joinChannel] 方法加入频道的，则将该参数设为该 [RtcChannel] 类对应的 `channelId`，表示该用户在该 `channelId` 对应频道内的渲染视图。
  final String? channelId;

  /// 视频视图的渲染模式。
  final VideoRenderMode renderMode;

  /// 视频的镜像模式。
  final VideoMirrorMode mirrorMode;

  /// 是否将 SurfaceView 视图的表层置于窗口上层。
  /// [TargetPlatform.android]
  final bool zOrderOnTop;

  /// 是否将 SurfaceView 视图的表层置于窗口中另一个 SurfaceView 的上层 (但依然位于窗口的下层)。
  /// [TargetPlatform.android]
  final bool zOrderMediaOverlay;

  /// 创建平台视图回调。
  ///
  /// `id` 是平台视图的唯一标识。
  final PlatformViewCreatedCallback? onPlatformViewCreated;

  /// 指定 Web 视图使用的手势。
  ///
  /// 如果存在多个手势识别器，其他手势识别器会与 Web 视图竞争指针事件的处权。例如，假设 Web 视图位于 [ListView] 中，
  /// [ListView] 会争取对垂直方向的拖动手势进行处理。Web 视图将声明已被其他手势识别器识别的手势。
  ///
  /// 如果该集合为空，Web 视图将仅处理没有被任何手势识别器声明的指针事件。
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers;

  /// Constructs a [RtcSurfaceView]
  RtcSurfaceView({
    Key? key,
    required this.uid,
    this.channelId,
    this.renderMode = VideoRenderMode.Hidden,
    this.mirrorMode = VideoMirrorMode.Auto,
    this.zOrderOnTop = false,
    this.zOrderMediaOverlay = false,
    this.onPlatformViewCreated,
    this.gestureRecognizers,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RtcSurfaceViewState();
  }
}

class _RtcSurfaceViewState extends State<RtcSurfaceView> {
  int? _id;
  int? _renderMode;
  int? _mirrorMode;

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: AndroidView(
          viewType: 'AgoraSurfaceView',
          onPlatformViewCreated: onPlatformViewCreated,
          hitTestBehavior: PlatformViewHitTestBehavior.transparent,
          creationParams: {
            'data': {'uid': widget.uid, 'channelId': widget.channelId},
            'renderMode': _renderMode,
            'mirrorMode': _mirrorMode,
            'zOrderOnTop': widget.zOrderOnTop,
            'zOrderMediaOverlay': widget.zOrderMediaOverlay,
          },
          creationParamsCodec: const StandardMessageCodec(),
          gestureRecognizers: widget.gestureRecognizers,
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: UiKitView(
          viewType: 'AgoraSurfaceView',
          onPlatformViewCreated: onPlatformViewCreated,
          hitTestBehavior: PlatformViewHitTestBehavior.transparent,
          creationParams: {
            'data': {'uid': widget.uid, 'channelId': widget.channelId},
            'renderMode': _renderMode,
            'mirrorMode': _mirrorMode,
          },
          creationParamsCodec: const StandardMessageCodec(),
          gestureRecognizers: widget.gestureRecognizers,
        ),
      );
    }
    return Text('$defaultTargetPlatform is not yet supported by the plugin');
  }

  @override
  void initState() {
    super.initState();
    _renderMode = VideoRenderModeConverter(widget.renderMode).value();
    _mirrorMode = VideoMirrorModeConverter(widget.mirrorMode).value();
  }

  @override
  void didUpdateWidget(RtcSurfaceView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.uid != widget.uid ||
        oldWidget.channelId != widget.channelId) {
      setData();
    }
    if (oldWidget.renderMode != widget.renderMode) {
      setRenderMode();
    }
    if (oldWidget.mirrorMode != widget.mirrorMode) {
      setMirrorMode();
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      if (oldWidget.zOrderOnTop != widget.zOrderOnTop) {
        setZOrderOnTop();
      }
      if (oldWidget.zOrderMediaOverlay != widget.zOrderMediaOverlay) {
        setZOrderMediaOverlay();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _channels.remove(_id);
  }

  void setData() {
    _channels[_id]?.invokeMethod('setData', {
      'data': {
        'uid': widget.uid,
        'channelId': widget.channelId,
      },
    });
  }
  void setRenderMode() {
    _renderMode = VideoRenderModeConverter(widget.renderMode).value();
    _channels[_id]?.invokeMethod('setRenderMode', {
      'renderMode': _renderMode,
    });
  }

  void setMirrorMode() {
    _mirrorMode = VideoMirrorModeConverter(widget.mirrorMode).value();
    _channels[_id]?.invokeMethod('setMirrorMode', {
      'mirrorMode': _mirrorMode,
    });
  }

  void setZOrderOnTop() {
    _channels[_id]?.invokeMethod('setZOrderOnTop', {
      'onTop': widget.zOrderOnTop,
    });
  }

  void setZOrderMediaOverlay() {
    _channels[_id]?.invokeMethod('setZOrderMediaOverlay', {
      'isMediaOverlay': widget.zOrderMediaOverlay,
    });
  }

  Future<void> onPlatformViewCreated(int id) async {
    _id = id;
    if (!_channels.containsKey(id)) {
      _channels[id] = MethodChannel('agora_rtc_engine/surface_view_$id');
    }
    widget.onPlatformViewCreated?.call(id);
  }
}

/// （仅适用于 Android） TextureView 类。
///
/// **Note**
/// 在 iOS 平台，请使用 [UIView](https://developer.apple.com/documentation/uikit/uiview)。
///
/// [TargetPlatform.android]
class RtcTextureView extends StatefulWidget {
  /// 用户 ID。
  final int uid;

  /// 标识通话的频道名称，长度在 64 字节以内的字符串。以下为支持的字符集范围（共 89 个字符）：
  /// - 26 个小写英文字母 a-z
  /// - 26 个大写英文字母 A-Z
  /// - 10 个数字 0-9
  /// - 空格
  /// - "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "\[", "\]", "^", "_", " {", "}", "|", "~", ","
  ///
  /// **Note**
  /// - 该参数的默认值为空字符 ""。如果用户是通过 [RtcEngine] 类的 [RtcEngine.joinChannel] 方法加入频道的， 则将参数设为默认值，表示该用户在频道内的渲染视图。
  /// - 如果用户是通过 [RtcChannel] 类的 [RtcChannel.joinChannel] 方法加入频道的，则将该参数设为该 [RtcChannel] 类对应的 `channelId`，表示该用户在该 `channelId` 对应频道内的渲染视图。
  final String? channelId;

  /// 视频视图的渲染模式。
  final VideoRenderMode renderMode;

  /// 视频的镜像模式。
  final VideoMirrorMode mirrorMode;

  /// 创建平台视图回调。
  ///
  /// `id` 是平台视图的唯一标识。
  final PlatformViewCreatedCallback? onPlatformViewCreated;


  /// 指定 Web 视图使用的手势。
  ///
  /// 如果存在多个手势识别器，其他手势识别器会与 Web 视图竞争指针事件的处权。例如，假设 Web 视图位于 [ListView] 中，
  /// [ListView] 会争取对垂直方向的拖动手势进行处理。Web 视图将声明已被其他手势识别器识别的手势。
  ///
  /// 如果该集合为空，Web 视图将仅处理没有被任何手势识别器声明的指针事件。
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers;

  /// Constructs a [RtcTextureView]
  RtcTextureView({
    Key? key,
    required this.uid,
    this.channelId,
    this.renderMode = VideoRenderMode.Hidden,
    this.mirrorMode = VideoMirrorMode.Auto,
    this.onPlatformViewCreated,
    this.gestureRecognizers,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RtcTextureViewState();
  }
}

class _RtcTextureViewState extends State<RtcTextureView> {
  int? _id;
  int? _renderMode;
  int? _mirrorMode;

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: AndroidView(
          viewType: 'AgoraTextureView',
          onPlatformViewCreated: onPlatformViewCreated,
          hitTestBehavior: PlatformViewHitTestBehavior.transparent,
          creationParams: {
            'data': {'uid': widget.uid, 'channelId': widget.channelId},
            'renderMode': _renderMode,
            'mirrorMode': _mirrorMode,
          },
          creationParamsCodec: const StandardMessageCodec(),
          gestureRecognizers: widget.gestureRecognizers,
        ),
      );
    }
    return Text('$defaultTargetPlatform is not yet supported by the plugin');
  }

  @override
  void initState() {
    super.initState();
    _renderMode = VideoRenderModeConverter(widget.renderMode).value();
    _mirrorMode = VideoMirrorModeConverter(widget.mirrorMode).value();
  }

  @override
  void didUpdateWidget(RtcTextureView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.uid != widget.uid ||
        oldWidget.channelId != widget.channelId) {
      setData();
    }
    if (oldWidget.renderMode != widget.renderMode) {
      setRenderMode();
    }
    if (oldWidget.mirrorMode != widget.mirrorMode) {
      setMirrorMode();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _channels.remove(_id);
  }

  void setData() {
    _channels[_id]?.invokeMethod('setData', {
      'data': {
        'uid': widget.uid,
        'channelId': widget.channelId,
      },
    });
  }

  void setRenderMode() {
    _renderMode = VideoRenderModeConverter(widget.renderMode).value();
    _channels[_id]?.invokeMethod('setRenderMode', {
      'renderMode': _renderMode,
    });
  }

  void setMirrorMode() {
    _mirrorMode = VideoMirrorModeConverter(widget.mirrorMode).value();
    _channels[_id]?.invokeMethod('setMirrorMode', {
      'mirrorMode': _mirrorMode,
    });
  }

  Future<void> onPlatformViewCreated(int id) async {
    _id = id;
    if (!_channels.containsKey(id)) {
      _channels[id] = MethodChannel('agora_rtc_engine/texture_view_$id');
    }
    widget.onPlatformViewCreated?.call(id);
  }
}
