The Agora Flutter SDK wraps the Agora RTC SDKs for Android and iOS, with which you can quickly implement real-time communication functionality in Android and iOS apps developed using the Flutter framework.



- The <a href="agora_rtc_engine/RtcEngine-class.html">RtcEngine</a> class provides the main methods that can be invoked by your application.
- The <a href ="agora_rtc_engine/RtcEngineEventHandler-class.html"> RtcEngineEventHandler</a> class enables callbacks to your application.
- The <a href ="rtc_channel/RtcChannel-class.html">RtcChannel</a> class provides methods that enable real-time communications
in a specified channel. By creating multiple RtcChannel instances, users can join multiple channels.
- The <a href ="rtc_channel/RtcChannelEventHandler-class.html">RtcChannelEventHandler</a> class provides callbacks that report events and statistics of a specified channel.

### Core management

<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href="agora_rtc_engine/RtcEngine/create.html">create</a></td>
<td>Creates an <code>RtcEngine</code> instance.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/createWithConfig.html">createWithConfig</a></a></td>
<td>Creates an <code>RtcEngine</code> instance and specifies the connection area.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/createWithContext.html">createWithContext</a></a></td>
<td>Creates an <code>RtcEngine</code> instance and specifies one or multiple connection areas.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/destroy.html">destroy</a></td>
<td>Destroys the <code>RtcEngine</code> instance.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setChannelProfile.html">setChannelProfile</a></td>
<td>Sets the channel profile of the Agora RtcEngine.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/setClientRole.html">setClientRole</a></td>
<td>Sets the role of a user in a live interactive streaming.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/joinChannel.html">joinChannel</a></td>
<td>Allows a user to join a channel.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/switchChannel.html">switchChannel</a></td>
<td>Switches to a different channel (<code>LiveBroadcasting</code> profile only).</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/leaveChannel.html">leaveChannel</a></td>
<td>Allows a user to leave a channel.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/destroy.html">destroy</a></td>
<td>Destroys the <code>RtcChannel</code> instance.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/renewToken.html">renewToken</a></td>
<td>Renews the token.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/getConnectionState.html">getConnectionState</a></td>
<td>Gets the connection state of the app.</td>
</tr>
</table>

### Core events

<table border="1">
<tr>
<th>Event</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/connectionStateChanged.html">connectionStateChanged</a></td>
<td>Occurs when the network connection state changes.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/joinChannelSuccess.html">joinChannelSuccess</a></td>
<td>Occurs when a user joins a channel.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/rejoinChannelSuccess.html">rejoinChannelSuccess</a></td>
<td>Occurs when a user rejoins a channel.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/leaveChannel.html">leaveChannel</a></td>
<td>Occurs when a user leaves a channel.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/clientRoleChanged.html">clientRoleChanged</a></td>
<td>Occurs when the user role in a live streaming changes.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/userJoined.html">userJoined</a></td>
<td>Occurs when a remote user joins a channel.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/userOffline.html">userOffline</a></td>
<td>Occurs when a remote user leaves a channel or goes offline.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngineEventHandler/networkTypeChanged.html">networkTypeChanged</a></td>
<td>Occurs when the network type changes.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/connectionLost.html">connectionLost</a></td>
<td>Occurs when the SDK loses connection to the server.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/tokenPrivilegeWillExpire.html">tokenPrivilegeWillExpire</a></td>
<td>Occurs when the token expires in 30 seconds.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/requestToken.html">requestToken</a></td>
<td>Occurs when the token expires.</td>
</tr>
</table>


### Audio management

