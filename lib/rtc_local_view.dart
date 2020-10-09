import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import './src/enums.dart';
import './src/rtc_render_view.dart';

/// （仅适用于 Android）SurfaceView 类。
///
/// **Note**
/// 在 iOS 平台，请使用 [UIView](https://developer.apple.com/documentation/uikit/uiview)。
class SurfaceView extends RtcSurfaceView {
  /// Constructs a [SurfaceView]
  SurfaceView({
    Key key,
    bool zOrderMediaOverlay = false,
    bool zOrderOnTop = false,
    VideoRenderMode renderMode = VideoRenderMode.Hidden,
    String channelId,
    VideoMirrorMode mirrorMode = VideoMirrorMode.Auto,
    Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers,
    PlatformViewCreatedCallback onPlatformViewCreated,
  }) : super(
      key: key,
      zOrderMediaOverlay: zOrderMediaOverlay,
      zOrderOnTop: zOrderOnTop,
      renderMode: renderMode,
      channelId: channelId,
      mirrorMode: mirrorMode,
      gestureRecognizers: gestureRecognizers,
      onPlatformViewCreated: onPlatformViewCreated,
      uid: 0);
}

/// 仅适用于 （Android） TextureView 类。
///
/// **Note**
/// 在 iOS 平台，请使用 [UIView](https://developer.apple.com/documentation/uikit/uiview)。
class TextureView extends RtcTextureView {
  /// Constructs a [TextureView]
  TextureView({
    Key key,
    VideoRenderMode renderMode = VideoRenderMode.Hidden,
    String channelId,
    VideoMirrorMode mirrorMode = VideoMirrorMode.Auto,
    Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers,
    PlatformViewCreatedCallback onPlatformViewCreated,
  }) : super(
      key: key,
            renderMode: renderMode,
            channelId: channelId,
            mirrorMode: mirrorMode,
            gestureRecognizers: gestureRecognizers,
            onPlatformViewCreated: onPlatformViewCreated,
            uid: 0);
}
