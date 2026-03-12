# /troubleshoot -- Guided Diagnosis

When the support agent describes a customer issue, follow these 5 steps:

## Step 1: Classify the Issue

Identify the issue category:
- Playback (video/audio not playing, buffering, errors)
- YouTube (embed issues, API errors, privacy-enhanced mode)
- Vimeo (embed issues, private video access)
- Self-Hosted (upload, streaming, format compatibility)
- Presets (player styling, controls, CTA, watermark)
- Analytics (visits not tracking, data missing)
- Email Collection (overlay not showing, provider not syncing)
- LMS Integration (LearnDash, TutorLMS, LifterLMS progression)
- Page Builder (Elementor, Beaver Builder, Divi, Kadence)
- Setup (activation, configuration, settings)

State the category clearly.

## Step 2: Check the Runbook

Search the `wiki/` directory for the matching troubleshooting runbook. Present the **Quick Diagnosis** questions from the runbook for the agent to ask the customer.

## Step 3: Search Code & Documentation

Based on the symptoms, search the Presto Player plugin source code for:
- The relevant playback logic, block, or integration handler
- Error messages that match what the customer sees
- Conditional logic that could cause the behavior
- Related configuration or settings

Cite specific file paths and line numbers.

## Step 4: Provide Resolution

Give a clear, step-by-step resolution:
1. What the customer should try first (simple fixes)
2. What the support agent should check (admin-side)
3. What might need developer intervention

Use plain language the agent can relay to the customer.

## Step 5: Escalation Check

If any of these are true, recommend escalation:
- The issue requires a code change
- Video or preset database records appear corrupted
- The error is a server-side 500
- Security is involved
- Player web components fail to render consistently
- All troubleshooting steps have been exhausted
