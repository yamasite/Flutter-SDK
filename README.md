Agora Flutter SDK 基于 Android 和 iOS 平台的 Agora RTC SDK 封装，可在基于 Flutter 开发的 Android 和 iOS 移动端应用中快速实现实时音视频功能。

- The <a href="rtc_engine/RtcEngine-class.html">RtcEngine</a> 类包含应用程序调用的主要方法。
- The <a href ="rtc_engine/RtcEngineEventHandler-class.html"> RtcEngineEventHandler</a> 类用于向应用程序发送回调通知。
- The <a href ="rtc_channel/RtcChannel-class.html">RtcChannel</a> 类在指定频道中实现实时音视频功能。通过创建多个 RtcChannel 对象，用户可以同时加入多个频道。
- The <a href ="rtc_channel/RtcChannelEventHandler-class.html">RtcChannelEventHandler</a> 类监听和报告指定频道的事件和数据。

### 频道管理

<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href="rtc_engine/RtcEngine/create.html">create</a></td>
<td>创建 <code>RtcEngine</code> 实例</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/createWithAreaCode.html">createWithAreaCode</a></a></td>
<td>创建 <code>RtcEngine</code> 实例（指定访问区域）</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/destroy.html">destroy</a></td>
<td>销毁 <code>RtcEngine</code> 实例</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setChannelProfile.html">setChannelProfile</a></td>
<td>设置频道场景</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/setClientRole.html">setClientRole</a></td>
<td>设置直播场景下的用户角色</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/joinChannel.html">joinChannel</a></td>
<td>加入频道</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/switchChannel.html">switchChannel</a></td>
<td>快速切换直播频道</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/leaveChannel.html">leaveChannel</a></td>
<td>离开频道</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/destroy.html">destroy</a></td>
<td>销毁 <code>RtcChannel</code> 实例</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/renewToken.html">renewToken</a></td>
<td>更新 Token</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/getConnectionState.html">getConnectionState</a></td>
<td>获取网络连接状态</td>
</tr>
</table>

### 频道事件

<table border="1">
<tr>
<th>事件</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/connectionStateChanged.html">connectionStateChanged</a></td>
<td>网络连接状态已改变回调</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/joinChannelSuccess.html">joinChannelSuccess</a></td>
<td>加入频道回调</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/rejoinChannelSuccess.html">rejoinChannelSuccess</a></td>
<td>重新加入频道回调</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/leaveChannel.html">leaveChannel</a></td>
<td>离开频道回调</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/clientRoleChanged.html">clientRoleChanged</a></td>
<td>用户角色已切换回调</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/userJoined.html">userJoined</a></td>
<td>远端用户加入当前频道回调</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/userOffline.html">userOffline</a></td>
<td>远端用户离开当前频道回调</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngineEventHandler/networkTypeChanged.html">networkTypeChanged</a></td>
<td>本地网络类型发生改变回调</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/connectionLost.html">connectionLost</a></td>
<td>网络连接丢失回调</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/tokenPrivilegeWillExpire.html">tokenPrivilegeWillExpire</a></td>
<td>Token 服务即将过期回调</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/requestToken.html">requestToken</a></td>
<td>Token 已过期回调</td>
</tr>
</table>


### 音频管理

<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/enableAudio.html">enableAudio</a></td>
<td>启用音频模块</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/disableAudio.html">disableAudio</a></td>
<td>关闭音频模块</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setAudioProfile.html">setAudioProfile</a></td>
<td>设置音频编码配置</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/adjustRecordingSignalVolume.html">adjustRecordingSignalVolume</a></td>
<td>调节录音音量</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/adjustUserPlaybackSignalVolume.html">adjustUserPlaybackSignalVolume</a></td>
<td>调节本地播放的指定远端用户音量</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/adjustPlaybackSignalVolume.html">adjustPlaybackSignalVolume</a></td>
<td>调节本地播放的所有远端用户音量</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/enableLocalAudio.html">enableLocalAudio</a></td>
<td>开关本地音频采集</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/muteLocalAudioStream.html">muteLocalAudioStream</a></td>
<td>停止/恢复发送本地音频流</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/muteRemoteAudioStream.html">muteRemoteAudioStream</a></td>
<td>停止/恢复接收指定音频流</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/muteAllRemoteAudioStreams.html">muteAllRemoteAudioStreams</a></td>
<td>停止/恢复接收所有音频流</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/setDefaultMuteAllRemoteAudioStreams.html">setDefaultMuteAllRemoteAudioStreams</a></td>
<td>设置是否默认接收音频流</td>
</tr>
</table>


