# Troubleshooting Email Collection

## How Email Collection Works

Email collection is configured per preset. When a video reaches a configured percentage, an overlay appears asking for the viewer's email. Two modes: "gate" (pauses video, requires email to continue) and "overlay" (non-blocking). Collected emails are sent to a configured provider (ActiveCampaign, FluentCRM, Mailchimp, MailerLite) or webhook.

**Key files**: `inc/Database/EmailCollection.php`, `inc/Models/EmailCollection.php`

## Quick Diagnosis

Ask the customer:
1. Is the email overlay appearing at all?
2. What email provider are they using?
3. Are emails being collected but not reaching the provider?
4. What mode is configured (gate or overlay)?
5. Is this a Pro feature issue?

---

## Common Issues

### Email Overlay Not Appearing

**Symptoms**: Video plays past the configured percentage but no email form appears.

**Common causes**:
- Email collection not enabled on the preset
- Percentage set incorrectly (e.g., 0% means it fires immediately, may seem like it doesn't work)
- JavaScript error preventing overlay render
- User already submitted email (cookie/session tracking)
- Free version doesn't include all email features

**What to check**:
1. Is email collection enabled in the preset?
2. What percentage is configured?
3. Play the video past that percentage -- any JS errors?
4. Test in incognito mode (clears any previous submission cookies)
5. Is Presto Player Pro active (required for email provider integrations)?

**Fix**: Enable email collection in preset. Verify percentage setting. Test in incognito.

---

### Emails Not Reaching Provider

**Symptoms**: Overlay appears, user submits email, but it doesn't appear in the email service.

**Common causes**:
- Email provider API key invalid or expired
- Provider list/tag misconfigured
- Server can't make outbound HTTP requests
- Webhook URL incorrect
- Pro plugin not active

**What to check**:
1. Verify API key in Presto Player settings
2. Check the provider list/tag configuration
3. Can the server reach the provider API? (Test with `curl`)
4. Check PHP error log for API response errors
5. For webhooks: is the URL correct and reachable?

**Fix**: Update API keys. Verify list/tag settings. Check server outbound HTTP. Test webhook URL.

---

### Gate Mode Not Pausing Video

**Symptoms**: Email overlay shows but video continues playing behind it.

**Common causes**:
- Behavior set to "overlay" instead of "gate"
- JavaScript error in pause handler
- Player type doesn't support programmatic pause

**What to check**:
1. Is the behavior set to "gate" in the preset?
2. Check browser console for errors when overlay triggers
3. What video type is being used?

**Fix**: Change behavior to "gate" in preset settings.

---

### Allow Skip Not Working

**Symptoms**: Skip button doesn't appear or doesn't dismiss the overlay.

**Common causes**:
- Allow skip not enabled in preset
- CSS hiding the skip button
- JavaScript error on skip handler

**What to check**:
1. Is "allow skip" enabled in the email collection settings?
2. Inspect the overlay -- is a skip button in the DOM?
3. Any JavaScript errors?

**Fix**: Enable allow skip in preset. Check for CSS conflicts.

---

## Escalation Criteria

Escalate to engineering if:
- Email provider API integration consistently fails
- Email collection records are created but provider sync fails silently
- Gate mode pause/resume mechanism is broken
- Webhook calls return errors from the Presto Player side
