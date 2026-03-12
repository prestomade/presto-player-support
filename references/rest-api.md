# Presto Player REST API Reference

All endpoints use namespace `presto-player/v1`. Controllers are in `inc/Services/API/`. All routes require `upload_files` capability by default.

## Videos API

**Controller:** `RestVideosController`

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/videos` | Get all video records |
| POST | `/videos` | Create a new video record |
| GET | `/videos/{id}` | Get single video by ID |
| PUT | `/videos/{id}` | Update a video record |

**Fields:** `id`, `title`, `type`, `external_id`, `attachment_id`, `post_id`, `src`, `created_by`, `created_at`, `updated_at`, `deleted_at`

**Video types:** `youtube`, `vimeo`, `self-hosted`, `hls`, `bunny`

## Presets API

**Controller:** `RestPresetsController`

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/preset` | Get all player presets |
| POST | `/preset` | Create a new preset |
| GET | `/preset/{id}` | Get single preset by ID |
| PUT | `/preset/{id}` | Update a preset |
| DELETE | `/preset/{id}` | Delete a preset |

**Key fields:** `id`, `name`, `slug`, `icon`, `skin`, `controls` (play-large, rewind, play, fast-forward, progress, current-time, mute, volume, speed, pip, fullscreen, captions), `styling`, `cta`, `watermark`, `search`, `email_collection`, `action_bar`

## Audio Presets API

**Controller:** `RestAudioPresetsController`

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/audio-preset` | Get all audio presets |
| POST | `/audio-preset` | Create a new audio preset |
| GET | `/audio-preset/{id}` | Get single audio preset by ID |
| PUT | `/audio-preset/{id}` | Update an audio preset |
| DELETE | `/audio-preset/{id}` | Delete an audio preset |

**Key fields:** `id`, `name`, `slug`, `icon`, `skin`, audio-specific controls, `styling`, `cta`, `email_collection`, `action_bar`

## Settings API

**Controller:** `RestSettingsController`

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/settings` | Retrieve all plugin settings |
| PUT | `/settings` | Update plugin settings |

**Accessible settings:**

| Setting Key | Purpose |
|-------------|---------|
| `presto_player_branding` | Logo, custom CSS, player colors |
| `presto_player_youtube` | YouTube API key and settings |
| `presto_player_presets` | Preset configurations |
| `presto_player_audio_presets` | Audio preset configurations |
| `presto_player_instant_video_width` | Instant video page width |
| `presto_player_media_hub_sync_default` | Media hub sync default |
| `presto-player_usage_optin` | Usage tracking opt-in |

## Permission

All routes require `upload_files` capability. This means users need at minimum the Author role to access the API.

## Custom REST Fields

The `pp_video_block` post type has a custom `details` REST field that fetches associated video metadata from the `presto_player_videos` table.

## Key Files

| File | Purpose |
|------|---------|
| `inc/Services/API/RestVideosController.php` | Video CRUD handlers |
| `inc/Services/API/RestPresetsController.php` | Preset CRUD handlers |
| `inc/Services/API/RestAudioPresetsController.php` | Audio preset CRUD handlers |
| `inc/Services/API/RestSettingsController.php` | Settings read/write handlers |
