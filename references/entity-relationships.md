# Presto Player Entity Relationships

## Core Entities

### Video Record

Stored in custom table `presto_player_videos`.

```
Video Record
  |-- id (auto-increment)
  |-- title (video display name)
  |-- type ('youtube' | 'vimeo' | 'self-hosted' | 'hls' | 'bunny')
  |-- external_id (YouTube/Vimeo video ID)
  |-- attachment_id (WordPress media library ID, for self-hosted)
  |-- post_id (linked pp_video_block post ID)
  |-- src (video source URL)
  |-- created_by (WordPress user ID)
  |-- created_at (timestamp)
  |-- updated_at (timestamp)
  +-- deleted_at (soft delete timestamp)
```

### Preset (Player Configuration)

Stored in custom table `presto_player_presets`.

```
Preset
  |-- id (auto-increment)
  |-- name (preset display name)
  |-- slug (URL-safe identifier)
  |-- icon (preset icon identifier)
  |-- skin (player skin style)
  |-- Controls
  |     |-- play-large (large play button)
  |     |-- rewind (rewind button)
  |     |-- play (play/pause button)
  |     |-- fast-forward (fast-forward button)
  |     |-- progress (progress bar)
  |     |-- current-time (time display)
  |     |-- mute (mute button)
  |     |-- volume (volume slider)
  |     |-- speed (playback speed)
  |     |-- pip (picture-in-picture)
  |     |-- fullscreen (fullscreen toggle)
  |     +-- captions (captions toggle)
  |-- Styling (colors, borders, custom CSS)
  |-- CTA (call-to-action overlay settings)
  |-- Watermark (watermark image and position)
  |-- Search (in-player search settings)
  |-- Email Collection (email capture settings)
  +-- Action Bar (action bar settings)
```

### Audio Preset

Stored in custom table `presto_player_audio_presets`.

```
Audio Preset
  |-- id (auto-increment)
  |-- name, slug, icon, skin
  |-- Audio-specific controls
  |-- Styling
  |-- CTA
  |-- Email Collection
  +-- Action Bar
```

### Visit (Analytics)

Stored in custom table `presto_player_visits`.

```
Visit
  |-- id (auto-increment)
  |-- user_id (WordPress user ID, 0 for anonymous)
  |-- duration (seconds watched)
  |-- video_id (references presto_player_videos.id)
  |-- ip_address (visitor IP)
  |-- created_at (timestamp)
  |-- updated_at (timestamp)
  +-- deleted_at (soft delete timestamp)
```

### Email Collection

Stored in custom table `presto_player_email_collection`.

```
Email Collection
  |-- id (auto-increment)
  |-- enabled (boolean)
  |-- behavior ('gate' | 'overlay')
  |-- percentage (when to show, 0-100)
  |-- allow_skip (boolean)
  |-- headline (display text)
  |-- button_text (submit button label)
  |-- preset_id (linked preset)
  |-- email_provider ('activecampaign' | 'fluentcrm' | 'mailchimp' | 'mailerlite')
  |-- email_provider_list (provider list ID)
  +-- email_provider_tag (provider tag)
```

### Webhook

Stored in custom table `presto_player_webhooks`.

```
Webhook
  |-- id (auto-increment)
  |-- name (webhook display name)
  |-- url (destination URL)
  |-- method (HTTP method)
  |-- email_name (email field name)
  |-- headers (custom headers JSON)
  +-- created_by (WordPress user ID)
```

### Reusable Video Block (Custom Post Type)

Stored as WordPress post type `pp_video_block`.

```
Reusable Video Block (pp_video_block CPT)
  |-- WordPress post fields (ID, title, content, status)
  |-- post_content contains Gutenberg block markup
  |-- Linked to Video record via post_id field
  |-- Has post thumbnail (poster image)
  |-- Has tags for filtering
  +-- Instant video page (single post template)
```

## Database Tables

| Table | Purpose | Schema Version |
|-------|---------|---------------|
| `wp_presto_player_videos` | Video metadata & source info | 4 |
| `wp_presto_player_presets` | Player preset configurations | 22 |
| `wp_presto_player_audio_presets` | Audio player presets | 20 |
| `wp_presto_player_visits` | Video analytics/visit tracking | 1 |
| `wp_presto_player_email_collection` | Email collection settings | 1 |
| `wp_presto_player_webhooks` | Webhook configurations | 1 |

## WordPress Options

| Option Key | Purpose |
|------------|---------|
| `presto_player_branding` | Branding settings (logo, colors, CSS) |
| `presto_player_youtube` | YouTube API configuration |
| `presto_player_presets` | Preset configuration |
| `presto_player_audio_presets` | Audio preset configuration |
| `presto_player_instant_video_width` | Instant video page width |
| `presto_player_media_hub_sync_default` | Media hub sync preference |
| `presto-player_usage_optin` | Usage tracking opt-in |
