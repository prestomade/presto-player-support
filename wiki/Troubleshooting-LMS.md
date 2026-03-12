# Troubleshooting LMS Integration

## How LMS Integration Works

Presto Player integrates with LearnDash, TutorLMS, and LifterLMS to track video progress within course lessons. When a student watches a video to a configured completion percentage, the lesson can be auto-completed. Progress is tracked via cookies.

**Key files**: `inc/Integrations/LearnDash/`, `inc/Integrations/Tutor/`, `inc/Integrations/Lifter/`

## Quick Diagnosis

Ask the customer:
1. Which LMS are they using (LearnDash, TutorLMS, or LifterLMS)?
2. Is the Presto Player video embedded in a lesson?
3. Is auto-complete configured? What's the completion percentage?
4. Is the student logged in?
5. Does the issue affect all students or specific ones?

---

## Common Issues

### LearnDash Lesson Not Auto-Completing

**Symptoms**: Student watches the entire video but the lesson isn't marked as complete.

**Common causes**:
- Auto-complete not enabled in video/lesson settings
- Completion threshold not met (e.g., student skipped portions)
- Cookie blocked by browser (progress tracking uses cookies)
- Video not properly detected as a Presto Player video in the lesson
- LearnDash "Video Progression" feature conflicting with Presto Player

**What to check**:
1. Is auto-complete enabled in the video block settings within the lesson?
2. What is the completion percentage threshold?
3. Are cookies enabled in the student's browser?
4. Is the video embedded using a Presto Player block (not a generic video block)?
5. Is LearnDash's built-in video progression also enabled? (May conflict)
6. Check the cookie key for the video/lesson/user combination

**Fix**: Enable auto-complete. Lower the completion threshold. Ensure cookies are allowed. Disable LearnDash's built-in video progression if using Presto Player's.

---

### Video Progress Not Tracking

**Symptoms**: Student watches the video but progress bar/indicator doesn't update.

**Common causes**:
- Cookie-based tracking blocked by browser privacy settings
- Third-party cookie restrictions (if video served from different domain)
- JavaScript error in progress tracking code
- Student using private/incognito mode (cookies cleared on close)

**What to check**:
1. Check browser cookie settings -- are third-party cookies allowed?
2. Is the student in incognito mode?
3. Check browser console for JavaScript errors
4. Is the video on the same domain as the WordPress site?

**Fix**: Enable cookies. Use same-domain video hosting. Don't use incognito for tracked progress.

---

### Wrong Lesson Marked Complete

**Symptoms**: A different lesson is marked complete than the one the student is watching.

**Common causes**:
- Video reused across multiple lessons without unique tracking
- Cookie key collision between lessons
- Block attributes not properly linking to the lesson

**What to check**:
1. Is the same reusable video block used in multiple lessons?
2. Check cookie keys -- are they unique per lesson?
3. Is the video properly embedded in the correct lesson?

**Fix**: Ensure each lesson uses a unique video instance or that tracking keys are unique per lesson.

---

### TutorLMS / LifterLMS Integration Not Working

**Symptoms**: Video plays in lessons but no progress tracking or auto-complete.

**Common causes**:
- LMS plugin not active or outdated
- Integration not loaded (Presto Player checks if LMS is active)
- Incompatible LMS version
- Video not embedded with Presto Player block

**What to check**:
1. Is the LMS plugin active and up to date?
2. Is the video embedded using a Presto Player Gutenberg block?
3. Check Presto Player integration code in `inc/Integrations/` for version requirements
4. Are there JavaScript errors?

**Fix**: Update both plugins. Embed video using Presto Player block. Check for version compatibility.

---

## Escalation Criteria

Escalate to engineering if:
- Cookie-based tracking logic has a bug (wrong keys, wrong values)
- Auto-complete fires at wrong percentage
- Integration hooks not firing despite correct configuration
- LMS API changed after update and integration broke
