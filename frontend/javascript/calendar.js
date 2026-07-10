function isAppleDevice() {
  return /iPad|iPhone|iPod|Macintosh|Mac OS X/.test(navigator.userAgent)
}

export function initCalendarLinks() {
  document.querySelectorAll("[data-calendar-link]").forEach((link) => {
    link.addEventListener("click", (event) => {
      const webcalUrl = link.dataset.webcalUrl
      const googleUrl = link.dataset.googleUrl || link.getAttribute("href")

      if (isAppleDevice() && webcalUrl) {
        event.preventDefault()
        window.location.href = webcalUrl
        return
      }

      if (!googleUrl) return

      event.preventDefault()
      window.open(googleUrl, "_blank", "noopener,noreferrer")
    })
  })
}
