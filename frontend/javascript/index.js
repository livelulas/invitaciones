import "$styles/index.css"

import { initCountdown } from "./countdown"
import { initGuestName } from "./guest_name"
import { initCalendarLinks } from "./calendar"

document.addEventListener("DOMContentLoaded", () => {
  initCountdown()
  initGuestName()
  initCalendarLinks()
})
