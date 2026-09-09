# Numbers — Raku

Implementación de la especificación [04_Numbers](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) en **Raku**, con el módulo **Test** (incluido en Rakudo) como framework de pruebas unitarias y **prove6** como runner.

Tres enfoques de implementación para los mismos 5 algoritmos: **recursivo directo** (`_rec`), **recursivo con acumulador** (`_acc`) e **iterativo** (`_ite`).

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`lib/Numbers.rakumod`](lib/Numbers.rakumod) | Módulo `Numbers` — único archivo con las 15 funciones (3 enfoques × 5 algoritmos) + 4 helpers `_help` privados. |
| [`t/recursive_tests.rakutest`](t/recursive_tests.rakutest) | Suite recursiva: 5 subtests (11 casos). |
| [`t/recursive_with_acc_tests.rakutest`](t/recursive_with_acc_tests.rakutest) | Suite con acumulador: 5 subtests (11 casos). |
| [`t/iterative_tests.rakutest`](t/iterative_tests.rakutest) | Suite iterativa: 5 subtests (11 casos). |
| [`.gitignore`](.gitignore) | Ignora los artefactos precompilados (`.precomp/`). |

**Estructura de directorios esperada:**

```text
numbers/
├── lib/
│   └── Numbers.rakumod                  # Único archivo: 3 enfoques en 1
├── t/
│   ├── recursive_tests.rakutest         # Tests: enfoque recursivo
│   ├── recursive_with_acc_tests.rakutest# Tests: enfoque con acumulador
│   └── iterative_tests.rakutest         # Tests: enfoque iterativo
├── .gitignore
└── README.md                            # Este archivo
```

> **ES:** En Raku, la separación `src/`+`test/` de la especificación se traduce idiomáticamente a **`lib/` + `t/`**, el layout estándar del ecosistema y el que prove6 descubre por defecto.
> **EN:** In Raku, the specification's `src/`+`test/` separation idiomatically becomes **`lib/` + `t/`**, the ecosystem's standard layout and what prove6 discovers by default.

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto usa el mismo patrón que `calculator`: módulo con `unit module` + `is export` y suites con el módulo **Test** ejecutadas por **prove6**. Las 15 funciones se organizan en 3 grupos por enfoque:

**EN:** This project uses the same pattern as `calculator`: a module with `unit module` + `is export` and **Test**-module suites run by **prove6**. The 15 functions are organized into 3 groups by approach:

| Enfoque | Sufijo | Ejemplo | ¿Tiene tests directos? |
| ------- | ------ | ------- | :---------------------: |
| Recursivo directo | `_rec` | `fibonacci_rec` | ✅ Sí |
| Recursivo con acumulador | `_acc` | `fibonacci_acc` | ✅ Sí (TCO en Rakudo) |
| Iterativo | `_ite` | `fibonacci_ite` | ✅ Sí |

**Combinación aplicada:** TCO ✅ + iteración ✅ → `_rec` + `_acc` + `_ite` = **3 suites × 5 subtests = 15 tests que agrupan 33 casos**.

**Applied combination:** TCO ✅ + iteration ✅ → `_rec` + `_acc` + `_ite` = **3 suites × 5 subtests = 15 tests grouping 33 cases**.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p raku/core/foundations/numbers/{lib,t}
   ```

2. Escribir `lib/Numbers.rakumod` y las suites en `t/`.

3. No se necesita ningún paso adicional de construcción o vinculación de dependencias.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración de build. Las suites importan el módulo con `use lib 'lib'; use Numbers;`.

### `lib/Numbers.rakumod` — Implementación (3 enfoques en 1 archivo)

**ES:** Cada algoritmo tiene 3 implementaciones con los sufijos `_rec`, `_acc` e `_ite`; los helpers `_help` son privados por convención (no llevan `is export`). Por ejemplo, `fibonacci`:

**EN:** Each algorithm has 3 implementations with the suffixes `_rec`, `_acc` and `_ite`; the `_help` helpers are private by convention (no `is export`). For example, `fibonacci`:

```raku
# Direct recursion (_rec)
sub fibonacci_rec($n) is export {
  return $n <= 1 ?? $n !! fibonacci_rec($n - 1) + fibonacci_rec($n - 2);
}

# Accumulator recursion (_acc): tail calls, TCO in Rakudo
sub fibonacci_acc($n) is export {
  return fibonacci_acc_help($n, 0, 1);
}

sub fibonacci_acc_help($n, $acc2, $acc1) {
  return $n <= 0 ?? $acc2 !!
         $n <= 2 ?? $acc1 + $acc2 !!
         fibonacci_acc_help($n - 1, $acc1, $acc1 + $acc2);
}

