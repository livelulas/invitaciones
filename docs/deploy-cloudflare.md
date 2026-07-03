# Deploy en Cloudflare Pages

## Configuración

| Campo | Valor |
|---|---|
| Build command | `bundle install && npm install && bin/bridgetown frontend:build && BRIDGETOWN_ENV=production bin/bridgetown build` |
| Build output directory | `output` |
| Root directory | `/` (repo root) |

## Variables de entorno

Ninguna requerida para v1 (sitio estático).

## Ruby

Cloudflare Pages soporta Ruby via `RUBY_VERSION` en variables de entorno o `.ruby-version` (3.4.1).

## Node

Requerido para `frontend:build`. Usar Node 20+.

## Dominio

Opciones:

- Subdominio: `elena-armando.livelulas.com`
- Path: `livelulas.com/elena-armando/` (requiere `base_path` en config)

## Preview local de producción

```bash
bundle install
bin/bridgetown frontend:build
BRIDGETOWN_ENV=production bin/bridgetown build
npx serve output
```

## Notas

- El build de frontend requiere Node 20+. En Node 20.12, `esbuild.config.js` incluye un polyfill para `fs.globSync`.
- Las imágenes en `src/images/` se copian automáticamente a `output/images/`.
