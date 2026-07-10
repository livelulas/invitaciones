# Enlaces personalizados por invitado (Excel)

Cada invitado recibe un enlace único. Al abrirlo, la sección **Esta invitación es para** muestra su nombre.

Sin parámetro `?guest=` se muestra: **Nuestra familia y amigos**.

## Columnas del Excel

| Col | Campo |
|-----|-------|
| A | Total invitados |
| B | Contacto (teléfono) |
| C | Invitado #1 |
| D | Invitado #2 |
| E | Invitado #3 |
| F | Invitado #4 |
| G | Nombre (fórmula) |
| H | Enlace invitación (fórmula) |
| I | WhatsApp (opcional) |

## Para copiar y pegar

Pega en la **fila 2** y arrastra hacia abajo.

### G2 — nombre del invitado

```excel
=SI(C2="","",SI(D2="",C2,SI(E2="",C2&" y "&D2,SI(F2="",C2&", "&D2&" y "&E2,C2&", "&D2&", "&E2&" y "&F2))))
```

### H2 — enlace personalizado

```excel
="https://elena-y-armando.livelulas.com/?guest="&CODIFICARURL(G2)
```

### I2 — WhatsApp (opcional)

```excel
="https://wa.me/52"&B2&"?text="&CODIFICARURL("¡Hola! Cuenta conmigo para el gran día. - "&G2)
```

*(Excel en inglés: `IF`, `ENCODEURL`)*

### English Excel (row 2)

**G2 — guest name:**
```excel
=IF(C2="","",IF(D2="",C2,IF(E2="",C2&" y "&D2,IF(F2="",C2&", "&D2&" y "&E2,C2&", "&D2&", "&E2&" y "&F2))))
```

**H2 — invitation link:**
```excel
="https://elena-y-armando.livelulas.com/?guest="&ENCODEURL(G2)
```

**I2 — WhatsApp (optional):**
```excel
="https://wa.me/52"&B2&"?text="&ENCODEURL("¡Hola! Cuenta conmigo para el gran día. - "&G2)
```

## Ejemplos

| Invitados | Resultado en G |
|-----------|----------------|
| Carmen Avalos + Rafael Reyes | `Carmen Avalos y Rafael Reyes` |
| Adriana Reyes + Francisco Gonzalez | `Adriana Reyes y Francisco Gonzalez` |
| Jose + Magda + Lucia | `Jose Avalos, Magda Palacios y Lucia Avalos` |

## Probar un enlace

```
https://elena-y-armando.livelulas.com/?guest=Carmen%20Avalos%20y%20Rafael%20Reyes
```

Debe mostrar: **Esta invitación es para Carmen Avalos y Rafael Reyes**