<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/enableAudio.html">enableAudio</a></td>
<td>Enables the audio module.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/disableAudio.html">disableAudio</a></td>
<td>Disables the audio module.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setAudioProfile.html">setAudioProfile</a></td>
<td>Sets the audio parameters and application scenarios.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/adjustRecordingSignalVolume.html">adjustRecordingSignalVolume</a></td>
<td>Adjusts the recording volume.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/adjustUserPlaybackSignalVolume.html">adjustUserPlaybackSignalVolume</a></td>
<td>Adjusts the playback volume of a specified remote user.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/adjustPlaybackSignalVolume.html">adjustPlaybackSignalVolume</a></td>
<td>Adjusts the playback volume of all remote users.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/enableLocalAudio.html">enableLocalAudio</a></td>
<td>Enables/disables the local audio capture.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/muteLocalAudioStream.html">muteLocalAudioStream</a></td>
<td>Stops/Resumes sending the local audio stream.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/muteRemoteAudioStream.html">muteRemoteAudioStream</a></td>
<td>Stops/Resumes receiving a specified remote audio stream.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/muteAllRemoteAudioStreams.html">muteAllRemoteAudioStreams</a></td>
<td>Stops/Resumes receiving all remote audio streams.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/setDefaultMuteAllRemoteAudioStreams.html">setDefaultMuteAllRemoteAudioStreams</a></td>
<td>Sets whether to receive all remote audio streams by default.</td>
</tr>
</table>


### Video management

<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/enableVideo.html">enableVideo</a></td>
<td>Enables the video module.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/disableVideo.html">disableVideo</a></td>
<td>Disables the video module.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setVideoEncoderConfiguration.html">setVideoEncoderConfiguration</a></td>
<td>Sets the video encoder configuration.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/startPreview.html">startPreview</a></td>
<td>Starts the local video preview.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/stopPreview.html">stopPreview</a></td>
<td>Stops the local video preview.</td>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/enableLocalVideo.html">enableLocalVideo</a></td>
<td>Enables/Disables the local video capture.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/muteLocalVideoStream.html">muteLocalVideoStream</a></td>
<td>Stops/Resumes sending the local video stream.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/muteRemoteVideoStream.html">muteRemoteVideoStream</a></td>
<td>Stops/Resumes receiving a specified remote video stream.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/muteAllRemoteVideoStreams.html">muteAllRemoteVideoStreams</a></td>
<td>Stops/Resumes receiving all remote video streams.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/setDefaultMuteAllRemoteVideoStreams.html">setDefaultMuteAllRemoteVideoStreams</a></td>
<td>Sets whether to receive all remote video streams by default.</td>
</tr>
</table>

### Local media events

<table border="1">
<tr>
<th>Event</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngineEventHandler/localAudioStateChanged.html">localAudioStateChanged</a></td>
<td>Occurs when the local audio state changes.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngineEventHandler/localVideoStateChanged.html">localVideoStateChanged</a></td>
<td>Occurs when the local video state changes.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngineEventHandler/firstLocalAudioFramePublished.html">firstLocalAudioFramePublished</a></td>
<td>Occurs when the first audio frame is published. </td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngineEventHandler/firstLocalVideoFramePublished.html">firstLocalVideoFramePublished</a></td>
<td>Occurs when the first video frame is published.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngineEventHandler/firstLocalVideoFrame.html">firstLocalVideoFrame</a></td>
<td>Occurs when the first local video frame is rendered.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/audioPublishStateChanged.html">audioPublishStateChanged</a></td>
<td>Occurs when the audio publishing state changes. </td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/videoPublishStateChanged.html">videoPublishStateChanged</a></td>
<td>Occurs when the video publishing state changes.</td>
</tr>
</table>

### Remote media events

<table border="1">
<tr>
<th>Event</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/remoteAudioStateChanged.html">remoteAudioStateChanged</a></td>
<td>Occurs when the remote audio state changes.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/remoteVideoStateChanged.html">remoteVideoStateChanged</a></td>
<td>Occurs when the remote video state changes.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngineEventHandler/firstRemoteVideoFrame.html">firstRemoteVideoFrame</a></td>
<td>Occurs when the first remote video frame is rendered.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/audioSubscribeStateChanged.html">audioSubscribeStateChanged</a></td>
<td>Occurs when the audio subscribing state changes. </td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/videoSubscribeStateChanged.html">videoSubscribeStateChanged</a></td>
<td>Occurs when the video subscribe state changes. </td>
</tr>
</table>

