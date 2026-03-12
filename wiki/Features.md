# Presto Player Features Overview

## Video Playback
Support for multiple video sources with a unified, customizable player:
- **YouTube** -- Embed with custom controls, privacy-enhanced mode, poster images
- **Vimeo** -- Embed with custom controls, private video support
- **Self-Hosted** -- HTML5 video (MP4, WebM) from WordPress media library or custom URL
- **HLS Streaming** -- Adaptive bitrate streaming via HLS.js
- **Bunny CDN** -- Direct integration with Bunny.net for video hosting and delivery

## Audio Playback
Dedicated audio player with:
- Audio-specific presets and styling
- Custom controls (play, progress, time, mute, volume, speed)
- Audio block for Gutenberg editor

## Gutenberg Blocks (10 blocks)
- **YouTube Block** -- YouTube video with custom player
- **Vimeo Block** -- Vimeo video with custom player
- **Self-Hosted Block** -- Upload or link video files
- **Audio Block** -- Audio player
- **Media Hub Block** -- Browse and select videos from media hub
- **Popup Block** -- Video in popup/modal overlay
- **Popup Trigger Block** -- Button/element to trigger popup
- **Popup Media Block** -- Media content inside popup
- **Reusable Video Block** -- Embed a saved reusable video
- **Reusable Edit Block** -- Edit a reusable video inline

## Player Presets
Reusable player configurations:
- Named presets with icon and skin selection
- Control toggles (play, rewind, fast-forward, progress, time, mute, volume, speed, PiP, fullscreen, captions)
- Custom styling (colors, borders, CSS)
- CTA overlay settings
- Watermark configuration
- Email collection settings
- Action bar settings
- Search within player

## Reusable Videos
Custom post type (`pp_video_block`) for video management:
- Create once, embed anywhere
- Edit once, updates everywhere
- Tag-based organization
- Instant video pages (standalone URL per video)
- Media hub for browsing all videos

## Video Analytics
Built-in visit tracking:
- Per-video visit records
- Watch duration tracking
- User identification (logged-in users)
- IP-based tracking for anonymous visitors
- Analytics dashboard with charts (ApexCharts)
- Configurable data retention/purge

## Email Collection
Capture emails during video playback:
- Gate mode (pause video, require email to continue)
- Overlay mode (non-blocking overlay)
- Configurable trigger percentage (0-100% of video)
- Allow skip option
- Custom headline and button text
- Provider integrations: ActiveCampaign, FluentCRM, Mailchimp, MailerLite (Pro)
- Webhook support for custom integrations

## Call-to-Action (CTA)
Overlay CTAs on the player:
- Configurable timing/percentage
- Custom text, buttons, and links
- Per-preset CTA settings

## Watermark
Brand protection:
- Watermark image on player
- Position configuration
- Per-preset watermark settings

## Player Features
- **Sticky scroll** -- Player follows user while scrolling
- **Captions/subtitles** -- WebVTT caption support
- **Playback speed** -- Adjustable playback rate
- **Picture-in-Picture** -- PiP mode support
- **Keyboard shortcuts** -- Standard media keyboard controls
- **Responsive** -- Adapts to container width
- **Lazy loading** -- Poster image until play

## Integrations

### LMS (Learning Management Systems)
- **LearnDash** -- Video progression tracking, auto-complete lessons on watch completion, configurable completion threshold, cookie-based progress
- **TutorLMS** -- Video embedding in lessons with progress tracking
- **LifterLMS** -- Video integration in courses with completion tracking

### Page Builders
- **Elementor** -- Custom Elementor widgets for all video types
- **Beaver Builder** -- Custom Beaver Builder modules
- **Divi** -- Divi builder modules for video embedding
- **Kadence** -- Theme integration and compatibility

### Email Services (Pro)
- ActiveCampaign
- FluentCRM
- Mailchimp
- MailerLite

### CDN
- **Bunny CDN** -- Video hosting, delivery, and webhook sync

## Branding
- Custom logo on player
- Custom player colors
- Custom CSS injection
- Per-site branding settings

## Shortcodes
Embed videos via shortcode for non-block editors.

## Hooks & Extensibility
- `presto_player_pro_components` -- Add pro components
- `presto_player/block/default_attributes` -- Modify block defaults
- `presto_player/templates/player_tag` -- Modify player HTML
- `presto-settings-block-js-options` -- Pass data to frontend JS
- `presto_player_rest_prepared_database_item` -- Filter REST API items
- `presto_player_rest_prepared_response_item` -- Filter REST API responses
