# /ask-developer -- Generate Developer Escalation Template

When the support agent uses this command, generate a ready-to-paste Slack message for developer escalation by extracting everything you know from the current conversation.

## Instructions

1. **Review the entire conversation** -- gather every detail discussed: the customer's issue, steps tried, errors found, environment details, screenshots/screencasts mentioned, and any code references you found.

2. **Fill in the template below** -- replace every placeholder with actual information from the conversation. If a piece of information was not discussed, write "Not provided" for that field. Do NOT leave empty brackets or placeholder text.

3. **For Steps to Reproduce** -- reconstruct the reproduction steps from what the customer described. Number them clearly. If exact steps are unclear, write the best approximation based on conversation context and note "[approximate -- confirm with customer]".

4. **For Console Errors** -- include any error messages, HTTP status codes, or log entries that were mentioned or discovered during troubleshooting. If none were discussed, write "No console errors reported".

5. **For What was already tried** -- check the boxes for any troubleshooting steps that were completed during this session. Leave unchecked items that weren't tried.

6. **Output the filled template as a single code block** so the agent can copy-paste it directly into Slack.

## Template

Output this template inside a single markdown code block (```), with all placeholders replaced:

```
🔧 *Developer Escalation*

*Customer Ticket:* [ticket URL or ID from conversation, or "Not provided"]

*Issue Summary:*
[One-line description synthesized from the conversation]

*Steps to Reproduce:*
1. [step]
2. [step]
3. [step]

*Expected Behavior:*
[What should happen based on the discussion]

*Actual Behavior:*
[What actually happens based on customer report and investigation]

*Screencast / Screenshot:*
[Any links or files shared during the conversation, or "None provided -- please ask customer"]

*Console Errors:*
```
[Paste any errors discovered during the session, or "No console errors reported"]
```

*Environment:*
• WordPress: [version if mentioned, or "Not provided"]
• PHP: [version if mentioned, or "Not provided"]
• Presto Player: [version if mentioned, or "Not provided"]
• Presto Player Pro: [version if mentioned, or "Not provided"]
• Browser: [if mentioned, or "Not provided"]
• Theme: [if mentioned, or "Not provided"]

*What was already tried:*
[x or space] Cleared all caches
[x or space] Tested in incognito
[x or space] Disabled other plugins
[x or space] Tested with default theme
[Any other troubleshooting steps attempted during this session]

*Additional Context:*
[Any relevant details: customer plan, urgency, related code files found, root cause hypothesis, links to relevant source code discovered during investigation]
```

## Important

- Fill in EVERY field from conversation context. Never output raw placeholders.
- Keep it concise -- developers skim these. No long paragraphs.
- If you formed a hypothesis about the root cause during troubleshooting, include it in Additional Context. This saves developer time.
- Include specific file paths and line numbers if you found relevant code during the session.
- The output must be copy-paste ready for Slack. One code block, no extra commentary.
