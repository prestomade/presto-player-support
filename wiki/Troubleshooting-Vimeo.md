# Troubleshooting Vimeo

## How Vimeo Integration Works

Presto Player embeds Vimeo videos using the Vimeo Player SDK. The `VimeoBlock` renders a `<presto-player>` web component which loads the Vimeo iframe with custom controls overlaid.

**Handler**: `inc/Blocks/VimeoBlock.php`, `inc/Services/Blocks/VimeoBlockService.php`

## Quick Diagnosis

Ask the customer:
1. What is the Vimeo video URL?
2. Is the video public, private, or password-protected?
3. Are there domain restrictions set on Vimeo?
4. What error message appears?
5. Does the video play on vimeo.com directly?

---

## Common Issues

### "This video does not exist" Message

**Symptoms**: Player shows error that the video doesn't exist.

**Common causes**:
- Invalid Vimeo video ID
- Video deleted from Vimeo
- Vimeo account suspended or downgraded

**What to check**:
1. Open the Vimeo URL directly -- is it accessible?
2. Is the video ID correct in the block settings?
3. Is the Vimeo account active?

**Fix**: Verify the Vimeo URL. Update the video ID if it changed.

---

### "Video cannot be played" / Domain Restriction

**Symptoms**: Video exists on Vimeo but won't play on the WordPress site.

**Common causes**:
- Vimeo privacy settings restrict embedding to specific domains
- WordPress site domain not in Vimeo's allowed domains
- Using a staging/development domain not in allowlist
- Vimeo plan doesn't support domain restriction features

**What to check**:
1. Check Vimeo video settings > Privacy > "Where can this be embedded?"
2. Is the WordPress site's domain listed?
3. Are you testing on a staging domain not in the list?
4. What Vimeo plan is the customer on?

**Fix**: Add the WordPress site domain to Vimeo's allowed embed domains. Add staging domains if testing.

---

### Private Vimeo Video Not Loading

**Symptoms**: Private Vimeo video shows error or blank player.

**Common causes**:
- Private videos require a hash parameter in the URL
- URL format incorrect (missing the hash)
- Vimeo privacy settings changed after embedding

**What to check**:
1. Is the Vimeo URL in the format `vimeo.com/VIDEO_ID/HASH`?
2. Can you access it via the full private link?
3. Have privacy settings changed recently?

**Fix**: Use the full private share link including the hash parameter.

---

### Vimeo Thumbnail Not Loading

**Symptoms**: No poster image before video plays.

**Common causes**:
- Vimeo API access limited by plan
- Vimeo CDN blocked
- Custom poster not set

**What to check**:
1. Can the browser access `i.vimeocdn.com`?
2. Is a custom poster image set on the block?

**Fix**: Set a custom poster image. Whitelist Vimeo CDN domains.

---

## Escalation Criteria

Escalate to engineering if:
- Vimeo Player SDK initialization fails consistently
- Video ID extraction from URL is incorrect
- Player events (play, pause, timeupdate) not forwarding from Vimeo
