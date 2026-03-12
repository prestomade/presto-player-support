# Common Error Codes & Messages

## REST API Errors

All Presto Player REST endpoints require `upload_files` capability (Author role or higher).

| HTTP Code | Meaning | Common Cause | Resolution |
|-----------|---------|--------------|------------|
| 200 | Success | Request completed | No action needed |
| 400 | Bad Request | Missing/invalid parameters | Check request payload |
| 401 | Unauthorized | Not logged in | Log in and retry |
| 403 | Forbidden | User lacks `upload_files` capability | Need Author role or higher |
| 404 | Not Found | Wrong endpoint URL | Check API namespace `presto-player/v1` |
| 500 | Server Error | PHP error | Check `debug.log` |

## Video Playback Errors

| Symptom | Context | Likely Cause | Resolution |
|---------|---------|-------------|------------|
| "Video unavailable" | YouTube | Video is private, deleted, or region-restricted | Check video URL and privacy settings on YouTube |
| Black screen, no play button | YouTube | YouTube IFrame API blocked | Check for ad blockers, security plugins blocking scripts |
| "This video does not exist" | Vimeo | Invalid Vimeo video ID | Verify Vimeo URL and video accessibility |
| "Video cannot be played" | Vimeo | Vimeo privacy/domain restriction | Check Vimeo video privacy settings and allowed domains |
| No video, just audio | Self-hosted | Unsupported video codec (e.g., HEVC) | Re-encode to H.264/MP4 |
| Video won't load | Self-hosted | File too large or server timeout | Check PHP upload limits, server timeout settings |
| Buffering/stuttering | Self-hosted | Server bandwidth insufficient | Consider CDN or Bunny CDN integration |
| HLS stream won't play | HLS | HLS.js not loaded or manifest error | Check for JS errors, verify .m3u8 manifest is accessible |

## Block Editor Errors

| Symptom | Likely Cause | Resolution |
|---------|-------------|------------|
| Block shows "This block contains unexpected content" | Plugin version mismatch after update | Click "Attempt Block Recovery" in editor |
| Block settings panel empty | JavaScript error | Check browser console for errors |
| Preset dropdown empty | No presets created | Create a preset in Presto Player > Presets |
| "Block type is not registered" | Plugin deactivated or JS not loaded | Verify plugin is active, clear cache |
| Video preview not loading in editor | REST API blocked | Check for security plugins blocking REST API |

## Analytics Errors

| Symptom | Likely Cause | Resolution |
|---------|-------------|------------|
| No visits recorded | AJAX endpoint blocked | Check for security plugins blocking admin-ajax.php |
| Visits show duration 0 | Player events not firing | Check for JavaScript errors on frontend |
| Analytics dashboard blank | React app not loading | Clear browser cache, check for JS conflicts |

## Email Collection Errors

| Symptom | Likely Cause | Resolution |
|---------|-------------|------------|
| Overlay doesn't appear | Email collection not enabled on preset | Check preset settings |
| Email submitted but not in provider | API key invalid or provider misconfigured | Verify email provider settings |
| "Email required" error | Form validation | Ensure valid email format |

## LMS Integration Errors

| Symptom | Likely Cause | Resolution |
|---------|-------------|------------|
| LearnDash lesson not auto-completing | Completion threshold not met or cookie issue | Check completion percentage setting, clear cookies |
| Video progress not tracking | Cookie-based tracking blocked | Check browser cookie settings, third-party cookie policies |
| Wrong lesson marked complete | Video ID mismatch | Verify video is correctly embedded in the right lesson |

## Page Builder Errors

| Symptom | Likely Cause | Resolution |
|---------|-------------|------------|
| Elementor widget not found | Elementor module not loaded | Ensure both plugins are active, check Elementor version |
| Beaver Builder module missing | Module not registered | Verify plugin is active and Beaver Builder is loaded |
| Divi module not appearing | Divi integration not loaded | Check plugin compatibility and Divi version |
| Player renders but no controls | CSS conflict with page builder | Check for CSS overrides, try default theme |
