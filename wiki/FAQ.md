# Frequently Asked Questions

## General

**Q: What is Presto Player?**
A: A WordPress plugin that provides beautiful, fast video and audio players with Gutenberg blocks, customizable presets, analytics, and LMS integrations.

**Q: What video sources does it support?**
A: YouTube, Vimeo, self-hosted (MP4/WebM from media library), HLS streams, and Bunny CDN.

**Q: Does it work with any theme?**
A: Yes. Presto Player uses standard WordPress hooks and Gutenberg blocks that work with any block-compatible theme.

**Q: What's the difference between free and Pro?**
A: Pro adds email service integrations (ActiveCampaign, FluentCRM, Mailchimp, MailerLite), Bunny CDN integration, and additional premium features. Core playback, presets, and analytics are in the free version.

**Q: What are the minimum requirements?**
A: PHP 7.3+, WordPress 5.6+.

## Video Playback

**Q: Can I customize the player controls?**
A: Yes. Player presets let you toggle every control: play, rewind, fast-forward, progress bar, time display, mute, volume, speed, PiP, fullscreen, and captions.

**Q: Does it support captions/subtitles?**
A: Yes. WebVTT caption files are supported for self-hosted videos.

**Q: Can I use a poster/thumbnail image?**
A: Yes. Set a poster image that displays before the video plays. For YouTube/Vimeo, thumbnails are fetched automatically.

**Q: Does the player work on mobile?**
A: Yes. The player is fully responsive and adapts to any screen size.

**Q: Can I adjust playback speed?**
A: Yes. Enable the speed control in the preset to let viewers adjust playback rate.

## Presets

**Q: What are presets?**
A: Reusable player configurations that define controls, styling, CTAs, watermarks, and email collection settings. Apply a preset to any video block.

**Q: Can I have multiple presets?**
A: Yes. Create as many presets as needed for different use cases (e.g., marketing videos, course videos, podcasts).

**Q: How do I apply a preset to a video?**
A: In the block editor, select your video block and choose a preset from the sidebar settings panel.

## Reusable Videos

**Q: What are reusable videos?**
A: Videos saved as a custom post type (`pp_video_block`) that can be embedded on any page. Edit once, it updates everywhere.

**Q: What are instant video pages?**
A: Each reusable video gets its own standalone URL (like a regular WordPress post) for direct sharing.

## Analytics

**Q: What does analytics track?**
A: Video visits (who watched, how long, when) stored in the `presto_player_visits` database table.

**Q: Does it track anonymous visitors?**
A: Yes. Anonymous visitors are tracked by IP address with user_id set to 0.

**Q: Can I purge analytics data?**
A: Yes. Analytics data retention is configurable from the settings.

## Email Collection

**Q: How does email collection work?**
A: Configure it in a preset. When the video reaches a configured percentage, an email capture overlay appears. Gate mode pauses the video; overlay mode is non-blocking.

**Q: What email providers are supported?**
A: ActiveCampaign, FluentCRM, Mailchimp, and MailerLite (Pro required). Webhooks are also available for custom integrations.

## LMS Integration

**Q: How does LearnDash integration work?**
A: When a Presto Player video is in a LearnDash lesson, video progress is tracked. When the student watches a configured percentage, the lesson is automatically marked as complete.

**Q: Does it work with TutorLMS and LifterLMS?**
A: Yes. Both LMS platforms have dedicated integrations for video embedding and progress tracking.

## Page Builders

**Q: Does it work with Elementor?**
A: Yes. Presto Player has custom Elementor widgets for all video types.

**Q: Does it work with Beaver Builder and Divi?**
A: Yes. Custom modules are provided for both page builders.
