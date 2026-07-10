function updateLanguageLinks() {
  const search = window.location.search

  document.querySelectorAll("[data-language-link]").forEach((link) => {
    const url = new URL(link.getAttribute("href"), window.location.origin)
    url.search = search
    link.href = `${url.pathname}${url.search}${url.hash}`
  })
}

function redirectForBrowserLanguage() {
  const language = document.body.dataset.language || "es"
  const alternateUrl = document.body.dataset.alternateLanguageUrl
  const path = window.location.pathname
  const isSpanishRoot = language.startsWith("es") && (path === "/" || path === "/elena-armando/")
  const prefersEnglish = navigator.languages?.some((language) => language.toLowerCase().startsWith("en"))

  if (!isSpanishRoot || !alternateUrl || !prefersEnglish) return
  if (window.sessionStorage.getItem("invitation-language-redirected") === "true") return

  window.sessionStorage.setItem("invitation-language-redirected", "true")
  window.location.replace(`${alternateUrl}${window.location.search}${window.location.hash}`)
}

export function initLanguage() {
  updateLanguageLinks()
  redirectForBrowserLanguage()
}
