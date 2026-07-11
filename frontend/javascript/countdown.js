function updateCountdown(section) {
  const eventDate = section.dataset.eventDate
  if (!eventDate) return

  const targetDate = new Date(eventDate)
  const nowDate = new Date()

  const labelEl = section.querySelector("[data-countdown-label]")
  const valueEl = section.querySelector("[data-countdown-value]")
  const daysEl = section.querySelector("[data-countdown-days]")

  const targetDay = new Date(targetDate.getFullYear(), targetDate.getMonth(), targetDate.getDate())
  const today = new Date(nowDate.getFullYear(), nowDate.getMonth(), nowDate.getDate())
  const nextDay = new Date(targetDay)
  nextDay.setDate(targetDay.getDate() + 1)
  const dayDistance = Math.max(targetDay.getTime() - today.getTime(), 0)
  const days = Math.floor(dayDistance / (1000 * 60 * 60 * 24))

  if (nowDate >= targetDay && nowDate < nextDay) {
    if (labelEl) labelEl.textContent = ""
    if (valueEl) valueEl.textContent = valueEl.parentElement.dataset.eventTodayMessage || "HOY ES EL GRAN DÍA"
    return
  }

  if (nowDate >= nextDay) {
    if (labelEl) labelEl.textContent = ""
    if (valueEl) valueEl.textContent = valueEl.parentElement.dataset.eventPastMessage || "Gracias por acompañarnos."
    return
  }

  if (daysEl) daysEl.textContent = String(days)
}

export function initCountdown() {
  const sections = document.querySelectorAll("[data-event-date]")
  if (!sections.length) return

  sections.forEach(updateCountdown)
  window.setInterval(() => sections.forEach(updateCountdown), 1000)
}
