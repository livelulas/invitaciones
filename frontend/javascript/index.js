import "$styles/index.css"

import { initCountdown } from "./countdown"
import { initGuestName } from "./guest_name"
import { initCalendarLinks } from "./calendar"
import { initScheduleVisibility } from "./schedule"
import { initLanguage } from "./language"

function boot() {
  initLanguage()
  initCountdown()
  initGuestName()
  initCalendarLinks()
  initScheduleVisibility()
}

if (document.readyState === "loading") {
  document.addEventListener("DOMContentLoaded", boot)
} else {
  boot()
}
