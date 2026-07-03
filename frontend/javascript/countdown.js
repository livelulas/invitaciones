function updateCountdown(section) {
  const eventDate = section.dataset.eventDate
  if (!eventDate) return

  const target = new Date(eventDate).getTime()
  const now = Date.now()
  const distance = Math.max(target - now, 0)

  const days = Math.floor(distance / (1000 * 60 * 60 * 24))
  const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60))
  const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60))
  const seconds = Math.floor((distance % (1000 * 60)) / 1000)

  const daysEl = section.querySelector("[data-countdown-days]")
  const hoursEl = section.querySelector("[data-countdown-hours]")
  const minutesEl = section.querySelector("[data-countdown-minutes]")
  const secondsEl = section.querySelector("[data-countdown-seconds]")

  if (daysEl) daysEl.textContent = String(days)
  if (hoursEl) hoursEl.textContent = String(hours).padStart(2, "0")
  if (minutesEl) minutesEl.textContent = String(minutes).padStart(2, "0")
  if (secondsEl) secondsEl.textContent = String(seconds).padStart(2, "0")
}

export function initCountdown() {
  const sections = document.querySelectorAll("[data-event-date]")
  if (!sections.length) return

  sections.forEach(updateCountdown)
  window.setInterval(() => sections.forEach(updateCountdown), 1000)
}
