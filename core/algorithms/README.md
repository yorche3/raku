# Algorithms Pure — Raku

Implementaciones de la [Fase 1 — Algoritmos Puros](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-) en **Raku**: ordenamientos elementales, estructuras de datos propias, ordenamientos óptimos y distribuidos, y búsqueda.

Los módulos de esta fase trabajan sobre **arrays mutables localmente**: las funciones ordenan la copia local del parámetro y devuelven el array, y el caso nulo no es representable porque un parámetro `@array` no admite `Nil` (el compilador rechaza la llamada).

---

## 📂 Módulos / Modules

| Módulo | Especificación | Enfoque | Tests | Estado |
|--------|---------------|---------|:-----:|:------:|
| [`naive_sort/`](naive_sort/) | [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) | `prove6 -l t/` + módulo Test | 3 | ✅ |

---

## 📁 Estructura / Structure

```text
algorithms/
└── naive_sort/                      # 05_Naive_Sort
    ├── lib/
    │   └── NaiveSort.rakumod        # 3 funciones del contrato (is export)
    ├── t/
    │   └── naive_sort_tests.rakutest# 3 subtests × 7 casos
    ├── .gitignore                   # Ignora .precomp/
    └── README.md
```

---

## 🛠️ Patrón común / Common Pattern

| Característica | Descripción |
|---------------|-------------|
| **Runtime** | Rakudo (Raku v6.d), intérprete sin paso de compilación a un artefacto |
| **CLI** | `prove6 -l t/` desde la raíz del módulo (con `prove6` a secas también funciona, porque la suite usa `use lib 'lib'`) |
| **Andamiaje** | ✅ Estructura manual (`mkdir -p lib t`), la que ya usa [`foundations/numbers/`](../foundations/numbers/); no hay manifiesto de dependencias |
| **Framework de tests** | Módulo **Test**, incluido en Rakudo (`use Test;`, `plan`, `subtest`, `is-deeply`) |
| **Runner** | `prove6` (`App::Prove6`), que descubre `t/*.rakutest`; no hay archivo `run_tests` |
| **Separación** | `lib/` (módulo) ↔ `t/` (suites): el layout idiomático en lugar de `src/`+`test/` |
| **Carga del módulo** | `use lib 'lib';` + `use NaiveSort;` en la suite |
| **Modularidad** | `unit module NaiveSort;` + `is export` en cada sub; los helpers internos no se exportan |
| **Iteración** | Bucles `for` con rangos (`..`, `..^`) y `while`; Rakudo optimiza la recursión de cola |
| **Indexación** | Directa, 0-based (`@array[$i]`), con las cotas del pseudocódigo |
| **API** | Una función por algoritmo; el parámetro se llama `array` (el `arr` de la documentación) |
| **Mutabilidad** | Sin `is rw`, el parámetro `@array` es una copia local: la función ordena esa copia y devuelve el array; los tests ordenan un `clone` por caso |
| **Naming** | `kebab-case` en el código (`selection-sort`), con el nombre `snake_case` de la especificación conservado como nombre del `subtest` y en el mensaje del contrato |
| **Nulabilidad** | Un parámetro `@array` **no admite `Nil`** (error de compilación), así que el caso nulo no es representable y se omite |
| **Verificación estática** | `raku -c lib/… t/…`: el compilador informa de errores y avisos |
| **Rangos** | `1..0` es un rango **vacío** en Raku; cuidado con la diferencia entre `..^` (exclusivo) y `..` (inclusivo) al traducir cotas del pseudocódigo |
| **Artefactos** | `.precomp/` y `lib/.precomp/` — ignorados por el `.gitignore` del módulo |

---

## 🚀 Compilación rápida / Quick Build

```bash
# Naive Sort Tests
cd naive_sort
prove6 -l t/
```

---

## ▶️ Siguiente / Next

👉 Continúa con los módulos pendientes de esta fase en el [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).
👉 Continue with the pending modules of this phase in the [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).

---

*[← Volver a Core](../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
