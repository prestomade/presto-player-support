# Troubleshooting Self-Hosted Video

## How Self-Hosted Video Works

Self-hosted videos use the HTML5 `<video>` element with a file from the WordPress media library or a custom URL. The `SelfHostedBlock` renders the player with full control customization. Large files can use the `Streamer` service for byte-range requests.

**Handler**: `inc/Blocks/SelfHostedBlock.php`, `inc/Services/Streamer.php`

## Quick Diagnosis

Ask the customer:
1. How was the video uploaded (media library or custom URL)?
2. What is the file format and size?
3. Does the video play when accessed directly via URL?
4. What error appears?
5. Is the video on the same server or an external URL?

---

## Common Issues

### Video Upload Fails

**Symptoms**: Video file can't be uploaded to WordPress media library.

**Common causes**:
- PHP upload_max_filesize too small
- PHP post_max_size too small
- PHP max_execution_time too short
- WordPress memory limit too low
- File type not allowed

**What to check**:
1. PHP settings: `upload_max_filesize`, `post_max_size`, `max_execution_time`, `memory_limit`
2. WordPress constants: `WP_MEMORY_LIMIT`, `WP_MAX_MEMORY_LIMIT`
3. Is the file format allowed? (MP4, WebM, OGG are standard)
4. Does the hosting provider have additional limits?

**Fix**: Increase PHP limits in `php.ini` or `.htaccess`. Contact hosting provider for upload limits. Use FTP for very large files.

---

### Video Won't Play (Codec Issue)

**Symptoms**: Player loads but video doesn't play, or audio plays without video.

**Common causes**:
- Video encoded with HEVC/H.265 (not supported in Chrome/Firefox)
- Non-standard codec in MP4 container
- Missing audio codec (AAC required for broad support)

**What to check**:
1. What codec is the video? (Right-click video URL > check with MediaInfo)
2. Does it play in Safari? (Safari supports more codecs natively)
3. What container format? (MP4 is most compatible)

**Fix**: Re-encode to H.264 video codec + AAC audio in MP4 container. This works in all browsers.

---

### Video Loads Slowly / Buffering

**Symptoms**: Long initial load time or frequent buffering during playback.

**Common causes**:
- Large file without compression
- No CDN configured
- Video not optimized for streaming (moov atom at end of file)
- Shared hosting with bandwidth limits
- Byte-range requests not supported by server

**What to check**:
1. What is the file size? (Videos over 100MB need optimization)
2. Is a CDN configured?
3. Does the server support byte-range requests? (Check response headers for `Accept-Ranges: bytes`)
4. Is the moov atom at the start of the file? (Use `ffprobe` to check)

**Fix**: Compress the video. Use `ffmpeg` to move moov atom to start: `ffmpeg -i input.mp4 -movflags +faststart output.mp4`. Consider Bunny CDN integration.

---

### Video Not Accessible (404)

**Symptoms**: Video file returns 404 error.

**Common causes**:
- File deleted from media library
- File moved or renamed
- Permalink structure changed
- Custom URL pointing to wrong location

**What to check**:
1. Does the file exist in `wp-content/uploads/`?
2. Is the attachment still in the media library?
3. Does the direct URL return a response?

**Fix**: Re-upload the file. Update the video block with the correct URL.

---

### Streaming/Byte-Range Issues

**Symptoms**: Video can't seek (jumping to a position doesn't work), or video plays from start only.

**Common causes**:
- Server doesn't support byte-range requests
- Apache/Nginx not configured for partial content
- CDN stripping range headers

**What to check**:
1. Check response headers: `Accept-Ranges: bytes` should be present
2. Make a range request: `curl -I -H "Range: bytes=0-100" VIDEO_URL`
3. Does the response include `Content-Range`?

**Fix**: Enable byte-range support on the server. For Apache: ensure `mod_headers` is enabled. For Nginx: `add_header Accept-Ranges bytes;`.

---

## Escalation Criteria

Escalate to engineering if:
- Streamer service returns incorrect byte ranges
- Media library integration fails to link attachments
- Video records in database don't match actual files
