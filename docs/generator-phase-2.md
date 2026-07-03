# Generator fase 2

El kit v1 usa archivos manuales + `script/new_invitation.sh`.

## Generator Bridgetown (próximo paso)

Cuando haya 2+ invitaciones validadas, implementar:

```bash
bin/bridgetown apply livelulas:invitation slug --title "Nombre & Nombre"
```

### Archivos a generar

- `src/_data/invitations/{slug}.yml` (desde plantilla)
- `src/_invitations/{slug}.md`
- `frontend/styles/themes/{slug}.css`
- `src/images/invitations/{slug}/.keep`

### Implementación sugerida

1. Crear `plugins/builders/invitation_scaffold_builder.rb`
2. Registrar comando CLI con `Bridgetown::Commands::Registrations`
3. O usar script shell (`script/new_invitation.sh`) como MVP

El script shell cubre el 80% del valor sin mantener una gem.
