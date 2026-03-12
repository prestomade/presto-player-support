# Troubleshooting Analytics

## How Analytics Work

Presto Player tracks video visits in the `presto_player_visits` custom table. When a user plays a video, a visit record is created via AJAX. The visit records include user ID (0 for anonymous), video ID, watch duration, IP address, and timestamps. The analytics dashboard uses ApexCharts to visualize the data.

**Key files**: `inc/Database/Visits.php`, `inc/Services/AjaxActions.php`

## Quick Diagnosis

Ask the customer:
1. Are any visits being recorded, or none at all?
2. Is the issue on specific videos or all videos?
3. When did analytics stop working (if it worked before)?
4. Is an optimization or caching plugin active?

---

## Common Issues

### No Visits Being Recorded

**Symptoms**: Analytics dashboard shows zero visits despite videos being played.

**Common causes**:
- AJAX endpoint blocked by security plugin
- JavaScript error preventing AJAX call
- `admin-ajax.php` rate-limited or blocked
- Database table missing or corrupted
- Caching plugin serving static HTML (no JavaScript execution tracking)

**What to check**:
1. Play a video and check browser Network tab for AJAX requests to `admin-ajax.php`
2. Is the request returning 200 or an error?
3. Check browser console for JavaScript errors
4. Verify the `presto_player_visits` table exists in the database
5. Is a full-page caching plugin active?

**Fix**: Whitelist `admin-ajax.php` in security plugins. Fix JavaScript errors. Verify database table exists (deactivate and reactivate plugin to recreate).

---

### Visits Show Duration 0

**Symptoms**: Visits are recorded but all show 0 seconds duration.

**Common causes**:
- Duration update AJAX call not firing
- Player events (timeupdate) not being captured
- JavaScript error after initial play event
- Browser leaving page before duration update sends

**What to check**:
1. Check browser Network tab -- are there multiple AJAX calls during playback?
2. Is the timeupdate event firing? (Check console logs)
3. Are there JavaScript errors during playback?

**Fix**: Check for JS errors. Ensure player events are not being blocked by other scripts.

---

### Analytics Dashboard Not Loading

**Symptoms**: Presto Player analytics page is blank or shows loading spinner indefinitely.

**Common causes**:
- React dashboard JavaScript not loaded
- REST API blocked
- ApexCharts library not loaded
- PHP memory limit too low for large datasets

**What to check**:
1. Check browser console for errors
2. Check Network tab -- are API calls returning data?
3. Try with fewer date range (less data)
4. Check PHP memory limit

**Fix**: Clear browser cache. Check for REST API blocks. Increase PHP memory limit if needed.

---

### Visit Data Appears Incorrect

**Symptoms**: Visit counts don't match expected numbers, or data seems duplicated.

**Common causes**:
- Bot traffic being tracked
- Multiple AJAX calls per visit
- Page refreshes creating new visit records
- IP tracking counting unique IPs differently than expected

**What to check**:
1. Check visit records in database -- are there bot user agents?
2. Are there duplicate records for the same user/video/timestamp?
3. How is the customer defining "expected" visits?

**Fix**: Review raw visit data. Bots are typically filtered by checking user agent, but some may slip through.

---

## Escalation Criteria

Escalate to engineering if:
- Database table is corrupted or missing columns
- AJAX endpoint returns 500 errors
- Visit records are being created with incorrect video IDs
- Analytics data purge/cleanup is not working
