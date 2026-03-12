# Troubleshooting Setup & Configuration

## How Setup Works

Presto Player registers the `pp_video_block` custom post type on activation, creates 6 custom database tables, seeds default presets, and sets up rewrite rules. The admin dashboard is a React app at `wp-admin/admin.php?page=presto-player`. The plugin uses DICE dependency injection to load all services.

## Quick Diagnosis

Ask the customer:
1. Is this a fresh install or an update?
2. What PHP and WordPress versions?
3. What error message appears?
4. Is Presto Player Pro also installed?

---

## Common Issues

### Plugin Activation Fails

**Symptoms**: Fatal error or white screen on activation.

**Common causes**:
- PHP version too old (requires 7.3+)
- WordPress version too old (requires 5.6+)
- Memory limit too low
- Conflicting plugin (another video player plugin)
- Database table creation failed

**What to check**:
1. PHP 7.3+ required
2. WordPress 5.6+ required
3. Memory limit at least 128MB
4. Check `debug.log` for the error
5. Check if custom tables were created: `wp_presto_player_*`

**Fix**: Upgrade PHP/WP. Increase memory. Deactivate conflicting plugins. Check database permissions.

---

### Admin Dashboard Blank

**Symptoms**: Presto Player admin page loads but shows nothing.

**Common causes**:
- React assets not loaded
- JavaScript error
- Another plugin's JS crashing the page
- REST API blocked by security plugin
- Old browser cache

**What to check**:
1. Browser console for JavaScript errors
2. Is the React app bundle loaded in page source?
3. Check Network tab -- are REST API calls succeeding?
4. Try incognito mode
5. Deactivate other plugins

**Fix**: Clear browser cache. Check for JS conflicts. Whitelist REST API in security plugins.

---

### Presets Not Saving

**Symptoms**: Creating/editing a preset doesn't save changes.

**Common causes**:
- REST API blocked (security plugin)
- User lacks `upload_files` capability
- Database table missing or corrupted
- JavaScript error preventing form submission

**What to check**:
1. Browser Network tab -- check `/presto-player/v1/preset` REST call
2. Is the response a success or error?
3. Does the user have Author role or higher?
4. Is a security plugin blocking REST API?
5. Check browser console for errors

**Fix**: Whitelist `presto-player/v1/*` in security plugins. Ensure correct user role.

---

### Database Tables Missing

**Symptoms**: Plugin activates but features don't work, REST API returns empty data.

**Common causes**:
- Database user lacks CREATE TABLE permission
- Activation hook didn't fire properly
- `dbDelta()` failed silently
- Table prefix mismatch

**What to check**:
1. Check database for tables: `wp_presto_player_videos`, `wp_presto_player_presets`, etc.
2. Does the database user have CREATE TABLE permission?
3. Check `debug.log` for database errors
4. Try deactivating and reactivating the plugin

**Fix**: Deactivate and reactivate to trigger table creation. Check database permissions.

---

### Pro Plugin Compatibility Issues

**Symptoms**: Pro features not working or errors after updating free version.

**Common causes**:
- Version mismatch between free and Pro plugins
- Pro requires minimum core version (0.0.3+)
- Pro plugin not activated

**What to check**:
1. What versions of both free and Pro plugins?
2. Is Pro activated?
3. Check `ProCompatibility` service for version requirements
4. Check admin notices for compatibility warnings

**Fix**: Update both plugins to latest versions. Check compatibility warnings.

---

### Rewrite Rules / Instant Video Pages Not Working

**Symptoms**: Instant video page URLs return 404.

**Common causes**:
- Permalinks not flushed after activation
- Custom permalink structure conflict
- `pp_video_block` post type not registered

**What to check**:
1. Go to Settings > Permalinks and click "Save Changes" (flushes rewrite rules)
2. Is the `pp_video_block` post type visible in REST API?
3. Is "Instant Video Pages" enabled?

**Fix**: Flush permalinks. Verify post type registration.

---

### Video Import/Migration Issues

**Symptoms**: Videos created before an update don't display correctly.

**Common causes**:
- Database schema changed between versions
- Block markup format changed (block recovery needed)
- Migration script didn't run

**What to check**:
1. Check plugin version history -- was there a major update?
2. Are blocks showing "This block contains unexpected content" in editor?
3. Check database upgrade status in `inc/Database/Upgrades/`

**Fix**: Click "Attempt Block Recovery" in editor. Deactivate/reactivate to trigger migrations.

---

## Escalation Criteria

Escalate to engineering if:
- Plugin causes fatal error on activation
- Database migrations fail
- React dashboard fails to load after reinstall
- DICE DI container initialization fails
