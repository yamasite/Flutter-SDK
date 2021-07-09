import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'src/enums.dart';
import 'src/rtc_render_view.dart';

/// （仅适用于 Android）SurfaceView 类。
///
/// **Note**
/// 在 iOS 平台，请使用 [UIView](https://developer.apple.com/documentation/uikit/uiview)。
class SurfaceView extends RtcSurfaceView {
  /// Constructs a [SurfaceView]
  SurfaceView({
    Key? key,
    required int uid,
    String? channelId,
    renderMode = VideoRenderMode.Hidden,
    mirrorMode = VideoMirrorMode.Auto,
    zOrderOnTop = false,
    zOrderMediaOverlay = false,
    PlatformViewCreatedCallback? onPlatformViewCreated,
    Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
  })  : assert(uid != 0),
        super(
          key: key,
          uid: uid,
          channelId: channelId,
          renderMode: renderMode,
          mirrorMode: mirrorMode,
          zOrderOnTop: zOrderOnTop,
          zOrderMediaOverlay: zOrderMediaOverlay,
          onPlatformViewCreated: onPlatformViewCreated,
          gestureRecognizers: gestureRecognizers,
        );
}

/// 仅适用于 （Android） TextureView 类。
///
/// **Note**
/// 在 iOS 平台，请使用 [UIView](https://developer.apple.com/documentation/uikit/uiview)。
class TextureView extends RtcTextureView {
  /// Constructs a [TextureView]
  TextureView({
    Key? key,
    required int uid,
    String? channelId,
    renderMode = VideoRenderMode.Hidden,
    mirrorMode = VideoMirrorMode.Auto,
    PlatformViewCreatedCallback? onPlatformViewCreated,
    Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
  })  : assert(uid != 0),
        super(
          key: key,
          uid: uid,
          channelId: channelId,
          renderMode: renderMode,
          mirrorMode: mirrorMode,
          onPlatformViewCreated: onPlatformViewCreated,
          gestureRecognizers: gestureRecognizers,
        );
}