### 视频管理

<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/enableVideo.html">enableVideo</a></td>
<td>启用视频模块</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/disableVideo.html">disableVideo</a></td>
<td>关闭视频模块</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setVideoEncoderConfiguration.html">setVideoEncoderConfiguration</a></td>
<td>设置视频编码配置</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/startPreview.html">startPreview</a></td>
<td>开启视频预览</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/stopPreview.html">stopPreview</a></td>
<td>停止视频预览</td>
<tr>
<td><a href ="rtc_engine/RtcEngine/enableLocalVideo.html">enableLocalVideo</a></td>
<td>开关本地视频采集</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/muteLocalVideoStream.html">muteLocalVideoStream</a></td>
<td>停止/恢复发送本地视频流</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/muteRemoteVideoStream.html">muteRemoteVideoStream</a></td>
<td>停止/恢复接收指定视频流</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/muteAllRemoteVideoStreams.html">muteAllRemoteVideoStreams</a></td>
<td>停止/恢复接收所有视频流</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/setDefaultMuteAllRemoteVideoStreams.html">setDefaultMuteAllRemoteVideoStreams</a></td>
<td>设置是否默认接收视频流</td>
</tr>
</table>

### 本地媒体事件

<table border="1">
<tr>
<th>事件</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngineEventHandler/localAudioStateChanged.html">localAudioStateChanged</a></td>
<td>本地音频状态改变回调</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngineEventHandler/localVideoStateChanged.html">localVideoStateChanged</a></td>
<td>本地视频状态改变回调</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngineEventHandler/firstLocalAudioFramePublished.html">firstLocalAudioFramePublished</a></td>
<td>已发布本地音频首帧回调 </td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngineEventHandler/firstLocalVideoFramePublished.html">firstLocalVideoFramePublished</a></td>
<td>已发布本地视频首帧回调</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngineEventHandler/firstLocalVideoFrame.html">firstLocalVideoFrame</a></td>
<td>已显示本地视频首帧回调。</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/audioPublishStateChanged.html">audioPublishStateChanged</a></td>
<td>音频发布状态改变回调 </td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/videoPublishStateChanged.html">videoPublishStateChanged</a></td>
<td>视频发布状态改变回调 </td>
</tr>
</table>

### 远端媒体事件

<table border="1">
<tr>
<th>事件</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/remoteAudioStateChanged.html">remoteAudioStateChanged</a></td>
<td>远端用户音频状态已改变回调</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/remoteVideoStateChanged.html">remoteVideoStateChanged</a></td>
<td>远端用户视频状态已变化回调</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngineEventHandler/firstRemoteVideoFrame.html">firstRemoteVideoFrame</a></td>
<td>已显示远端视频首帧回调</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/audioSubscribeStateChanged.html">audioSubscribeStateChanged</a></td>
<td>音频订阅状态改变回调 </td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/videoSubscribeStateChanged.html">videoSubscribeStateChanged</a></td>
<td>视频订阅状态改变回调 </td>
</tr>
</table>

### 数据统计事件

加入频道后，SDK 每隔 2 秒自动触发本组回调。

<table border="1">
<tr>
<th>事件</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/rtcStats.html">RtcStats</a></td>
<td>当前通话统计回调</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/networkQuality.html">networkQuality</a></td>
<td>网络上下行质量报告回调</td>
</tr>
<tr>
<td><a href ="rtc_engine/LocalAudioStats/LocalAudioStats.html">localAudioStats</a></td>
<td>通话中本地音频流统计信息回调</td>
</tr>
<tr>
<td><a href ="rtc_engine/LocalVideoStats-class.html">localVideoStats</a></td>
<td>通话中本地视频流统计信息回调</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/remoteAudioStats.html">remoteAudioStats</a></td>
<td>通话中远端音频流的统计信息回调</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/remoteVideoStats.html">remoteVideoStats</a></td>
<td>通话中远端视频流统计信息回调</td>
</tr>
</table>

