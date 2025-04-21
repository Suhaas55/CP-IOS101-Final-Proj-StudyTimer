//
//  README.md
//  CP-IOS101-FinalProjectStudyTimer
//
//  Created by Suhaas Achanta on 4/21/25.
//

# StudyTimer

Submitted by: **Suhaas Achanta**

**StudyTimer** is a sleek Pomodoro‑style focus timer that helps you work in concentrated 25‑minute “Focus” sprints followed by customizable breaks. It features a live circular progress ring, Start/Pause and Reset controls, and a Settings screen where you can adjust your work/break durations. Everything is wrapped in a dark‑mode interface.

Time spent: **10** hours total

---

## Required Features

- [x] Start / Pause a countdown timer
- [x] Reset the timer at any point
- [x] Automatically switch between “Focus” and “Break” modes when a session ends
- [x] Settings screen to customize work‐ and break‐lengths
- [x] Persist your chosen durations across app launches

## Optional Features

- [ ] Local notification when a session ends
- [ ] Haptic/vibration alerts
- [ ] Simple session history or weekly statistics

## Additional Features

- [x] Dark‑mode UI with styled buttons and shadows
- [x] Animated circular progress ring using Core Animation

---

## App Screens

1. **Timer Screen**
   - **modeLabel** at top shows “Focus” or “Break”
   - **timerLabel** in the center of a 250×250 circle
   - **Circular progress ring** animates as time elapses
   - **Start/Pause** and **Reset** buttons below
   - ⚙️ **Settings** button in top‑right

2. **Settings Screen**
   - Two text fields to enter **Focus** and **Break** durations (in minutes)
   - **Save** button to persist new values
   - Uses a navigation bar back button to return

---

## Navigation Flow

- **Tab / Root**: the Timer Screen
  - Tap ⚙️ → **Push** segue to Settings Screen
  - Back arrow pops back to Timer Screen

---

## Wireframes

(https://github.com/user-attachments/assets/7d567651-d868-4e4f-8a9f-3ada2271a1aa)



---

## Sprint Planning

### Sprint 1
**Goal:** Core timer functionality
**Tasks:**
- Build main UI: “Focus”/“Break” mode label, circular progress view, Start/Pause & Reset buttons
- Implement countdown logic and ring‑fill animation
- Wire up Start/Pause and Reset actions to update label, progress, and state

### Sprint 2
**Goal:** Settings and polish
**Tasks:**
- Create Settings screen to adjust focus & break durations
- Persist settings via `UserDefaults` and reload on app launch
- Style dark theme, shadows, fonts, and improve button appearance
- Add local notifications for session start/end


## Video Walkthrough

Here’s a quick demo of the core functionality in action:
[Demo Video](https://youtu.be/your-demo-link)

---

## Notes

- Rounded buttons and drop shadows added for polish
- `updateTimerLabel()` guards against unnecessary text updates to prevent blinking
- Used two `CAShapeLayer`s: one for the gray background ring, one for the colored progress ring
- Persisted settings via `UserDefaults`

---

## License

-
