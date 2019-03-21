#import <Flutter/Flutter.h>
#import <AgoraRtcEngineKit/AgoraRtcEngineKit.h>

@interface AgoraRtcEnginePlugin : NSObject<FlutterPlugin>
@end

@interface AgoraRendererView : NSObject<FlutterPlatformView>
@end


@interface AgoraTextureView : NSObject<AgoraVideoSinkProtocol, FlutterTexture>
@end