### Statistics events

After joining a channel, SDK triggers this group of callbacks once every two seconds.

<table border="1">
<tr>
<th>Event</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/rtcStats.html">RtcStats</a></td>
<td>Reports the statistics of RtcEngine.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/networkQuality.html">networkQuality</a></td>
<td>Reports the network quality of each user.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/LocalAudioStats/LocalAudioStats.html">localAudioStats</a></td>
<td>Reports the statistics of the local audio stream.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/LocalVideoStats-class.html">localVideoStats</a></td>
<td>Reports the statistics of the uploading local video stream.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/remoteAudioStats.html">remoteAudioStats</a></td>
<td>Reports the statistics of the audio stream from each remote user/host.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/remoteVideoStats.html">remoteVideoStats</a></td>
<td>Reports the statistics of the video stream from each remote user/host.</td>
</tr>
</table>

### Video pre-process and post-process

<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setBeautyEffectOptions.html">setBeautyEffectOptions</a></td>
<td>Sets the image enhancement options.</td>
</tr>
</table>

### Multi-channel management

<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/create.html">create</a></td>
<td>Initializes and gets an <code>RtcChannel</code> instance. To join multiple channels,
create multiple <code>RtcChannel</code> objects.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel-class.html">RtcChannel</a></td>
<td>Provides methods that enable real-time communications in a specified channel.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler-class.html">RtcChannelEventHandler</a></td>
<td>Provides callbacks that report events and statistics in a specified channel.</td>
</tr>
</table>


### Audio file playback and mixing

<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/startAudioMixing.html">startAudioMixing</a></td>
<td>Starts playing and mixing the music file.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/stopAudioMixing.html">stopAudioMixing</a></td>
<td>Stops playing or mixing the music file.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/pauseAudioMixing.html">pauseAudioMixing</a></td>
<td>Pauses playing and mixing the music file.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/resumeAudioMixing.html">resumeAudioMixing</a></td>
<td>Resumes playing and mixing the music file.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/adjustAudioMixingVolume.html">adjustAudioMixingVolume</a></td>
<td>Adjusts the volume of audio mixing.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/adjustAudioMixingPlayoutVolume.html">adjustAudioMixingPlayoutVolume</a></td>
<td>Adjusts the volume of audio mixing for local playback.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/adjustAudioMixingPublishVolume.html">adjustAudioMixingPublishVolume</a></td>
<td>Adjusts the volume of audio mixing for remote playback.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setAudioMixingPitch.html">setAudioMixingPitch</a></td>
<td>Sets the pitch of the local music file.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/getAudioMixingPlayoutVolume.html">getAudioMixingPlayoutVolume</a></td>
<td>Gets the volume of audio mixing for local playback.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/getAudioMixingPublishVolume.html">getAudioMixingPublishVolume</a></td>
<td>Gets the volume of audio mixing for remote playback.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/getAudioMixingDuration.html">getAudioMixingDuration</a></td>
<td>Gets the duration (ms) of the music file.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/getAudioMixingCurrentPosition.html">getAudioMixingCurrentPosition</a></td>
<td>Gets the playback position (ms) of the music file.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setAudioMixingPosition.html">setAudioMixingPosition</a></td>
<td>Sets the playback starting position (ms) of the music file.</td>
</tr>
</table>

<table border="1">
<tr>
<th>Event</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngineEventHandler/audioMixingStateChanged.html">audioMixingStateChanged</a></td>
<td>Occurs when the state of the local user's audio mixing file changes.</td>
</tr>
</table>

### Audio effect playback

