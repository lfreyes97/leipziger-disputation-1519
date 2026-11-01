# Pendiente: publicar los PDF como release (nota temporal)

Un *release* de GitHub es una versión etiquetada (tag) con archivos adjuntos.
Los PDF finales se publican ahí y no se guardan en el repo (`.gitignore` ya
ignora `build/` y `edicion/*.pdf`).

## Pasos

1. Compilar los PDF con Typst en `build/` (el flujo aún no existe).
2. En GitHub: **Releases → Draft a new release**.
3. Tag nuevo (p. ej. `v0.1.0`), destino la rama `typst`.
4. Título y notas; adjuntar los PDF.
5. Marcar **Set as a pre-release** mientras no haya revisión humana.

Con la CLI:

```
git tag v0.1.0 && git push origin v0.1.0
gh release create v0.1.0 build/*.pdf --prerelease \
  --title "v0.1.0 — borrador de IA" --notes-file NOTAS.md
```

## Decisiones

- Versión `v0.x` mientras no haya revisión humana; `v1.0` sería el hito de
  revisión completada.
- Las notas de cada release repiten el aviso de IA e indican qué es cada PDF
  (crítica o lectura, latina o española).
- `.../releases/latest` no cuenta los pre-releases: mientras todos lo sean,
  enlazar a la página de Releases o a un tag concreto.
- Crear el tag y el release es publicar: no se hace sin confirmación.

Borrar este archivo cuando el release esté hecho y documentado en el README.
