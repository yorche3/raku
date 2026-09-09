# Calculator — Raku

Implementación de la especificación [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) en **Raku**, con el módulo **Test** (incluido en Rakudo) como framework de pruebas unitarias y **prove6** como runner.

Operaciones aritméticas básicas (`addition`, `subtraction`, `multiplication`, `division`, `modulus`) con implementaciones intuitivas y educativas, validadas mediante pruebas unitarias.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`lib/Calculator.rakumod`](lib/Calculator.rakumod) | Código fuente: módulo Raku con las 5 funciones exportadas. |
| [`t/calculator_test.rakutest`](t/calculator_test.rakutest) | Suite de pruebas: 5 tests con el módulo `Test`. |
| [`.gitignore`](.gitignore) | Ignora los artefactos precompilados (`.precomp/`). |

**Estructura de directorios esperada:**

```text
calculator/
├── lib/
│   └── Calculator.rakumod           # Código fuente
├── t/
│   └── calculator_test.rakutest     # Suite de pruebas
├── .gitignore
└── README.md                        # Este archivo
```

> **ES:** En Raku, la separación `src/`+`test/` de la especificación se traduce idiomáticamente a **`lib/` + `t/`** (módulos `.rakumod` y tests `.rakutest`), el layout estándar del ecosistema y el que prove6 descubre por defecto.
> **EN:** In Raku, the specification's `src/`+`test/` separation idiomatically becomes **`lib/` + `t/`** (`.rakumod` modules and `.rakutest` tests), the ecosystem's standard layout and what prove6 discovers by default.

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente, sin herramientas de scaffolding. Raku tiene un **sistema de módulos real**: `lib/Calculator.rakumod` declara `unit module Calculator` con funciones `is export`, y la suite las importa con `use lib 'lib'; use Calculator;`. Las pruebas usan el módulo **Test** de la biblioteca estándar (`plan` + `is`) y se ejecutan con **prove6** — el runner del ecosistema — por eso no se crea el `run_tests` del pseudocódigo (la especificación lo pide solo si el lenguaje no lo incluye).

