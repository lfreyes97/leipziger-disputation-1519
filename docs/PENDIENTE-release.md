# Pendiente: publicar los PDF como release (nota temporal)

Un *release* de GitHub es una versión etiquetada (tag) con archivos adjuntos.
Los PDF finales se publican ahí y no se guardan en el repo (`.gitignore` ya
ignora `build/` y `edicion/*.pdf`).

## Pasos

1. `git push origin typst` (y el resto de ramas, si se quiere).
2. `scripts/preparar-release.sh v0.1.0`: compila las dos ediciones en español y deja en
   `build/release/` los PDF con nombre de descarga legible, `SHA256SUMS.txt` y `NOTAS.md`.
3. Publicar (esto sí publica; no se hace sin confirmación):

```
git tag v0.1.0 && git push origin v0.1.0
gh release create v0.1.0 build/release/*.pdf build/release/SHA256SUMS.txt \
  --target typst --prerelease \
  --title "v0.1.0 — borrador de IA" --notes-file build/release/NOTAS.md
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