### 视频前处理及后处理

<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setBeautyEffectOptions.html">setBeautyEffectOptions</a></td>
<td>设置美颜效果选项</td>
</tr>
</table>

### 多频道管理

<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/create.html">create</a></td>
<td>创建并获取一个 <code>RtcChannel</code> 对象。通过创建多个对象，用户可以同时加入多个频道。</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel-class.html">RtcChannel</a></td>
<td>提供在指定频道内实现实时音视频功能的方法。</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler-class.html">RtcChannelEventHandler</a></td>
<td>提供监听指定频道事件和数据的回调。</td>
</tr>
</table>

### 音乐文件播放及混音

<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/startAudioMixing.html">startAudioMixing</a></td>
<td>开始播放音乐文件</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/stopAudioMixing.html">stopAudioMixing</a></td>
<td>停止播放音乐文件</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/pauseAudioMixing.html">pauseAudioMixing</a></td>
<td>暂停播放音乐文件</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/resumeAudioMixing.html">resumeAudioMixing</a></td>
<td>恢复播放音乐文件</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/adjustAudioMixingVolume.html">adjustAudioMixingVolume</a></td>
<td>调节音乐文件播放音量</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/adjustAudioMixingPlayoutVolume.html">adjustAudioMixingPlayoutVolume</a></td>
<td>调节音乐文件的本地播放音量</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/adjustAudioMixingPublishVolume.html">adjustAudioMixingPublishVolume</a></td>
<td>调节音乐文件的远端播放音量</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setAudioMixingPitch.html">setAudioMixingPitch</a></td>
<td>调整本地播放的音乐文件的音调</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/getAudioMixingPlayoutVolume.html">getAudioMixingPlayoutVolume</a></td>
<td>获取音乐文件的本地播放音量</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/getAudioMixingPublishVolume.html">getAudioMixingPublishVolume</a></td>
<td>获取音乐文件的远端播放音量</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/getAudioMixingDuration.html">getAudioMixingDuration</a></td>
<td>获取音乐文件播放时长</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/getAudioMixingCurrentPosition.html">getAudioMixingCurrentPosition</a></td>
<td>获取音乐文件的播放进度</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setAudioMixingPosition.html">setAudioMixingPosition</a></td>
<td>设置音乐文件的播放位置</td>
</tr>
</table>

<table border="1">
<tr>
<th>事件</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngineEventHandler/audioMixingStateChanged.html">audioMixingStateChanged</a></td>
<td>本地用户的音乐文件播放状态已改变回调</td>
</tr>
</table>

### 音效文件播放管理

<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/getEffectsVolume.html">getEffectsVolume</a></td>
<td>获取播放音效文件音量</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setEffectsVolume.html">setEffectsVolume</a></td>
<td>设置播放音效文件音量</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setVolumeOfEffect.html">setVolumeOfEffect</a></td>
<td>实时调整播放音效文件音量</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/playEffect.html">playEffect</a></td>
<td>播放指定音效文件</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/stopEffect.html">stopEffect</a></td>
<td>停止播放指定音效文件</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/stopAllEffects.html">stopAllEffects</a></td>
<td>停止播放所有音效文件</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/preloadEffect.html">preloadEffect</a></td>
<td>将音效文件加载至内存</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/unloadEffect.html">unloadEffect</a></td>
<td>从内存释放某个预加载的音效文件</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/pauseEffect.html">pauseEffect</a></td>
<td>暂停音效文件播放</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/pauseAllEffects.html">pauseAllEffects</a></td>
<td>暂停所有音效文件播放</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/resumeEffect.html">resumeEffect</a></td>
<td>恢复播放指定音效文件</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/resumeAllEffects.html">resumeAllEffects</a></td>
<td>恢复播放所有音效文件</td>
</tr>
</table>

<table border="1">
<tr>
<th>事件</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngineEventHandler/audioEffectFinished.html">audioEffectFinished</a></td>
<td>本地音效文件播放已结束回调</td>
</tr>
</table>

