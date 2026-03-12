# Presto Player Architecture

## Overview

Presto Player is a WordPress plugin for video and audio playback. It uses Gutenberg blocks for embedding, custom database tables for video/preset/analytics storage, Stencil.js web components for the player UI, and a DICE dependency injection container for backend services.

## System Diagram

```
┌──────────────────────────────────────────────────────┐
│                  WordPress Site                       │
│                                                      │
│  ┌──────────────────────────────────────────────┐    │
│  │           Presto Player Plugin                │    │
│  │                                              │    │
│  │  Gutenberg Blocks (10 blocks)                │    │
│  │  ├── YouTube, Vimeo, Self-Hosted, Audio      │    │
│  │  ├── Popup, Popup Trigger, Popup Media       │    │
│  │  ├── Reusable Video, Reusable Edit           │    │
│  │  └── Media Hub                               │    │
│  │                                              │    │
│  │  Player Engine (Stencil.js Web Components)   │    │
│  │  ├── YouTube IFrame API                      │    │
│  │  ├── Vimeo Player SDK                        │    │
│  │  ├── HTML5 <video> element                   │    │
│  │  └── HLS.js adaptive streaming               │    │
│  │                                              │    │
│  │  Features                                    │    │
│  │  ├── Player Presets (controls, styling)       │    │
│  │  ├── Video Analytics (visits, duration)       │    │
│  │  ├── Email Collection (gate, overlay)         │    │
│  │  ├── CTA Overlays                            │    │
│  │  ├── Watermarks                              │    │
│  │  └── Reusable Videos (pp_video_block CPT)    │    │
│  │                                              │    │
│  │  Integrations                                │    │
│  │  ├── LearnDash (video progression)           │    │
│  │  ├── TutorLMS (lesson videos)                │    │
│  │  ├── LifterLMS (course videos)               │    │
│  │  ├── Elementor (custom widgets)              │    │
│  │  ├── Beaver Builder (custom modules)         │    │
│  │  ├── Divi (custom modules)                   │    │
│  │  └── Bunny CDN (webhooks)                    │    │
│  └──────────────────────────────────────────────┘    │
│                                                      │
│  Custom Database Tables                              │
│  ├── presto_player_videos (video metadata)           │
│  ├── presto_player_presets (player presets)           │
│  ├── presto_player_audio_presets (audio presets)      │
│  ├── presto_player_visits (analytics)                │
│  ├── presto_player_email_collection (email settings) │
│  └── presto_player_webhooks (webhook config)         │
│                                                      │
│  WordPress Tables                                    │
│  ├── wp_posts (pp_video_block reusable videos)       │
│  └── wp_options (plugin settings, branding)          │
└──────────────────────────────────────────────────────┘
```

## Playback Flow (simplified)

```
Page loads with video block → Block render callback fires
  → Preset loaded from database → Attributes merged
  → <presto-player> web component rendered
  → Browser initializes Stencil.js player
  → Provider detected → YouTube/Vimeo/HTML5/HLS
  → Player ready → User clicks play
  → Analytics visit created via AJAX
  → Email collection / CTA triggers at configured time
```

## Where to Find Things in Code

| What | Where |
|------|-------|
| Plugin entry point | `presto-player.php` |
| Core singleton | `inc/Core.php` |
| Component registration | `inc/Controller.php` |
| DI container | `inc/Factory.php` |
| Block classes | `inc/Blocks/` |
| Data models | `inc/Models/` |
| REST API controllers | `inc/Services/API/` |
| Database schemas | `inc/Database/` |
| LMS integrations | `inc/Integrations/` |
| Script enqueuing | `inc/Services/Scripts.php` |
| Settings | `inc/Services/Settings.php` |
| Player web components | `packages/components/src/components/` |
| React admin UI | `src/admin/` |
