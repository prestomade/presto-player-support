# /trace-flow -- Code Flow Tracing

When the agent wants to understand how a feature works end-to-end, follow these steps:

## Step 1: Identify the Flow

Determine what flow to trace. Common flows:
- Video block renders on frontend (YouTube, Vimeo, self-hosted)
- Player preset is applied to a video
- Email collection overlay triggers on video play
- CTA overlay displays at configured time
- Video analytics visit is recorded
- LearnDash video progression tracks completion
- Reusable video block is created and embedded
- Player loads with HLS stream
- Bunny CDN webhook processes video
- Admin creates/edits a player preset

## Step 2: Trace the Plugin Code

Follow the execution path through the Presto Player plugin:
1. Entry point (which hook, block render, or REST endpoint)
2. Permission/access checks
3. Input validation
4. Core logic (database operations, player rendering)
5. Side effects (analytics tracking, email collection, LMS updates)
6. Response returned or content rendered

Search the actual source code for each step. Cite file paths and line numbers.

## Step 3: Trace Integration (if applicable)

If the flow involves LMS or page builders:
1. What event triggers the integration
2. Which handler method processes it
3. How the video player is embedded
4. What data is passed between systems

## Step 4: Present as Numbered Sequence

Present the flow as a numbered, plain-English sequence. Example:

1. User visits a page with a YouTube video block
2. Block render callback in `YouTubeBlock.php` fires
3. Block attributes are sanitized and merged with preset defaults
4. Player web component `<presto-player>` is rendered with attributes
5. Frontend JavaScript initializes the Stencil.js player component
6. YouTube iframe is loaded with configured options
7. Play event triggers visit tracking via AJAX
8. If email collection is configured, overlay shows at configured percentage

Always include file references for each step.