### 变声与混响

<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setAudioEffectPreset.html">setAudioEffectPreset</a></td>
<td>设置 SDK 预设的人声音效</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setVoiceBeautifierPreset.html">setVoiceBeautifierPreset</a></td>
<td>设置 SDK 预设的美声效果</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setAudioEffectParameters.html">setAudioEffectParameters</a></td>
<td>设置 SDK 预设人声音效的参数</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setLocalVoicePitch.html">setLocalVoicePitch</a></td>
<td>设置本地语音音调</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setLocalVoiceEqualization.html">setLocalVoiceEqualization</a></td>
<td>设置本地语音音效均衡</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setLocalVoiceReverbPreset.html">setLocalVoiceReverb</a></td>
<td>设置本地音效混响</td>
</tr>
</table>

### 听声辩位

<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/enableSoundPositionIndication.html">enableSoundPositionIndication</a></td>
<td>开启/关闭远端用户的语音立体声</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/setRemoteVoicePosition.html">setRemoteVoicePosition</a></td>
<td>设置远端用户的语音位置</td>
</tr>
</table>

### CDN 推流

该组方法仅适用于互动直播。

<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/setLiveTranscoding.html">setLiveTranscoding</a></td>
<td>设置直播转码</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/addPublishStreamUrl.html">addPublishStreamUrl</a></td>
<td>增加旁路推流地址</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/removePublishStreamUrl.html">removePublishStreamUrl</a></td>
<td>删除旁路推流地址</td>
</tr>
</table>

<table border="1">
<tr>
<th>事件</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/rtmpStreamingStateChanged.html">rtmpStreamingStateChanged</a></td>
<td>旁路推流状态改变回调</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/transcodingUpdated.html">transcodingUpdated</a></td>
<td>旁路推流设置已被更新回调</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/rtmpStreamingEvent.html">rtmpStreamingEvent</a></td>
<td>RTMP/RTMPS 推流事件回调 </td>
</tr>
</table>

### 跨频道媒体流转发

<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/startChannelMediaRelay.html">startChannelMediaRelay</a></td>
<td>开始跨频道媒体流转发</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/updateChannelMediaRelay.html">updateChannelMediaRelay</a></td>
<td>更新媒体流转发的频道</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/stopChannelMediaRelay.html">stopChannelMediaRelay</a></td>
<td>停止跨频道媒体流转发</td>
</tr>
</table>

<table border="1">
<tr>
<th>事件</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/channelMediaRelayStateChanged.html">channelMediaRelayStateChanged</a></td>
<td>跨频道媒体流转发状态发生改变回调</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/channelMediaRelayEvent.html">channelMediaRelayEvent</a></td>
<td>跨频道媒体流转发事件回调</td>
</tr>
</table>


### 音量提示

<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/enableAudioVolumeIndication.html">enableAudioVolumeIndication</a></td>
<td>启用说话者音量提示</td>
</tr>
</table>

<table border="1">
<tr>
<th>事件</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/enableAudioVolumeIndication.html">audioVolumeIndication</a></td>
<td>提示频道内谁正在说话及说话者音量的回调</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/activeSpeaker.html">activeSpeaker</a></td>
<td>监测到活跃用户回调</td>
</tr>
</table>

### 人脸检测
<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/enableFaceDetection.html">enableFaceDetection</a></td>
<td>开启/关闭本地人脸检测</td>
</tr>
</table>

<table border="1">
<tr>
<th>事件</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngineEventHandler/facePositionChanged.html">facePositionChanged</a></td>
<td>报告本地人脸检测结果</td>
</tr>
</table>

### 语音播放路由

<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setDefaultAudioRoutetoSpeakerphone.html">setDefaultAudioRoutetoSpeakerphone</a></td>
<td>设置默认的音频播放路由</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setEnableSpeakerphone.html">setEnableSpeakerphone</a></td>
<td>启用/关闭扬声器播放</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/isSpeakerphoneEnabled.html">isSpeakerphoneEnabled</a></td>
<td>查询扬声器启用状态</td>
</tr>
</table>

