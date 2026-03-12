# Troubleshooting Presets

## How Presets Work

Presets are reusable player configurations stored in the `presto_player_presets` (video) and `presto_player_audio_presets` (audio) tables. Each preset defines controls, styling, CTA, watermark, email collection, and action bar settings. When a block has a preset assigned, the preset settings are loaded and merged with the block attributes at render time.

**Key files**: `inc/Models/Preset.php`, `inc/Models/AudioPreset.php`, `inc/Services/API/RestPresetsController.php`

## Quick Diagnosis

Ask the customer:
1. Is this a video preset or audio preset issue?
2. What specific setting isn't working (controls, styling, CTA, watermark)?
3. Was the preset recently created or modified?
4. Does the issue affect all videos with this preset or just one?

---

## Common Issues

### Preset Changes Not Applying

**Symptoms**: Customer edits a preset but the changes don't appear on the frontend.

**Common causes**:
- Page cache serving old version
- Browser cache storing old player CSS/JS
- Preset not saved properly
- Block using a different preset than expected

**What to check**:
1. Clear all caches (page cache, browser cache, CDN cache)
2. Verify the preset was saved (check Presto Player > Presets)
3. Confirm which preset is assigned to the video block
4. Test in incognito mode

**Fix**: Clear all caches. Verify the correct preset is assigned to the block.

---

### Controls Not Showing/Hiding

**Symptoms**: Enabled controls don't appear, or disabled controls still show.

**Common causes**:
- Preset controls not saved
- CSS conflict hiding controls
- Mobile responsive behavior (some controls hidden on small screens)
- Player skin doesn't support certain controls

**What to check**:
1. Open the preset editor -- are the control toggles correct?
2. Inspect the player in browser dev tools -- are control elements in the DOM?
3. Is there a CSS rule hiding them?
4. Test on desktop and mobile

**Fix**: Re-save the preset with correct control settings. Check for CSS conflicts.

---

### CTA Overlay Not Appearing

**Symptoms**: Call-to-action configured in preset doesn't show during video playback.

**Common causes**:
- CTA not enabled in the preset
- CTA trigger time/percentage not reached
- JavaScript error blocking CTA display
- Pro feature not available on free version

**What to check**:
1. Is CTA enabled in the preset settings?
2. What trigger time/percentage is set?
3. Watch the video to that point -- does the CTA fire?
4. Check browser console for JavaScript errors
5. Is this a Pro-only feature?

**Fix**: Enable CTA in preset. Adjust trigger timing. Check for Pro requirements.

---

### Watermark Not Displaying

**Symptoms**: Watermark configured in preset doesn't appear on the player.

**Common causes**:
- Watermark not enabled in preset
- Image URL broken or inaccessible
- CSS conflict (z-index or opacity)
- Pro feature requirement

**What to check**:
1. Is watermark enabled in the preset?
2. Is the watermark image URL accessible?
3. Inspect the player -- is the watermark element in the DOM?

**Fix**: Verify watermark image URL. Re-save preset settings.

---

### Styling/Colors Not Applied

**Symptoms**: Custom colors or CSS from preset not reflected on frontend.

**Common causes**:
- Theme CSS overriding preset styles
- Cache serving old styles
- Custom CSS syntax error in preset
- Branding settings conflicting with preset

**What to check**:
1. Inspect the player element -- what styles are applied?
2. Is the theme overriding with `!important` rules?
3. Is there a syntax error in custom CSS?
4. Check both preset styling and global branding settings

**Fix**: Clear cache. Use more specific CSS selectors. Check for theme conflicts.

---

## Escalation Criteria

Escalate to engineering if:
- Preset data appears corrupted in the database
- Preset API returns 500 errors on save
- Preset settings load correctly but don't apply to the web component
