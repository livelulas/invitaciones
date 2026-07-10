function updateLanguageLinks() {
  const search = window.location.search
  const localPaths = window.location.hostname === "127.0.0.1" || window.location.hostname === "localhost"

  document.querySelectorAll("[data-language-link]").forEach((link) => {
    const target = link.dataset.languageTarget
    const href = localPaths && target === "es" ? "/elena-armando/" : link.getAttribute("href")
    const url = new URL(href, window.location.origin)
    url.search = search
    link.href = `${url.pathname}${url.search}${url.hash}`
  })
}

function publicAlternateUrl(path) {
  const alternateUrl = document.body.dataset.alternateLanguageUrl
  const localPaths = window.location.hostname === "127.0.0.1" || window.location.hostname === "localhost"

  if (localPaths && alternateUrl === "/" && path.startsWith("/en/")) return "/elena-armando/"
  return alternateUrl
}

function redirectForBrowserLanguage() {
  const language = document.body.dataset.language || "es"
  const path = window.location.pathname
  const isSpanishRoot = language.startsWith("es") && (path === "/" || path === "/elena-armando/")
  const alternateUrl = publicAlternateUrl(path)
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