<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/getEffectsVolume.html">getEffectsVolume</a></td>
<td>Gets the volume of the audio effects.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setEffectsVolume.html">setEffectsVolume</a></td>
<td>Sets the volume of the audio effects.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setVolumeOfEffect.html">setVolumeOfEffect</a></td>
<td>Sets the volume of a specified audio effect.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/playEffect.html">playEffect</a></td>
<td>Plays a specified audio effect.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setEffectPosition.html">setEffectPosition</a></td>
<td>Sets the playback position of an audio effect file.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/getEffectDuration.html">getEffectDuration</a></td>
<td>Gets the duration of the audio effect file.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/getEffectCurrentPosition.html">getEffectCurrentPosition</a></td>
<td>Gets the playback position of the audio effect file.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/stopEffect.html">stopEffect</a></td>
<td>Stops playing a specified audio effect.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/stopAllEffects.html">stopAllEffects</a></td>
<td>Stops playing all audio effects.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/preloadEffect.html">preloadEffect</a></td>
<td>Preloads a specified audio effect file into the memory.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/unloadEffect.html">unloadEffect</a></td>
<td>Releases a specified preloaded audio effect from the memory.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/pauseEffect.html">pauseEffect</a></td>
<td>Pauses a specified audio effect.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/pauseAllEffects.html">pauseAllEffects</a></td>
<td>Pauses all audio effects.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/resumeEffect.html">resumeEffect</a></td>
<td>Resumes playing a specified audio effect.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/resumeAllEffects.html">resumeAllEffects</a></td>
<td>Resumes playing all audio effects.</td>
</tr>
</table>

<table border="1">
<tr>
<th>Event</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngineEventHandler/audioEffectFinished.html">audioEffectFinished</a></td>
<td>Occurs when the audio effect file playback finishes.</td>
</tr>
</table>


### Virtual metronome

<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/startRhythmPlayer.html">startRhythmPlayer</a></td>
<td>Enables the virtual metronome.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/stopRhythmPlayer.html">stopRhythmPlayer</a></td>
<td>Disables the virtual metronome.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/configRhythmPlayer.html">configRhythmPlayer</a></td>
<td>Configures the virtual metronome.</td>
</tr>
</table>

### Voice Effect

<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setAudioEffectPreset.html">setAudioEffectPreset</a></td>
<td>Sets an SDK preset audio effect.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setVoiceBeautifierPreset.html">setVoiceBeautifierPreset</a></td>
<td>Sets an SDK preset voice beautifier effect.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setVoiceBeautifierParameters.html">setVoiceBeautifierParameters</a></td>
<td>Sets parameters for SDK preset voice beautifier effects.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setAudioEffectParameters.html">setAudioEffectParameters</a></td>
<td>Sets parameters for SDK preset audio effects.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setLocalVoicePitch.html">setLocalVoicePitch</a></td>
<td>Sets the voice pitch of the local speaker.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setLocalVoiceEqualization.html">setLocalVoiceEqualization</a></td>
<td>Sets the local voice equalization effect.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setLocalVoiceReverbPreset.html">setLocalVoiceReverb</a></td>
<td>Sets the local voice reverberation.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setVoiceConversionPreset.html">setVoiceConversionPreset</a></td>
<td>Sets an SDK preset voice conversion effect.</td>
</tr>
</table>

### Sound position indication

<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/enableSoundPositionIndication.html">enableSoundPositionIndication</a></td>
<td>Enables/Disables stereo panning for remote users.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/setRemoteVoicePosition.html">setRemoteVoicePosition</a></td>
<td>Sets the sound position and gain of a remote user.</td>
</tr>
</table>

### CDN publisher

This group of methods apply to <code>LiveBroadcasting</code> profile only.

<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/setLiveTranscoding.html">setLiveTranscoding</a></td>
<td>Sets the video layout and audio settings for CDN live.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/addPublishStreamUrl.html">addPublishStreamUrl</a></td>
<td>Publishes the local stream to the CDN.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/removePublishStreamUrl.html">removePublishStreamUrl</a></td>
<td>Removes an RTMP or RTMPS stream from the CDN.</td>
</tr>
</table>