<table border="1">
<tr>
<th>事件</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngineEventHandler/audioRouteChanged.html">audioRouteChanged</a></td>
<td>语音路由已改变回调</td>
</tr>
</table>

### 耳返控制

<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/enableInEarMonitoring.html">enableInEarMonitoring</a></td>
<td>开启耳返功能</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setInEarMonitoringVolume.html">setInEarMonitoringVolume</a></td>
<td>设置耳返音量</td>
</tr>
</table>

### 视频双流模式

<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/enableDualStreamMode.html">enableDualStreamMode</a></td>
<td>开关视频双流模式</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/setRemoteVideoStreamType.html">setRemoteVideoStreamType</a></td>
<td>设置订阅的视频流类型</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/setRemoteDefaultVideoStreamType.html">setRemoteDefaultVideoStreamType</a></td>
<td>设置默认订阅的视频流类型</td>
</tr>
</table>

### 音视频回退

<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setLocalPublishFallbackOption.html">setLocalPublishFallbackOption</a></td>
<td>设置弱网条件下发布的音视频流回退选项</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setRemoteSubscribeFallbackOption.html">setRemoteSubscribeFallbackOption</a></td>
<td>设置弱网条件下订阅的音视频流回退选项</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/setRemoteUserPriority.html">setRemoteUserPriority</a></td>
<td>设置用户媒体流优先级</td>
</tr>
</table>

<table border="1">
<tr>
<th>事件</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/localPublishFallbackToAudioOnly.html">localPublishFallbackToAudioOnly</a></td>
<td>本地发布流已回退为音频流或恢复为音视频流回调</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/remoteSubscribeFallbackToAudioOnly.html">remoteSubscribeFallbackToAudioOnly</a></td>
<td>远端订阅流已回退为音频流或恢复为音视频流回调</td>
</tr>
</table>

### 通话前网络测试

<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/startEchoTest.html">startEchoTest</a></td>
<td>开始语音通话回路测试</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/stopEchoTest.html">stopEchoTest</a></td>
<td>停止语音通话回路测试</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/enableLastmileTest.html">enableLastmileTest</a></td>
<td>启用网络测试</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/disableLastmileTest.html">disableLastmileTest</a></td>
<td>关闭网络测试</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/startLastmileProbeTest.html">startLastmileProbeTest</a></td>
<td>开始通话前网络质量探测</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/stopLastmileProbeTest.html">stopLastmileProbeTest</a></td>
<td>停止通话前网络质量探测</td>
</tr>
</table>

<table border="1">
<tr>
<th>事件</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngineEventHandler/lastmileQuality.html">lastmileQuality</a></td>
<td>本地网络质量报告回调</td>
</tr>
<tr>
<td><a href ="rtc_engine/LastmileProbeResult/LastmileProbeResult.html">lastmileProbeResult</a></td>
<td>本地网络上下行 Last mile 质量报告回调</td>
</tr>
</table>

### 媒体附属信息

该组方法仅适用于互动直播。

<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/registerMediaMetadataObserver.html">registerMediaMetadataObserver</a></td>
<td>注册媒体 Metadata 观测器</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/setMaxMetadataSize.html">setMaxMetadataSize</a></td>
<td>设置 Metadata 的最大数据大小</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/sendMetadata.html">sendMetadata</a></td>
<td>发送 Metadata</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/unregisterMediaMetadataObserver.html">unregisterMediaMetadataObserver</a></td>
<td>注销媒体 Metadata 观测器</td>
</tr>
</table>

### 直播水印

该组方法仅适用于互动直播。

<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/addVideoWatermark.html">addVideoWatermark</a></td>
<td>添加本地视频水印</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/clearVideoWatermarks.html">clearVideoWatermarks</a></td>
<td>删除已添加的视频水印</td>
</tr>
</table>

### 加密

<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/enableEncryption.html">enableEncryption</a></td>
<td>开启/关闭内置加密 </td>
</tr>
</table>

### 音频录制

<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/startAudioRecording.html">startAudioRecording</a></td>
<td>开始客户端录音</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/stopAudioRecording.html">stopAudioRecording</a></td>
<td>停止客户端录音</td>
</tr>
</table>

### 直播输入在线媒体流

