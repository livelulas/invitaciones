export function initGuestName() {
  const params = new URLSearchParams(window.location.search)
  const guest = params.get("guest")
  const elements = document.querySelectorAll("[data-guest-name]")

  elements.forEach((element) => {
    element.textContent = guest || "Nuestra familia y amigos"
  })
}