<table border="1">
<tr>
<th>Event</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/rtmpStreamingStateChanged.html">rtmpStreamingStateChanged</a></td>
<td>Occurs when the state of the RTMP or RTMPS streaming changes.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/transcodingUpdated.html">transcodingUpdated</a></td>
<td>Occurs when the publisher's transcoding settings are updated.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/rtmpStreamingEvent.html">rtmpStreamingEvent</a></td>
<td>Reports events during the RTMP or RTMPS streaming.</td>
</tr>
</table>

### Channel Media Relay

<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/startChannelMediaRelay.html">startChannelMediaRelay</a></td>
<td>Starts to relay media streams across channels.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/updateChannelMediaRelay.html">updateChannelMediaRelay</a></td>
<td>Updates the channels for media stream relay.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/stopChannelMediaRelay.html">stopChannelMediaRelay</a></td>
<td>Stops the media stream relay.</td>
</tr>
</table>

<table border="1">
<tr>
<th>Event</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/channelMediaRelayStateChanged.html">channelMediaRelayStateChanged</a></td>
<td>Occurs when the state of the media stream relay changes.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/channelMediaRelayEvent.html">channelMediaRelayEvent</a></td>
<td>Reports events during the media stream relay.</td>
</tr>
</table>


### Audio volume indication

<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/enableAudioVolumeIndication.html">enableAudioVolumeIndication</a></td>
<td>Enables the <a href ="agora_rtc_engine/RtcEngine/enableAudioVolumeIndication.html">audioVolumeIndication</a> callback at a set time interval to report on which users are speaking and the speakers' volume.</td>
</tr>
</table>

<table border="1">
<tr>
<th>Event</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/enableAudioVolumeIndication.html">audioVolumeIndication</a></td>
<td>Reports which users are speaking and the speakers' volume, and whether the local user is speaking.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/activeSpeaker.html">activeSpeaker</a></td>
<td>Reports which user is the loudest speaker.</td>
</tr>
</table>

### Face detection
<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/enableFaceDetection.html">enableFaceDetection</a></td>
<td>Enables/Disables face detection for the local user.</td>
</tr>
</table>

<table border="1">
<tr>
<th>Event</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngineEventHandler/facePositionChanged.html">facePositionChanged</a></td>
<td>Reports the face detection result of the local user.</td>
</tr>
</table>

### Audio routing control

<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setDefaultAudioRoutetoSpeakerphone.html">setDefaultAudioRoutetoSpeakerphone</a></td>
<td>Sets the default audio playback route.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setEnableSpeakerphone.html">setEnableSpeakerphone</a></td>
<td>Enables/Disables the audio playback route to the speakerphone.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/isSpeakerphoneEnabled.html">isSpeakerphoneEnabled</a></td>
<td>Checks whether the speakerphone is enabled.</td>
</tr>
</table>

<table border="1">
<tr>
<th>Event</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngineEventHandler/audioRouteChanged.html">audioRouteChanged</a></td>
<td>Occurs when the local audio playback route changes.</td>
</tr>
</table>

### In-ear monitoring

<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/enableInEarMonitoring.html">enableInEarMonitoring</a></td>
<td>Enables in-ear monitoring.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setInEarMonitoringVolume.html">setInEarMonitoringVolume</a></td>
<td>Sets the volume of the in-ear monitor.</td>
</tr>
</table>

### Dual video stream mode

<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/enableDualStreamMode.html">enableDualStreamMode</a></td>
<td>Enables/disables dual video stream mode.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/setRemoteVideoStreamType.html">setRemoteVideoStreamType</a></td>
<td>Sets the video stream type of the remotely subscribed video stream.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/setRemoteDefaultVideoStreamType.html">setRemoteDefaultVideoStreamType</a></td>
<td>Sets the default video stream type of the remotely subscribed video stream.</td>
</tr>
</table>

