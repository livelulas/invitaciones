import "$styles/index.css"

import { initCountdown } from "./countdown"
import { initGuestName } from "./guest_name"

document.addEventListener("DOMContentLoaded", () => {
  initCountdown()
  initGuestName()
})