该组方法仅适用于互动直播。

<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/addInjectStreamUrl.html">addInjectStreamUrl</a></td>
<td>输入在线媒体流</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/removeInjectStreamUrl.html">removeInjectStreamUrl</a></td>
<td>删除输入的在线媒体流</td>
</tr>
</table>

<table border="1">
<tr>
<th>事件</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/streamInjectedStatus.html">streamInjectedStatus</a></td>
<td>输入在线媒体流状态回调</td>
</tr>
</table>

### 摄像头控制

<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/switchCamera.html">switchCamera</a></td>
<td>切换前置/后置摄像头</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/isCameraZoomSupported.html">isCameraZoomSupported</a></td>
<td>检测设备是否支持摄像头缩放功能</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/isCameraTorchSupported.html">isCameraTorchSupported</a></td>
<td>检测设备是否支持闪光灯常开</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/isCameraFocusSupported.html">isCameraFocusSupported</a></td>
<td>检测设备是否支持手动对焦功能</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/isCameraExposurePositionSupported.html">isCameraExposurePositionSupported</a></td>
<td>检测设备是否支持手动曝光功能</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/isCameraAutoFocusFaceModeSupported.html">isCameraAutoFocusFaceModeSupported</a></td>
<td>检测设备是否支持人脸对焦功能</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setCameraZoomFactor.html">setCameraZoomFactor</a></td>
<td>设置摄像头缩放比例</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/getCameraMaxZoomFactor.html">getCameraMaxZoomFactor</a></td>
<td>获取摄像头支持最大缩放比例</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setCameraFocusPositionInPreview.html">setCameraFocusPositionInPreview</a></td>
<td>设置手动对焦位置，并触发对焦</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setCameraExposurePosition.html">setCameraExposurePosition</a></td>
<td>设置手动曝光位置</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setCameraTorchOn.html">setCameraTorchOn</a></td>
<td>设置是否打开闪光灯</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setCameraAutoFocusFaceModeEnabled.html">setCameraAutoFocusFaceModeEnabled</a></td>
<td>设置是否开启人脸对焦功能</td>
</tr>
</table>

<table border="1">
<tr>
<th>事件</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngineEventHandler/cameraFocusAreaChanged.html">cameraFocusAreaChanged</a></td>
<td>摄像头对焦区域已改变回调</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngineEventHandler/cameraExposureAreaChanged.html">cameraExposureAreaChanged</a></td>
<td>摄像头曝光区域已改变回调</td>
</tr>
</table>


### 流消息

<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/createDataStream.html">createDataStream</a></td>
<td>创建数据流</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/sendStreamMessage.html">sendStreamMessage</a></td>
<td>发送数据流</td>
</tr>
</table>

<table border="1">
<tr>
<th>事件</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/streamMessage.html">streamMessage</a></td>
<td>接收到对方数据流消息的回调</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/streamMessageError.html">streamMessageError</a></td>
<td>接收对方数据流消息发生错误的回调</td>
</tr>
</table>

### 其他视频控制

<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setCameraCapturerConfiguration.html">setCameraCapturerConfiguration</a></td>
<td>设置摄像头的采集偏好</td>
</tr>
</table>


### 其他方法

<table border="1">
<tr>
<th>方法</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/getCallId.html">getCallId</a></td>
<td>获取通话 ID</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/rate.html">rate</a></td>
<td>给通话评分</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/complain.html">complain</a></td>
<td>投诉通话质量</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setLogFile.html">setLogFile</a></td>
<td>设置日志文件</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setLogFilter.html">setLogFilter</a></td>
<td>设置日志输出等级</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngine/setLogFileSize.html">setLogFileSize</a></td>
<td>设置日志文件大小</td>
</tr>
</table>

### 其他事件

<table border="1">
<tr>
<th>事件</th>
<th>描述</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/warning.html">warning</a></td>
<td>发生警告回调</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/error.html">error</a></td>
<td>发生错误回调</td>
</tr>
<tr>
<td><a href ="rtc_engine/RtcEngineEventHandler/apiCallExecuted.html">apiCallExecuted</a></td>
<td>API 方法已执行回调</td>
</tr>
</table>
