# Presto Player Playback Flow

## How Video Playback Works

### 1. Block Renders on Page

```
Page with Presto Player block loads
  → WordPress processes Gutenberg blocks
  → Block render callback fires (e.g., YouTubeBlock::render())
  → Block attributes merged with preset defaults
  → <presto-player> web component HTML generated
  → Player scripts enqueued (Stencil.js components)
  → Page delivered to browser
```

### 2. Frontend Player Initialization

```
Browser loads page
  → Stencil.js player web components initialize
  → Player reads attributes (src, preset, controls, skin)
  → Provider detected (YouTube, Vimeo, HTML5, HLS)
  → YouTube: loads YouTube iframe API
  → Vimeo: loads Vimeo Player SDK
  → Self-hosted: initializes HTML5 <video> element
  → HLS: loads HLS.js for adaptive streaming
  → Player UI renders with configured controls
```

### 3. YouTube Playback

```
YouTube block on frontend
  → YouTubeBlock::render() generates markup
  → Stencil component loads YouTube IFrame API
  → Video ID from external_id or src URL
  → Privacy-enhanced mode: uses youtube-nocookie.com
  → Poster image displayed until play
  → User clicks play → YouTube player loads in iframe
  → Player controls overlay YouTube iframe
  → Events forwarded: play, pause, timeupdate, ended
```

### 4. Vimeo Playback

```
Vimeo block on frontend
  → VimeoBlock::render() generates markup
  → Stencil component loads Vimeo Player SDK
  → Video ID from external_id or src URL
  → Iframe embed with custom parameters
  → Player controls overlay Vimeo iframe
  → Events forwarded: play, pause, timeupdate, ended
```

### 5. Self-Hosted Playback

```
Self-hosted block on frontend
  → SelfHostedBlock::render() generates markup
  → HTML5 <video> element created
  → Source URL from attachment or custom URL
  → Preload behavior: metadata | auto | none
  → Native browser playback engine
  → Full control customization (all Plyr controls available)
```

### 6. HLS Streaming

```
HLS video source detected
  → Check browser native HLS support (Safari)
  → If native: use HTML5 <video> with HLS src
  → If not native: load HLS.js library
  → HLS.js attaches to <video> element
  → Adaptive bitrate streaming begins
  → Quality auto-adjusts based on connection
```

## How Analytics Tracking Works

```
User plays video
  → Player fires 'play' event
  → AJAX request sent to WordPress
  → Visit record created in presto_player_visits table
       → user_id (0 if not logged in)
       → video_id (from presto_player_videos)
       → ip_address
       → duration (updated as playback continues)
       → created_at timestamp
  → Duration updated periodically during playback
  → On pause/end: final duration saved
```

## How Email Collection Works

```
Video plays, reaches configured percentage
  → Email collection overlay triggers
  → behavior: 'gate' → pauses video, requires email to continue
  → behavior: 'overlay' → shows non-blocking overlay
  → allow_skip: true → shows skip button
  → User enters email and submits
  → Email sent to configured provider:
       → Webhook: POST to configured URL
       → ActiveCampaign: API call to add contact
       → FluentCRM: local WordPress API call
       → Mailchimp: API call to add subscriber
       → MailerLite: API call to add subscriber
  → Player resumes / overlay dismissed
```

## How CTA (Call-to-Action) Works

```
Video reaches configured CTA time/percentage
  → CTA overlay appears on player
  → Can include: text, button, link
  → User can interact or dismiss
  → CTA settings stored in preset configuration
```

## How Presets Are Applied

```
Block has preset_id attribute
  → On render: Preset::find($preset_id) loads from database
  → Preset fields merged with block attributes
  → Controls, styling, CTA, watermark, email settings applied
  → Resulting configuration passed to web component
  → Player renders with all preset settings
```

## How Reusable Videos Work

```
Admin creates reusable video
  → New pp_video_block post created
  → Gutenberg editor opens with video block
  → Video configured with source and preset
  → Video record created in presto_player_videos table
  → Post saved with block markup in post_content

Embedding reusable video
  → ReusableVideoBlock references pp_video_block post ID
  → On render: post_content extracted and rendered
  → Same video, same preset, reused across pages
  → Edit once, updates everywhere

Instant video page
  → pp_video_block has single post template
  → Visit /pp_video_block/video-slug/ to view standalone page
  → Template renders video with configured layout
```

## How LMS Integration Works

### LearnDash

```
LearnDash lesson contains Presto Player video
  → Video block detected in lesson content
  → Video progress tracked via cookies
  → On configured completion percentage:
       → Auto-complete fires for the lesson
       → LearnDash marks lesson as complete
  → Cookie key: based on video + lesson + user
  → Configurable: completion delay, auto-complete threshold
```

### TutorLMS

```
TutorLMS lesson contains Presto Player video
  → Video embedded via block or shortcode
  → Player events forwarded to Tutor progress tracker
```

### LifterLMS

```
LifterLMS lesson contains Presto Player video
  → Video block integration similar to LearnDash
  → Video progress tracked for lesson completion
```

## Key Classes

| Class | File | Purpose |
|-------|------|---------|
| `YouTubeBlock` | `inc/Blocks/YouTubeBlock.php` | YouTube block render |
| `VimeoBlock` | `inc/Blocks/VimeoBlock.php` | Vimeo block render |
| `SelfHostedBlock` | `inc/Blocks/SelfHostedBlock.php` | Self-hosted block render |
| `AudioBlock` | `inc/Blocks/AudioBlock.php` | Audio block render |
| `PopupBlock` | `inc/Blocks/PopupBlock.php` | Popup modal render |
| `ReusableVideoBlock` | `inc/Blocks/ReusableVideoBlock.php` | Reusable video embed |
| `MediaHubBlock` | `inc/Blocks/MediaHubBlock.php` | Media hub browser |
| `Video` | `inc/Models/Video.php` | Video data model |
| `Preset` | `inc/Models/Preset.php` | Preset data model |
| `Scripts` | `inc/Services/Scripts.php` | Asset loading |
| `Player` | `inc/Services/Player.php` | Player rendering |
| `AjaxActions` | `inc/Services/AjaxActions.php` | AJAX handlers (analytics) |
| `Streamer` | `inc/Services/Streamer.php` | Video streaming handler |
