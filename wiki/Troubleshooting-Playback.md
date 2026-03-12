# Troubleshooting Video Playback

## How Playback Works

Presto Player uses Stencil.js web components to render a custom player UI on top of the native video provider (YouTube IFrame API, Vimeo Player SDK, HTML5 video, or HLS.js). The player loads when the page renders, initializes the appropriate provider, and displays a poster image until the user clicks play.

## Quick Diagnosis

Ask the customer:
1. What video source are they using (YouTube, Vimeo, self-hosted, HLS)?
2. What browser and device?
3. What error message or behavior do they see?
4. Does the video work when accessed directly (e.g., on youtube.com)?
5. Is this happening on all videos or just one?
6. Did it work before? What changed?

---

## Common Issues

### Video Not Playing at All

**Symptoms**: Player loads but clicking play does nothing, or player doesn't appear.

**Common causes**:
- JavaScript error blocking player initialization
- Ad blocker or security plugin blocking video provider scripts
- Video source URL is broken or inaccessible
- Plugin conflict (another video plugin or optimization plugin)
- Theme CSS hiding the player element

**What to check**:
1. Open browser console (F12) -- any JavaScript errors?
2. Does the video work in incognito mode?
3. Is the video source URL accessible directly?
4. Disable other plugins temporarily to test
5. Try with a default WordPress theme (Twenty Twenty-Four)

**Fix**: Clear cache. Disable ad blockers. Check for JS conflicts. Verify video source URL.

---

### Player Shows But No Video Loads

**Symptoms**: Player controls visible but video area is black or empty.

**Common causes**:
- Video deleted or made private on the provider
- Embedding disabled on YouTube/Vimeo
- CORS/domain restrictions on Vimeo
- Self-hosted video file missing or moved

**What to check**:
1. Can you access the video on its original platform?
2. Is embedding enabled for the video?
3. For Vimeo: are domain restrictions set? Is this domain allowed?
4. For self-hosted: does the file URL return 200 when accessed directly?

**Fix**: Verify video accessibility on the source platform. Update domain allowlists. Re-upload missing files.

---

### Audio Plays But No Video

**Symptoms**: Sound works but the video is black.

**Common causes**:
- Unsupported video codec (HEVC/H.265 in non-Safari browsers)
- Video container is correct (MP4) but codec is incompatible
- GPU acceleration issue in browser

**What to check**:
1. What video codec is the file? (Use MediaInfo or browser dev tools)
2. Does it play in other browsers?
3. Try disabling hardware acceleration in browser

**Fix**: Re-encode to H.264 codec in MP4 container. This is universally supported.

---

### Video Buffering/Stuttering

**Symptoms**: Video loads but stutters, pauses to buffer, or has poor quality.

**Common causes**:
- Server bandwidth insufficient for the video file size
- No CDN configured for self-hosted videos
- Large video file not optimized for streaming
- Shared hosting with resource limits

**What to check**:
1. What is the video file size?
2. Is a CDN being used?
3. What hosting plan/provider?
4. Does the issue occur on all video types or just self-hosted?

**Fix**: Compress the video. Use a CDN (Bunny CDN integration). Consider HLS streaming for large files. Upgrade hosting if on shared plan.

---

### Player Controls Not Responding

**Symptoms**: Player visible, video may play, but controls (play, pause, volume, etc.) don't work.

**Common causes**:
- CSS conflict (z-index issue hiding controls)
- JavaScript error breaking event handlers
- Theme or page builder overlay on top of player

**What to check**:
1. Inspect the player element in browser dev tools -- are controls present in DOM?
2. Is there a transparent overlay on top of the player?
3. Any JavaScript errors in console?
4. Does it work with a default theme?

**Fix**: Check z-index conflicts. Remove overlapping elements. Fix JS errors.

---

## Escalation Criteria

Escalate to engineering if:
- Stencil.js web components fail to render consistently
- Player works for some video types but not others with identical settings
- AJAX analytics endpoint causes 500 errors
- Video streaming (Streamer service) returns incomplete data
