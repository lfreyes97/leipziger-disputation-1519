# Cómo contribuir

Las correcciones y las críticas son bienvenidas y se agradecen. Cada una que
se presente en un *issue* o en un PR recibe respuesta, y las que se aceptan se
registran en [`docs/AGRADECIMIENTOS.md`](docs/AGRADECIMIENTOS.md).

La transcripción y la traducción las hizo una IA y no han tenido revisión
humana sistemática (ver el [README](README.md)); por eso tu lectura del
facsímil es útil.

## Reportar una errata (issue)

Usa la plantilla «Errata». Indica:

1. La **página impresa** de Seitz (no la del PDF: PDF = impresa + 8).
2. La línea o la palabra afectada.
3. Lo que dice este repositorio y lo que dice el facsímil.
4. Si es de transcripción (latín), de traducción (español) o de una nota.

Si una palabra del facsímil es dudosa, dilo en lugar de adivinar.

## Proponer una corrección (PR)

- Edita el Markdown fuente: `transcripcion/pp-PPP.md` o `traduccion/trad-pp-PPP.md`.
  Las pp. 55–64 están en `transcripcion/test-p0*.md` y `traduccion/trad-t0*.md`.
- No edites a mano `edicion/lotes/` ni `edicion/fragmentos/`: son derivados y
  se regeneran con `scripts/construir.sh`.
- Respeta `docs/CONVENCIONES.md` (claves de nota, aparato, erratas del impreso).
- Una corrección por commit o, como mínimo, una por tema, con la página en el
  mensaje.

## Licencia

Al contribuir aceptas que tu aportación se publique bajo CC0 1.0, como el
resto del repositorio.
