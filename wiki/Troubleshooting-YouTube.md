# Troubleshooting YouTube

## How YouTube Integration Works

Presto Player embeds YouTube videos using the YouTube IFrame API. The `YouTubeBlock` renders a `<presto-player>` web component which loads the YouTube iframe with custom controls overlaid. Privacy-enhanced mode uses `youtube-nocookie.com`.

**Handler**: `inc/Blocks/YouTubeBlock.php`, `inc/Services/Blocks/YoutubeBlockService.php`

## Quick Diagnosis

Ask the customer:
1. What is the YouTube video URL?
2. Is the video public, unlisted, or private?
3. What error message appears?
4. Does the video play on youtube.com directly?
5. Is an ad blocker or privacy extension active?

---

## Common Issues

### "Video unavailable" Message

**Symptoms**: Player shows "Video unavailable" or similar YouTube error.

**Common causes**:
- Video is private (not public or unlisted)
- Video has been deleted from YouTube
- Video is region-restricted
- Embedding disabled by video owner
- Age-restricted content requiring sign-in

**What to check**:
1. Open the YouTube URL directly -- is it accessible?
2. Check the video's privacy settings on YouTube
3. Is embedding enabled? (YouTube Studio > Visibility > Embedding)
4. Try from a different geographic location (VPN)

**Fix**: Use a public or unlisted video. Enable embedding on YouTube. Use a different video if region-restricted.

---

### YouTube Video Not Loading (Blank/Black)

**Symptoms**: Player area is blank or black, no YouTube player loads.

**Common causes**:
- YouTube IFrame API blocked by ad blocker or content blocker
- Security plugin blocking external scripts (youtube.com, googleapis.com)
- Browser privacy settings blocking third-party iframes
- JavaScript error preventing API initialization

**What to check**:
1. Check browser console for blocked resource errors
2. Disable ad blockers and retry
3. Check security plugin settings (e.g., CSP headers, script blocking)
4. Test in incognito mode without extensions

**Fix**: Whitelist `youtube.com`, `youtube-nocookie.com`, and `googleapis.com` in security plugins. Disable ad blockers.

---

### YouTube Thumbnail/Poster Not Loading

**Symptoms**: Video loads but the poster image before play is missing.

**Common causes**:
- YouTube API key not configured
- YouTube image CDN blocked
- Custom poster image not set

**What to check**:
1. Is a YouTube API key configured in Presto Player settings?
2. Can the browser access `img.youtube.com`?
3. Is a custom poster image set on the block?

**Fix**: Configure YouTube API key in settings. Whitelist YouTube image domains.

---

### Privacy-Enhanced Mode Issues

**Symptoms**: Video doesn't load when privacy-enhanced mode is enabled.

**Common causes**:
- `youtube-nocookie.com` domain blocked
- Some YouTube features don't work with nocookie domain
- CSP headers not allowing the nocookie domain

**What to check**:
1. Is `youtube-nocookie.com` accessible from the browser?
2. Check CSP headers for iframe-src restrictions
3. Try disabling privacy-enhanced mode temporarily

**Fix**: Add `youtube-nocookie.com` to CSP iframe-src allowlist. Whitelist in security plugins.

---

## Escalation Criteria

Escalate to engineering if:
- YouTube IFrame API initialization fails consistently
- Video ID parsing from URL is incorrect
- Privacy-enhanced mode toggle not taking effect in rendered markup
