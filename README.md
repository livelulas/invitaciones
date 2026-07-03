# Live Lulas Invitations

Kit Bridgetown para invitaciones digitales de [Live Lulas](https://livelulas.com).

## Primera invitación

- [Elena & Armando](/elena-armando/) — `src/_data/invitations/elena-armando.yml`

## Desarrollo

```bash
bundle install
npm install
bin/bridgetown frontend:build
bin/bridgetown start
```

Abrir: http://localhost:4000/elena-armando/

Con invitado personalizado:

```
http://localhost:4000/elena-armando/?guest=Adriana%20y%20Francisco
```

## Estructura

```text
src/_data/invitations/     # Contenido y tema por invitación (YAML)
src/_invitations/          # Collection entries
src/_components/invitation/ # Componentes reusables
frontend/styles/           # CSS base + temas
frontend/javascript/       # Countdown + guest name
```

## Documentación

- [Crear nueva invitación](docs/new-invitation.md)
- [Deploy Cloudflare Pages](docs/deploy-cloudflare.md)
- [Generator fase 2](docs/generator-phase-2.md)

## Build producción

```bash
bin/bridgetown frontend:build
BRIDGETOWN_ENV=production bin/bridgetown build
```

Output en `output/`.