# Iterative (_ite): native loops
sub fibonacci_ite($n) is export {
  return $n if $n <= 1;
  my $acc2 = 0;
  my $acc1 = 1;
  for 2..$n -> $i {
    my $temp = $acc1 + $acc2;
    $acc2 = $acc1;
    $acc1 = $temp;
  }
  return $acc1;
}
```

| Algoritmo | `_rec` | `_acc` | `_ite` |
| --------- | ------ | ------ | ------ |
| `sum_of_first_n` | `$n + sum_rec($n-1)` | helper con `$n + $acc` | `for 1..$n` |
| `factorial` | `$n * fact_rec($n-1)` | helper con `$n * $acc` | `for 1..$n` |
| `fibonacci` | suma de dos llamadas | helper con `$acc2, $acc1` | `for 2..$n` con `$temp` |
| `greatest_common_divisor` | Euclides recursivo | helper (Euclides) | `while $b2 != 0` |
| `least_common_multiple` | `($a * $b) div gcd` | `($a * $b) div gcd` | `($a * $b) div gcd` |

### Suites de pruebas — módulo Test con subtest

**ES:** Tres suites, una por enfoque. Cada suite declara `plan 5` y agrupa un `subtest` por función; los 11 casos del pseudocódigo viven como `is()` dentro de ellos (33 aserciones en total), cada subtest con su propio `plan`.

**EN:** Three suites, one per approach. Each suite declares `plan 5` and groups one `subtest` per function; the pseudocode's 11 cases live as `is()` calls within them (33 assertions in total), each subtest with its own `plan`.

```raku
use Test;

use lib 'lib';
use Numbers;

plan 5;

subtest 'sum_of_first_n_rec', {
  plan 2;
  is(sum_of_first_n_rec(0), 0, 'sum_of_first_n_rec 1');
  is(sum_of_first_n_rec(3), 6, 'sum_of_first_n_rec 2');
};

subtest 'fibonacci_rec', {
  plan 3;
  is(fibonacci_rec(0), 0, 'fibonacci_rec 1');
  is(fibonacci_rec(1), 1, 'fibonacci_rec 2');
  is(fibonacci_rec(6), 8, 'fibonacci_rec 3');
};
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

### Ejecutar las pruebas / Run tests

Desde la raíz del proyecto:

```bash
cd raku/core/foundations/numbers
prove6
```

### Salida esperada / Expected output

```text
t/iterative_tests.rakutest ................ ok
t/recursive_tests.rakutest ................ ok
t/recursive_with_acc_tests.rakutest ....... ok
All tests successful.
Files=3, Tests=15,  0 wallclock secs
Result: PASS
```

> **ES:** `Tests=15` son los 5 subtests por suite; los 33 casos del pseudocódigo viven como `is()` dentro de los subtests, todos pasando (equivale al `tests runned 33 / passed 33 / failed 0` de la especificación).
> **EN:** `Tests=15` are the 5 subtests per suite; the pseudocode's 33 cases live as `is()` within the subtests, all passing (equivalent to the specification's `tests runned 33 / passed 33 / failed 0`).

---

## 🔁 Sobre recursión con acumulador y Tail Call Optimization (TCO)

**ES:**
Tail recursion ocurre cuando la llamada recursiva es la última acción que ejecuta una función; después de la llamada no hay más instrucciones. La recursión con acumulador consigue esto pasando el estado previo como parámetro, sin dejar trabajo pendiente en la pila.

**Rakudo (la implementación de Raku) optimiza las llamadas de cola auto-recursivas**: la recursión de cola se ejecuta con pila constante (verificado empíricamente con un millón de llamadas sin desbordar la pila). Por eso las funciones `_acc` tienen una ventaja real sobre `_rec` y **sí se les escriben pruebas unitarias propias** (suite `recursive_with_acc_tests.rakutest`), a diferencia de lenguajes sin TCO como Python o R.

**EN:**
Tail recursion occurs when the recursive call is the last action executed by a function; after the call there are no more instructions. Accumulator recursion achieves this by passing the previous state as a parameter, leaving no pending work on the stack.

**Rakudo (the Raku implementation) optimizes self-recursive tail calls**: tail recursion runs with constant stack (empirically verified with one million calls without stack overflow). That's why the `_acc` functions have a real advantage over `_rec` and **dedicated unit tests are written for them** (suite `recursive_with_acc_tests.rakutest`), unlike languages without TCO such as Python or R.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Raku usa módulos reales: `unit module Numbers` + `is export` exporta las 15 funciones; los helpers `_help` no se exportan (privados por convención).
- **EN:** Raku uses real modules: `unit module Numbers` + `is export` exports the 15 functions; the `_help` helpers are not exported (private by convention).
- **ES:** El MCM usa `($a * $b) div gcd` con `div` (división entera de Raku) en lugar de `/` para obtener un `Int` exacto en los tests.
- **EN:** LCM uses `($a * $b) div gcd` with `div` (Raku's integer division) instead of `/` to get an exact `Int` in the tests.
- **ES:** En Raku, `1..0` es un rango **vacío**, así que los bucles `for 1..$n` de `sum`/`factorial` funcionan correctamente con `$n = 0`.
- **EN:** In Raku, `1..0` is an **empty** range, so the `for 1..$n` loops of `sum`/`factorial` work correctly with `$n = 0`.
- **ES:** En `greatest_common_divisor` se usa `%` (operador módulo de Raku), legítimo en este algoritmo (la restricción de no usar operadores de módulo aplica solo al módulo `calculator` de la especificación 03).
- **EN:** `greatest_common_divisor` uses `%` (Raku's modulus operator), which is legitimate in this algorithm (the no-modulus-operator restriction applies only to the `calculator` module of specification 03).
- **ES:** No se usa `run_tests` porque `prove6` ya es el punto de entrada del ecosistema.
- **EN:** `run_tests` is not used because `prove6` is already the ecosystem's entry point.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
