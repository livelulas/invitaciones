import "$styles/index.css"

import { initCountdown } from "./countdown"
import { initGuestName } from "./guest_name"
import { initCalendarLinks } from "./calendar"

function boot() {
  initCountdown()
  initGuestName()
  initCalendarLinks()
}

if (document.readyState === "loading") {
  document.addEventListener("DOMContentLoaded", boot)
} else {
  boot()
}
