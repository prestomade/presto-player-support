# Troubleshooting Page Builder Integration

## How Page Builder Integration Works

Presto Player provides custom widgets/modules for Elementor, Beaver Builder, Divi, and Kadence. Each integration registers custom elements that embed Presto Player blocks within the page builder's editing interface. The integrations check if the page builder is active before loading.

**Key files**: `inc/Integrations/Elementor/`, `inc/Integrations/BeaverBuilder/`, `inc/Integrations/Divi/`, `inc/Integrations/Kadence.php`

## Quick Diagnosis

Ask the customer:
1. Which page builder are they using?
2. Is the Presto Player widget/module visible in the builder?
3. Does the video show in the builder preview?
4. Does the video work on the published page?
5. What versions of the page builder and Presto Player?

---

## Common Issues

### Widget/Module Not Found in Builder

**Symptoms**: Presto Player option doesn't appear in Elementor widgets, Beaver Builder modules, or Divi modules.

**Common causes**:
- Presto Player plugin not active
- Page builder loaded before Presto Player integration initializes
- Plugin version incompatibility
- Page builder caching stale module list

**What to check**:
1. Is Presto Player active?
2. What version of the page builder?
3. Clear page builder cache (Elementor: Tools > Regenerate CSS & Data)
4. Check for JavaScript errors in the builder
5. Deactivate other plugins to check for conflicts

**Fix**: Ensure both plugins are active. Clear page builder cache. Update to latest versions.

---

### Video Shows in Builder But Not on Frontend

**Symptoms**: Video preview works in the page builder editor but doesn't render on the published page.

**Common causes**:
- Page builder caching serving old version
- Presto Player scripts not enqueued on frontend
- Builder using different render path than frontend
- CDN caching old page

**What to check**:
1. Clear all caches (page builder, WordPress, CDN, browser)
2. View page source -- are Presto Player scripts present?
3. Check for JavaScript errors on the frontend
4. Try viewing in incognito mode

**Fix**: Clear all caches. Verify scripts are enqueued on the page.

---

### Elementor Specific Issues

**Symptoms**: Presto Player Elementor widget doesn't load, preview broken, or styles missing.

**Common causes**:
- Elementor version too old
- Elementor Container support requires v3.16+
- CSS conflict between Elementor and Presto Player
- Elementor cached CSS outdated

**What to check**:
1. What Elementor version? (v3.16+ recommended)
2. Clear Elementor cache (Elementor > Tools > Regenerate CSS)
3. Check for CSS conflicts in browser inspector
4. Try the widget in a fresh page with no other elements

**Fix**: Update Elementor. Regenerate CSS. Check for CSS conflicts.

---

### Beaver Builder Specific Issues

**Symptoms**: Presto Player module missing or video not rendering in Beaver Builder.

**Common causes**:
- Beaver Builder module not registered
- Old Beaver Builder version
- Module category not visible in builder

**What to check**:
1. Is the Presto Player category visible in Beaver Builder's module list?
2. What Beaver Builder version?
3. Try searching for "Presto" in the module search

**Fix**: Update both plugins. Check module list visibility settings.

---

### Divi Specific Issues

**Symptoms**: Presto Player module not appearing in Divi builder.

**Common causes**:
- Divi integration not loaded
- Version incompatibility
- Divi Builder cache stale

**What to check**:
1. Is Divi Builder (or Divi theme) active?
2. What version of Divi?
3. Clear Divi cache (Divi > Theme Options > Builder > Advanced > Static CSS)

**Fix**: Update both plugins. Clear Divi cache.

---

### Player Controls/Styling Broken in Builder Context

**Symptoms**: Player renders but controls are misaligned, unstyled, or non-functional within page builder.

**Common causes**:
- Page builder CSS conflicting with player CSS
- Page builder's iframe editor loading different styles
- Z-index conflicts with builder UI

**What to check**:
1. Does the issue appear only in the builder or also on the frontend?
2. If only in builder -- this is a preview issue, not a frontend issue
3. If on frontend -- check CSS specificity conflicts

**Fix**: If only in builder, reassure it's a preview issue. If on frontend, check for CSS conflicts.

---

## Escalation Criteria

Escalate to engineering if:
- Integration code fails to register modules after plugin updates
- Page builder API changes break Presto Player integration
- Video renders incorrectly in specific builder contexts