### Stream fallback

<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setLocalPublishFallbackOption.html">setLocalPublishFallbackOption</a></td>
<td>Sets the fallback option for the locally published video stream under unreliable network conditions.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setRemoteSubscribeFallbackOption.html">setRemoteSubscribeFallbackOption</a></td>
<td>Sets the fallback option for the remotely subscribed video stream under unreliable network conditions.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/setRemoteUserPriority.html">setRemoteUserPriority</a></td>
<td>Sets the priority of a remote user's stream.</td>
</tr>
</table>

<table border="1">
<tr>
<th>Event</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/localPublishFallbackToAudioOnly.html">localPublishFallbackToAudioOnly</a></td>
<td>Occurs when the locally published video stream falls back to audio only due to poor network conditions or switches back to the video stream after the network conditions improve.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/remoteSubscribeFallbackToAudioOnly.html">remoteSubscribeFallbackToAudioOnly</a></td>
<td>Occurs when the remotely subscribed video stream falls back to audio ly due to poor network conditions or switches back to the video stream after the network conditions improve.</td>
</tr>
</table>

### Pre-call network test

<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/startEchoTest.html">startEchoTest</a></td>
<td>Starts an audio call test.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/stopEchoTest.html">stopEchoTest</a></td>
<td>Stops the audio call test.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/enableLastmileTest.html">enableLastmileTest</a></td>
<td>Enables the network connection quality test.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/disableLastmileTest.html">disableLastmileTest</a></td>
<td>Disables the network connection quality test.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/startLastmileProbeTest.html">startLastmileProbeTest</a></td>
<td>Starts the last-mile probe test.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/stopLastmileProbeTest.html">stopLastmileProbeTest</a></td>
<td>Stops the last-mile probe test.</td>
</tr>
</table>

<table border="1">
<tr>
<th>Event</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngineEventHandler/lastmileQuality.html">lastmileQuality</a></td>
<td>Reports the last-mile network quality of the local user before the user joins a channel.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/LastmileProbeResult/LastmileProbeResult.html">lastmileProbeResult</a></td>
<td>Reports the last-mile network probe result.</td>
</tr>
</table>

### Media metadata

This group of methods apply to <code>LiveBroadcasting</code> profile only.

<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/registerMediaMetadataObserver.html">registerMediaMetadataObserver</a></td>
<td>Registers a media metadata observer object.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/setMaxMetadataSize.html">setMaxMetadataSize</a></td>
<td>Sets the maximum size of the metadata.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/sendMetadata.html">sendMetadata</a></td>
<td>Sends the metadata.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/unregisterMediaMetadataObserver.html">unregisterMediaMetadataObserver</a></td>
<td>Unregisters the metadata observer.</td>
</tr>
</table>

### Watermark

This group of methods apply to <code>LiveBroadcasting</code> profile only.

<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/addVideoWatermark.html">addVideoWatermark</a></td>
<td>Adds a watermark image to the local video.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/clearVideoWatermarks.html">clearVideoWatermarks</a></td>
<td>Removes the added watermark image from the video stream.</td>
</tr>
</table>

### Encryption

<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/enableEncryption.html">enableEncryption</a></td>
<td>Enables/Disables the built-in encryption.</td>
</tr>
</table>

### Audio recorder

<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/startAudioRecordingWithConfig.html">startAudioRecordingWithConfig</a></td>
<td>Starts an audio recording on the client.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/stopAudioRecording.html">stopAudioRecording</a></td>
<td>Stops the audio recording on the client.</td>
</tr>
</table>


### Camera control

