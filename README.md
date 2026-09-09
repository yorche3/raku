# Raku

Proyectos en **Raku** (implementado con Rakudo), con programas simples ejecutados
con el intérprete `raku` y proyectos con pruebas unitarias gestionados con el
módulo **Test** (incluido en Rakudo) y el runner **prove6**.

---

## 📂 Módulos / Modules

| Módulo | Descripción |
| ------ | ----------- |
| [`core/foundations/`](core/foundations/) | **Fase 0 — Fundamentos**: `helloworld`, `hellouser`, `unit_test/calculator`, `numbers` |

---

## ▶️ Comenzar / Getting Started

```bash
# Hello, World!
cd core/foundations/helloworld
raku hello_world.raku

# Hello, User!
cd core/foundations/hellouser
raku hello_user.raku

# Calculator Tests
cd core/foundations/unit_test/calculator
prove6

# Numbers Tests
cd core/foundations/numbers
prove6
```

---

## 📦 Requisitos / Requirements

| Herramienta | Instalación |
| ----------- | ----------- |
| [Rakudo](https://rakudo.org/) (Raku) | `sudo apt install rakudo` (Linux) / `rakubrew download 2026.07` + `rakubrew global 2026.07` |
| [prove6](https://github.com/Raku/prove6) (App::Prove6) | `zef install App::Prove6` + `rakubrew rehash` |

```bash
# Verificar instalación
raku --version
prove6 --version
```

> **ES:** El módulo `Test` viene incluido en Rakudo. Si instalas prove6 con `zef`
> dentro de rakubrew y no aparece en el PATH, ejecuta `rakubrew rehash`.
> **EN:** The `Test` module ships with Rakudo. If you install prove6 with `zef`
> inside rakubrew and it's not on the PATH, run `rakubrew rehash`.

---

## 🏗️ Tipos de proyecto / Project Types

### 1. Programa simple (interpretado con `raku`)

**ES:** Un único archivo fuente, sin dependencias externas, ejecutado directamente
con `raku`. Ideal para `helloworld` y `hellouser`. Solo requiere la biblioteca
estándar. Los scripts usan la extensión `.raku`.

**EN:** A single source file, no external dependencies, run directly with `raku`.
Ideal for `helloworld` and `hellouser`. Only the standard library is required.
Scripts use the `.raku` extension.

```bash
raku <File>.raku
```

### 2. Proyecto con pruebas unitarias (Test + prove6)

**ES:** Para proyectos que requieren pruebas unitarias, se usa el módulo **Test**
de la biblioteca estándar (`plan`, `is`, `subtest`) como framework y **prove6**
como runner. El código fuente se organiza en `lib/` (módulos `.rakumod` con
`unit module` + `is export`) y las pruebas en `t/` (ficheros `.rakutest`), el
layout estándar del ecosistema.

**EN:** For projects that require unit tests, the standard library's **Test**
module (`plan`, `is`, `subtest`) is used as the framework and **prove6** as the
runner. Source code goes in `lib/` (`.rakumod` modules with `unit module` +
`is export`) and tests in `t/` (`.rakutest` files), the ecosystem's standard
layout.

```bash
prove6                    # desde la raíz del proyecto (descubre t/)
```

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio
principal](https://github.com/yorche3/programming_languages) para ver todas las
versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*