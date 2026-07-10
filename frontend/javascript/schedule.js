export function initScheduleVisibility() {
  const params = new URLSearchParams(window.location.search)
  const showCivil = params.get("civil") === "true"

  document.querySelectorAll("[data-schedule-civil-row]").forEach((row) => {
    row.dataset.showCivil = String(showCivil)
  })
}
