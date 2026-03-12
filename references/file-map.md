# Presto Player File Map

## Where to Find Things in Code

| Concept | Location |
|---------|----------|
| Plugin entry point | `presto-player.php` |
| Core singleton | `inc/Core.php` |
| Component registration | `inc/Controller.php` |
| DI container config | `inc/Factory.php` |
| Plugin version & pro checks | `inc/Plugin.php` |
| Activation hooks | `inc/Activator.php` |
| Deactivation/uninstall | `inc/Deactivator.php` |
| Component config array | `inc/config/app.php` |
| YouTube block | `inc/Blocks/YouTubeBlock.php` |
| Vimeo block | `inc/Blocks/VimeoBlock.php` |
| Self-hosted block | `inc/Blocks/SelfHostedBlock.php` |
| Audio block | `inc/Blocks/AudioBlock.php` |
| Popup block | `inc/Blocks/PopupBlock.php` |
| Popup trigger block | `inc/Blocks/PopupTriggerBlock.php` |
| Popup media block | `inc/Blocks/PopupMediaBlock.php` |
| Reusable video block | `inc/Blocks/ReusableVideoBlock.php` |
| Reusable edit block | `inc/Blocks/ReusableEditBlock.php` |
| Media hub block | `inc/Blocks/MediaHubBlock.php` |
| Base model (ORM) | `inc/Models/Model.php` |
| Video model | `inc/Models/Video.php` |
| Preset model | `inc/Models/Preset.php` |
| Audio preset model | `inc/Models/AudioPreset.php` |
| Email collection model | `inc/Models/EmailCollection.php` |
| Reusable video model | `inc/Models/ReusableVideo.php` |
| Webhook model | `inc/Models/Webhook.php` |
| Player model | `inc/Models/Player.php` |
| Settings model | `inc/Models/Setting.php` |
| Current user model | `inc/Models/CurrentUser.php` |
| Videos REST API | `inc/Services/API/RestVideosController.php` |
| Presets REST API | `inc/Services/API/RestPresetsController.php` |
| Audio presets REST API | `inc/Services/API/RestAudioPresetsController.php` |
| Settings REST API | `inc/Services/API/RestSettingsController.php` |
| Script/style enqueuing | `inc/Services/Scripts.php` |
| Settings registration | `inc/Services/Settings.php` |
| Admin menu | `inc/Services/Menu.php` |
| Video post type | `inc/Services/VideoPostType.php` |
| Block registration | `inc/Services/Blocks.php` |
| Shortcodes | `inc/Services/Shortcodes.php` |
| Migrations | `inc/Services/Migrations.php` |
| Reusable videos | `inc/Services/ReusableVideos.php` |
| Admin notices | `inc/Services/AdminNotices.php` |
| AJAX actions | `inc/Services/AjaxActions.php` |
| Streamer (video streaming) | `inc/Services/Streamer.php` |
| Translation/i18n | `inc/Services/Translation.php` |
| Usage tracking | `inc/Services/Usage.php` |
| Pro compatibility | `inc/Services/ProCompatibility.php` |
| Preload service | `inc/Services/PreloadService.php` |
| Rewrite rules | `inc/Services/RewriteRulesManager.php` |
| YouTube block service | `inc/Services/Blocks/YoutubeBlockService.php` |
| Vimeo block service | `inc/Services/Blocks/VimeoBlockService.php` |
| Popup trigger service | `inc/Services/Blocks/PopupTriggerService.php` |
| Videos table schema | `inc/Database/Videos.php` |
| Presets table schema | `inc/Database/Presets.php` |
| Audio presets table schema | `inc/Database/AudioPresets.php` |
| Visits table schema | `inc/Database/Visits.php` |
| Email collection table schema | `inc/Database/EmailCollection.php` |
| Webhooks table schema | `inc/Database/Webhooks.php` |
| Database migrations | `inc/Database/Migrations.php` |
| Database upgrades | `inc/Database/Upgrades/` |
| LearnDash integration | `inc/Integrations/LearnDash/` |
| TutorLMS integration | `inc/Integrations/Tutor/` |
| LifterLMS integration | `inc/Integrations/Lifter/` |
| Elementor integration | `inc/Integrations/Elementor/` |
| Beaver Builder integration | `inc/Integrations/BeaverBuilder/` |
| Divi integration | `inc/Integrations/Divi/` |
| Kadence integration | `inc/Integrations/Kadence.php` |
| Playlist handling | `inc/Playlist.php` |
| Attachment handling | `inc/Attachment.php` |
| File operations | `inc/Files.php` |
| Utility functions | `inc/Support/Utility.php` |
| Service interface | `inc/Contracts/Service.php` |
| Block interface | `inc/Contracts/Block.php` |
| Integration interface | `inc/Contracts/Integration.php` |

## Directory Structure

```
presto-player/
├── presto-player.php              # Main plugin file (constants, version)
├── inc/                           # PHP Backend (PSR-4 autoloaded)
│   ├── Blocks/                    # Gutenberg block classes (10 blocks)
│   ├── Contracts/                 # Interface definitions
│   ├── Database/                  # Custom table schemas & migrations
│   │   └── Upgrades/             # Database upgrade handlers
│   ├── Integrations/              # LMS & page builder integrations
│   │   ├── BeaverBuilder/
│   │   ├── Divi/
│   │   ├── Elementor/
│   │   ├── LearnDash/
│   │   ├── Lifter/
│   │   └── Tutor/
│   ├── Libraries/                 # External PHP libraries
│   ├── Models/                    # ORM-like data models
│   ├── Seeds/                     # Data seeding
│   ├── Services/                  # Service components
│   │   ├── API/                   # REST API controllers
│   │   └── Blocks/                # Block-specific services
│   ├── Support/                   # Base classes & utilities
│   ├── config/                    # Component configuration
│   └── lib/                       # Additional libraries
├── src/                           # Frontend source (React/JS)
│   ├── admin/                     # Admin UI
│   │   ├── analytics/             # Analytics dashboard
│   │   ├── blocks/                # Block editor components
│   │   ├── integrations/          # Page builder integration UI
│   │   ├── settings/              # Settings pages
│   │   └── ui/                    # Shared admin UI components
│   ├── player/                    # Player components
│   ├── shared/                    # Shared utilities
│   ├── hooks/                     # React hooks
│   └── router/                    # Page routing
├── packages/                      # Yarn workspace packages
│   ├── components/                # Stencil.js web components (player)
│   └── components-react/          # React wrappers for player
├── dist/                          # Compiled assets
├── vendor/                        # PHP dependencies (Composer)
├── templates/                     # PHP template files
├── layouts/                       # Layout templates
├── languages/                     # Translation files
└── img/                           # Image assets
```