<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/switchCamera.html">switchCamera</a></td>
<td>Switches between front and rear cameras.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/isCameraZoomSupported.html">isCameraZoomSupported</a></td>
<td>Checks whether the camera zoom function is supported.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/isCameraTorchSupported.html">isCameraTorchSupported</a></td>
<td>Checks whether the camera flash function is supported.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/isCameraFocusSupported.html">isCameraFocusSupported</a></td>
<td>Checks whether the camera manual focus function is supported.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/isCameraExposurePositionSupported.html">isCameraExposurePositionSupported</a></td>
<td>Checks whether the camera exposure function is supported.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/isCameraAutoFocusFaceModeSupported.html">isCameraAutoFocusFaceModeSupported</a></td>
<td>Checks whether the camera face auto-focus function is supported.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setCameraZoomFactor.html">setCameraZoomFactor</a></td>
<td>Sets the camera zoom ratio.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/getCameraMaxZoomFactor.html">getCameraMaxZoomFactor</a></td>
<td>Gets the maximum zoom ratio of the camera.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setCameraFocusPositionInPreview.html">setCameraFocusPositionInPreview</a></td>
<td>Sets the camera manual focus position.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setCameraExposurePosition.html">setCameraExposurePosition</a></td>
<td>Sets the camera exposure position.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setCameraTorchOn.html">setCameraTorchOn</a></td>
<td>Enables the camera flash function.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setCameraAutoFocusFaceModeEnabled.html">setCameraAutoFocusFaceModeEnabled</a></td>
<td>Enables the camera auto-face focus function.</td>
</tr>
</table>

<table border="1">
<tr>
<th>Event</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngineEventHandler/cameraFocusAreaChanged.html">cameraFocusAreaChanged</a></td>
<td>Occurs when the camera focus area changes.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngineEventHandler/cameraExposureAreaChanged.html">cameraExposureAreaChanged</a></td>
<td>Occurs when the camera exposure area changes.</td>
</tr>
</table>


### Stream message

<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/createDataStreamWithConfig.html">createDataStreamWithConfig</a></td>
<td>Creates a data stream.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/sendStreamMessage.html">sendStreamMessage</a></td>
<td>Sends data stream messages.</td>
</tr>
</table>

<table border="1">
<tr>
<th>Event</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/streamMessage.html">streamMessage</a></td>
<td>Occurs when the local user receives a remote data stream within five seconds.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/streamMessageError.html">streamMessageError</a></td>
<td>Occurs when the local user fails to receive the remote data stream.</td>
</tr>
</table>

### Miscellaneous video control

<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setCameraCapturerConfiguration.html">setCameraCapturerConfiguration</a></td>
<td>Sets the camera capturer configuration.</td>
</tr>
</table>


### Miscellaneous methods

<table border="1">
<tr>
<th>Method</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/setCloudProxy.html">setCloudProxy</a></td>
<td>Sets the Agora cloud proxy service.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/enableDeepLearningDenoise.html">enableDeepLearningDenoise</a></td>
<td>Enables/Disables deep-learning noise reduction.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannel/getCallId.html">getCallId</a></td>
<td>Gets the current call ID.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/rate.html">rate</a></td>
<td>Allows a user to rate a call after the call ends.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/complain.html">complain</a></td>
<td>Allows a user to complain about the call quality after a call ends.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/getSdkVersion.html">getSdkVersion</a></td>
<td>Gets the Agora SDK version.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngine/getErrorDescription.html">getErrorDescription</a></td>
<td>Retrieves the description of a warning or error code.</td>
</tr>
</table>

### Miscellaneous events

<table border="1">
<tr>
<th>Event</th>
<th>Description</th>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/warning.html">warning</a></td>
<td>Occurs when a warning occurs.</td>
</tr>
<tr>
<td><a href ="rtc_channel/RtcChannelEventHandler/error.html">error</a></td>
<td>Occurs when an error occurs.</td>
</tr>
<tr>
<td><a href ="agora_rtc_engine/RtcEngineEventHandler/apiCallExecuted.html">apiCallExecuted</a></td>
<td>Occurs when an API method is executed.</td>
</tr>
</table>