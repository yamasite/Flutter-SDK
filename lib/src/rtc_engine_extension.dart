import 'rtc_engine.dart';

/// RtcEngine 扩展
extension RtcEngineExtension on RtcEngine {
  /// 通过 asset 的相对路径获取绝对路径。
  ///
  /// - [assetPath] 在 `pubspec.yaml` 的 `flutter` -> `assets` 字段中配置的 asset 路径, 例如: `assets/Sound_Horizon.mp3`。
  /// - 返回绝对路径的地址。
  Future<String?> getAssetAbsolutePath(String assetPath) {
    return RtcEngine.methodChannel
        .invokeMethod('getAssetAbsolutePath', assetPath);
  }
}
