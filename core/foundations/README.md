# 🚀 Fundamentos / Foundations — Raku

Implementación de los ejercicios de la sección [Fundamentos / Foundations](https://yorche3.github.io/programming_languages/core/foundations/) del repositorio principal en **Raku**.

---

## 📖 Descripción / Description

**ES:** Esta sección reúne los conceptos esenciales para empezar a trabajar con **Raku**. Cubre desde los programas más básicos (`Hello, World!` y `Hello, User!`) hasta la implementación de una calculadora con pruebas unitarias y algoritmos numéricos en tres enfoques progresivos (recursivo directo, recursivo con acumulador e iterativo).

**EN:** This section brings together the essential concepts to start working with **Raku**. It covers everything from the most basic programs (`Hello, World!` and `Hello, User!`) to the implementation of a calculator with unit tests and numerical algorithms in three progressive approaches (direct recursion, accumulator recursion, and iterative).

---

## 📁 Estructura / Structure

```text
raku/
└── core/
    └── foundations/
        ├── README.md              # Este archivo / This file
        ├── helloworld/            # 01_Hello_World — Primer programa
        │   ├── hello_world.raku
        │   └── README.md
        ├── hellouser/             # 02_Hello_User — Entrada y salida
        │   ├── hello_user.raku
        │   └── README.md
        ├── unit_test/
        │   └── calculator/        # 03_Unit_Test_Calculator — Pruebas unitarias
        │       ├── lib/
        │       │   └── Calculator.rakumod
        │       ├── t/
        │       │   └── calculator_test.rakutest
        │       ├── .gitignore
        │       └── README.md
        └── numbers/               # 04_Numbers — Algoritmos numéricos
            ├── lib/
            │   └── Numbers.rakumod
            ├── t/
            │   ├── recursive_tests.rakutest
            │   ├── recursive_with_acc_tests.rakutest
            │   └── iterative_tests.rakutest
            ├── .gitignore
            └── README.md
```

---

## 🔢 Progresión / Progression

| Especificación | Proyecto | Conceptos | Tests | Dependencias externas |
| -------------- | -------- | --------- | :---: | :-------------------: |
| [`01_Hello_World`](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) | [`helloworld/`](helloworld/) | `say`, sigilos, ejecución con `raku` | — | ❌ Solo stdlib |
| [`02_Hello_User`](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) | [`hellouser/`](hellouser/) | `my $var`, `$*IN.get`, interpolación `"..."` | — | ❌ Solo stdlib |
| [`03_Unit_Test_Calculator`](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) | [`unit_test/calculator/`](unit_test/calculator/) | Módulo `Test`, `plan`/`is`, `unit module`, prove6 | 5 | ❌ `Test` incluido; prove6 solo runner |
| [`04_Numbers`](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) | [`numbers/`](numbers/) | Recursión, acumuladores, bucles, TCO, `subtest` | 15 (33 casos) | ❌ `Test` incluido; prove6 solo runner |

---

## 🛠️ Enfoque general / General Approach

**ES:** Los proyectos en esta sección siguen un patrón progresivo:

1. **Hello World** y **Hello User**: Programas de un solo archivo `.raku`, ejecutados directamente con `raku`. Usan exclusivamente la biblioteca estándar.
2. **Calculator**: Primer proyecto con pruebas unitarias (**módulo Test**, incluido en Rakudo) ejecutadas con **prove6**. Introduce el sistema de módulos de Raku (`unit module` + `is export`), el layout idiomático `lib/` + `t/` y la función `plan`/`is`.
3. **Numbers**: Expande el patrón a tres suites con `subtest` (uno por función). **Rakudo optimiza la auto-recursión de cola (TCO)** y tiene bucles nativos, por lo que se prueban los tres enfoques: `_rec` + `_acc` + `_ite` = 15 tests (33 casos).

**EN:** The projects in this section follow a progressive pattern:

1. **Hello World** and **Hello User**: Single-file `.raku` programs, run directly with `raku`. Use only the standard library.
2. **Calculator**: First project with unit tests (**Test module**, bundled with Rakudo) run by **prove6**. Introduces Raku's module system (`unit module` + `is export`), the idiomatic `lib/` + `t/` layout, and the `plan`/`is` functions.
3. **Numbers**: Expands the pattern to three suites with `subtest` (one per function). **Rakudo optimizes self-recursive tail calls (TCO)** and has native loops, so all three approaches are tested: `_rec` + `_acc` + `_ite` = 15 tests (33 cases).

---

## 🚀 Ejecución rápida / Quick Start

### Hello World

```bash
cd raku/core/foundations/helloworld
raku hello_world.raku
```

### Hello User

```bash
cd raku/core/foundations/hellouser
raku hello_user.raku
```

### Calculator (pruebas)

```bash
cd raku/core/foundations/unit_test/calculator
prove6
```

### Numbers (pruebas)

```bash
cd raku/core/foundations/numbers
prove6
```

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