**EN:** The project was created manually, without scaffolding tools. Raku has a **real module system**: `lib/Calculator.rakumod` declares `unit module Calculator` with `is export` functions, and the suite imports them with `use lib 'lib'; use Calculator;`. Tests use the standard library's **Test** module (`plan` + `is`) and run with **prove6** — the ecosystem's runner — that's why the pseudocode's `run_tests` is not created (the specification asks for it only if the language doesn't include one).

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p raku/core/foundations/unit_test/calculator/{lib,t}
   ```

2. Escribir `lib/Calculator.rakumod` y `t/calculator_test.rakutest`.

3. No se necesita ningún paso adicional de construcción o vinculación de dependencias.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración de build. El módulo se comparte mediante `unit module` + `is export`.

### `lib/Calculator.rakumod` — Implementaciones educativas

**ES:** Cada operación compleja se construye a partir de las simples (concepto que se explora a fondo en `04_Numbers`): `multiplication` suma repetidamente, `division` resta repetidamente y `modulus` reutiliza `division` y `multiplication`. Por eso **no** se usan los operadores `*`, `/` ni `%`/`mod`.

**EN:** Each complex operation is built from the simple ones (a concept explored in depth in `04_Numbers`): `multiplication` adds repeatedly, `division` subtracts repeatedly, and `modulus` reuses `division` and `multiplication`. That's why the operators `*`, `/` and `%`/`mod` are **not** used.

```raku
unit module Calculator;

sub addition($a, $b) is export {
  return $a + $b;
}

sub subtraction($a, $b) is export {
  return $a - $b;
}

sub multiplication($a, $b) is export {
  my $result = 0;
  for 1..$b {
    $result = addition($result, $a);
  }
  return $result;
}

sub division($a, $b) is export {
  my $quotient = 0;
  my $rest = $a;
  while $rest >= $b {
    $rest = subtraction($rest, $b);
    $quotient = addition($quotient, 1);
  }
  return $quotient;
}

sub modulus($a, $b) is export {
  my $q = division($a, $b);
  my $p = multiplication($q, $b);
  return subtraction($a, $p);
}
```

| Función | Implementación educativa |
|---------|-------------------------|
| `addition($a, $b)` | Suma directa (`+`) |
| `subtraction($a, $b)` | Resta directa (`-`) |
| `multiplication($a, $b)` | Suma repetitiva: `for 1..$b` suma `$a` a `$result` |
| `division($a, $b)` | Resta repetitiva: `while $rest >= $b` resta `$b` y cuenta |
| `modulus($a, $b)` | `$q = division($a, $b)`; `$p = multiplication($q, $b)`; `subtraction($a, $p)` |

### `t/calculator_test.rakutest` — Suite con el módulo Test

**ES:** La suite usa `plan 5` (declara 5 tests, uno por operación) y una función `is(got, expected, nombre)` por caso.

**EN:** The suite uses `plan 5` (declares 5 tests, one per operation) and one `is(got, expected, name)` function per case.

```raku
use Test;

use lib 'lib';
use Calculator;

plan 5;

is(addition(2, 3), 5, 'addition');
is(subtraction(5, 2), 3, 'subtraction');
is(multiplication(3, 4), 12, 'multiplication');
is(division(10, 3), 3, 'division');
is(modulus(10, 3), 1, 'modulus');
```

---

## 🚀 Compilación y ejecución / Build & Run

### Requisitos / Requirements

- **Rakudo** (`raku`).
- **prove6** (`App::Prove6`).

```bash
# Verificar instalación
raku --version
prove6 --version

# Instalar prove6 (si no está instalado)
zef install App::Prove6
rakubrew rehash
```

> **ES:** Si se instaló con `zef` dentro de rakubrew y `prove6` no aparece en el PATH, ejecuta `rakubrew rehash` para regenerar los shims.
> **EN:** If it was installed with `zef` inside rakubrew and `prove6` is not on the PATH, run `rakubrew rehash` to regenerate the shims.

### Ejecutar las pruebas / Run tests

Desde la raíz del proyecto:

```bash
cd raku/core/foundations/unit_test/calculator
prove6
```

### Salida esperada / Expected output

```text
t/calculator_test.rakutest ................ ok
All tests successful.
Files=1, Tests=5,  0 wallclock secs
Result: PASS
```

> **ES:** `Tests=5, Result: PASS` confirma que las 5 operaciones se verificaron correctamente (equivale al `Tests run: 5, Passed: 5, Failed: 0` de la especificación).
> **EN:** `Tests=5, Result: PASS` confirms that all 5 operations were verified correctly (equivalent to the specification's `Tests run: 5, Passed: 5, Failed: 0`).

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Raku usa módulos reales: `unit module Calculator` + `is export` exporta las funciones; `use lib 'lib'` añade el directorio al path de módulos.
- **EN:** Raku uses real modules: `unit module Calculator` + `is export` exports the functions; `use lib 'lib'` adds the directory to the module path.
- **ES:** La división por cero no se maneja en este ejemplo educativo (según el pseudocódigo de la especificación); las pruebas usan valores válidos.
- **EN:** Division by zero is not handled in this educational example (per the specification's pseudocode); tests use valid values.
- **ES:** Solo se usa la biblioteca estándar en el código fuente; `App::Prove6` es la única dependencia externa y únicamente como runner de pruebas.
- **EN:** Only the standard library is used in the source code; `App::Prove6` is the only external dependency and only as a test runner.
- **ES:** No se usa `run_tests` porque `prove6` ya es el punto de entrada del ecosistema (la especificación pide crearlo solo si el framework no lo incluye).
- **EN:** `run_tests` is not used because `prove6` is already the ecosystem's entry point (the specification asks to create it only if the framework doesn't include one).

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
