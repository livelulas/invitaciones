# Crear una nueva invitación

Checklist para agregar una invitación al kit `livelulas`.

## 1. Datos

Copiar la plantilla:

```bash
cp src/_data/invitations/elena-armando.yml src/_data/invitations/nuevo-evento.yml
```

Editar:

- `slug`, `title`, `date`, `rsvp_deadline`
- `theme.fonts`, `theme.colors`, `theme.typography`
- `sections.*` (habilitar/deshabilitar, colores, imágenes)
- `content.*` (textos, itinerario, hospedaje, regalo)

## 2. Collection entry

Crear `src/_invitations/nuevo-evento.md`:

```yaml
---
layout: invitation
slug: nuevo-evento
title: Nombre & Nombre
---
```

La URL será `/nuevo-evento/`.

## 3. Tema CSS

Copiar y adaptar:

```bash
cp frontend/styles/themes/elena-armando.css frontend/styles/themes/nuevo-evento.css
```

Importar en `frontend/styles/index.css`:

```css
@import "./themes/nuevo-evento.css";
```

Agregar clase `theme-nuevo-evento` al body (automático desde el layout usando `slug`).

## 4. Assets

```bash
mkdir -p src/images/invitations/nuevo-evento
```

Agregar fotos, fondos y ornamentos. Las secciones funcionan sin imagen usando `background_color` del tema.

## 5. Convenciones YAML

| Campo | Comportamiento |
|---|---|
| `background_color: null` | Usa color por defecto del componente (`bg` o `bg_alt`) |
| `background_image: null` | Solo fondo de color |
| `sections.*.enabled: false` | Oculta la sección |

## 6. Personalización de invitado

```
/nuevo-evento/?guest=María%20y%20Juan
```

## 7. Build local

```bash
bin/bridgetown frontend:build
bin/bridgetown build
bin/bridgetown start
```

## 8. QA visual

Comparar cada sección contra el diseño Canva (desktop y mobile 375px).

## Generator (fase 2)

Cuando el patrón esté validado, usar:

```bash
./script/new_invitation.sh slug "Nombre & Nombre"
```

Ver `docs/generator-phase-2.md` para el generator Bridgetown formal.
