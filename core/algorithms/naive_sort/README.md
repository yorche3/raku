# Naive Sort — Raku

Implementación de la especificación [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) en **Raku**, con el módulo **Test** (incluido en Rakudo) como framework de pruebas unitarias y **prove6** como runner.

Tres algoritmos de ordenación con coste $O(n^2)$: **selection sort**, **bubble sort** e **insertion sort**, los tres *in-place* sobre una copia local del array, sin invocar `.sort` ni ninguna biblioteca de ordenamiento. Los identificadores usan **kebab-case** (`selection-sort`), que es la convención de Raku.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`lib/NaiveSort.rakumod`](lib/NaiveSort.rakumod) | Módulo `NaiveSort` — las 3 funciones del contrato, exportadas con `is export`. |
| [`t/naive_sort_tests.rakutest`](t/naive_sort_tests.rakutest) | Suite única: 3 subtests (7 casos cada uno). |
| [`.gitignore`](.gitignore) | Ignora los artefactos precompilados (`.precomp/`). |

**Estructura de directorios esperada:**

```text
naive_sort/
├── lib/
│   └── NaiveSort.rakumod                # 3 funciones del contrato
├── t/
│   └── naive_sort_tests.rakutest        # Tests: los 3 algoritmos
├── .gitignore
└── README.md                            # Este archivo
```

> **ES:** En Raku, la separación `src/`+`test/` de la especificación se traduce idiomáticamente a **`lib/` + `t/`**, el layout estándar del ecosistema y el que prove6 descubre por defecto.
> **EN:** In Raku, the specification's `src/`+`test/` separation idiomatically becomes **`lib/` + `t/`**, the ecosystem's standard layout and what prove6 discovers by default.

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto usa el mismo patrón que [`numbers`](../../foundations/numbers/) y [`calculator`](../../foundations/unit_test/calculator/): módulo con `unit module` + `is export` y suite con el módulo **Test** ejecutada por **prove6**. Las 3 funciones viven en un único módulo y no hay helpers exportados; cada una usa su propia estrategia, sin compartir código.

**EN:** This project uses the same pattern as [`numbers`](../../foundations/numbers/) and [`calculator`](../../foundations/unit_test/calculator/): a module with `unit module` + `is export` and a suite using the **Test** module run by **prove6**. The 3 functions live in a single module and no helper is exported; each one uses its own strategy, sharing no code.

**Combinación aplicada:** implementación iterativa + arrays mutables localmente → **1 suite × 3 subtests = 3 tests (21 casos)**.

**Applied combination:** iterative implementation + locally mutable arrays → **1 suite × 3 subtests = 3 tests (21 cases)**.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p raku/core/algorithms/naive_sort/{lib,t}
   ```

2. Escribir `lib/NaiveSort.rakumod` y la suite en `t/`.

3. No se necesita ningún paso adicional de construcción o vinculación de dependencias.

---

## 📄 Archivos de configuración clave / Key Configuration Files

**ES:** No se requieren archivos de configuración de build. La suite carga el módulo con `use lib 'lib';` + `use NaiveSort;`.

**EN:** No build configuration files are required. The suite loads the module with `use lib 'lib';` + `use NaiveSort;`.

### `lib/NaiveSort.rakumod` — Implementación

**ES:** Las tres funciones exportadas comprueban `$n <= 1` y después ordenan el propio `@array` (la copia local del parámetro), devolviéndolo. Extracto de `bubble-sort`, que conserva la bandera de intercambio y la salida temprana del pseudocódigo:

**EN:** All three exported functions check `$n <= 1` and then sort `@array` itself (the parameter's local copy), returning it. Excerpt from `bubble-sort`, which keeps the swap flag and the pseudocode's early exit:

```raku
unit module NaiveSort;

sub bubble-sort(@array) is export {
    my $n = @array.elems;
    if $n <= 1 {
        return @array;
    }
    for 0 ..^ $n - 1 -> $i {
        my @swapped = False;
        for 0 .. $n - 2 - $i -> $j {
            if @array[$j] > @array[$j + 1] {
                my $temp = @array[$j];
                @array[$j] = @array[$j + 1];
                @array[$j + 1] = $temp;
                @swapped[0] = True;
            }
        }
        last unless @swapped[0];
    }
    return @array;
}
```

| Algoritmo | Estrategia implementada |
| --------- | ----------------------- |
| `selection-sort` | Bucle `0 ..^ $n - 1` con `$min-index` y swap guardado por `if $min-index != $i` |
| `bubble-sort` | Bucle por pasada con `@swapped[0]` como bandera y `last unless` para cortar |
| `insertion-sort` | `$current` + `while $j >= 0 && @array[$j] > $current` que desplaza el sub-tramo ordenado |

### Suites de pruebas — módulo Test con subtest

**ES:** Una única suite con un `subtest` por algoritmo y `plan 3` a nivel de fichero. Los 7 casos viven en una lista compartida y un único helper los recorre para cualquier función; el mensaje del contrato viaja en el tercer argumento de `is-deeply`, y cada caso ordena una **copia** del fixture:

**EN:** A single suite with one `subtest` per algorithm and a file-level `plan 3`. The 7 cases live in a shared list and a single helper walks them for any function; the contract message travels in `is-deeply`'s third argument, and each case sorts a **copy** of the fixture:

```raku
sub assert-sorts-all-cases($sort, Str $algorithm) {
  for @cases -> $case {
    my ($description, $input, $expected) = |$case;
    my @actual-input = $input.clone;
    is-deeply($sort(@actual-input), $expected,
      "$algorithm should sort $description");
  }
}

plan 3;

subtest 'selection_sort', {
  plan 7;
  assert-sorts-all-cases(&selection-sort, 'selection_sort');
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

### Verificación estática / Static check

**ES:** Raku no compila a un artefacto previo, así que la verificación estática es la comprobación sintáctica con `raku -c` (el propio compilador, que informa de errores y avisos), tanto del módulo como de la suite:

**EN:** Raku does not compile to a prior artifact, so the static check is the syntactic check with `raku -c` (the compiler itself, which reports errors and warnings), for both the module and the suite:

```bash
cd raku/core/algorithms/naive_sort
raku -c lib/NaiveSort.rakumod
raku -c t/naive_sort_tests.rakutest
```

### Ejecutar las pruebas / Run tests

Desde la raíz del proyecto:

```bash
cd raku/core/algorithms/naive_sort
prove6 -l t/
```

**Alternativa:** `prove6` a secas también funciona, porque la propia suite añade `lib/` a la ruta de carga con `use lib 'lib';`.

### Salida esperada / Expected output

```text
t/naive_sort_tests.rakutest .. ok
All tests successful.
Files=1, Tests=3,  0 wallclock secs
Result: PASS
```

> **ES:** `Tests=3` son los 3 subtests (uno por algoritmo); los 21 casos viven como `is-deeply()` dentro de ellos (7 por algoritmo), todos pasando. Un fallo se reporta con la descripción del contrato: `# Failed test 'bubble_sort should sort an unsorted array'` seguido de `# expected:` y `# got:`.
> **EN:** `Tests=3` are the 3 subtests (one per algorithm); the 21 cases live as `is-deeply()` within them (7 per algorithm), all passing. A failure is reported with the contract description: `# Failed test 'bubble_sort should sort an unsorted array'` followed by `# expected:` and `# got:`.

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Algoritmo | Función | Estrategia | Entrada ordenada | Entrada invertida |
|-----------|---------|-----------|:----------------:|:-----------------:|
| Selection sort | `selection-sort` | Busca el mínimo del tramo no ordenado con `$min-index` y lo intercambia al inicio | $O(n^2)$ | $O(n^2)$ |
| Bubble sort | `bubble-sort` | Compara e intercambia adyacentes; bandera `@swapped` con `last unless` (**salida temprana**) | $O(n)$ | $O(n^2)$ |
| Insertion sort | `insertion-sort` | Toma cada elemento como `$current` y desplaza el sub-tramo ordenado con `while` | $O(n)$ | $O(n^2)$ |

### Casos cubiertos / Covered cases

| # | Caso | Entrada | Salida esperada |
|:-:|------|---------|-----------------|
| 1 | Array estándar desordenado | `(5, 2, 9, 1, 5, 6)` | `(1, 2, 5, 5, 6, 9)` |
| 2 | Array ya ordenado | `(1, 2, 3, 4, 5)` | `(1, 2, 3, 4, 5)` |
| 3 | Array en orden inverso | `(5, 4, 3, 2, 1)` | `(1, 2, 3, 4, 5)` |
| 4 | Elementos idénticos | `(7, 7, 7, 7)` | `(7, 7, 7, 7)` |
| 5 | Con números negativos | `(3, -1, 4, -5, 0)` | `(-5, -1, 0, 3, 4)` |
| 6 | Un solo elemento | `(42)` | `(42)` |
| 7 | Array vacío | `()` | `()` |

**ES:** Son los 7 casos obligatorios de la especificación. El **caso nulo se omite** (ver la nota correspondiente).

**EN:** These are the 7 mandatory cases from the specification. The **null case is omitted** (see the corresponding note).

---

## 📝 Notas de implementación / Implementation Notes

### 🚫 Caso nulo omitido: `@array` no admite `Nil` / Null case omitted: `@array` does not accept `Nil`

**ES:** La especificación pide devolver el indicador de fallo del lenguaje si la entrada es nula o inválida. En Raku, un parámetro con sigilo `@array` **no puede recibir `Nil`**: es un error de compilación, no de ejecución. Con la firma `(@arr)`, `raku` rechaza la llamada con `Calling f(Nil) will never work with declared signature (@arr)`, así que la entrada nula no es representable en la firma y se conservan los 7 casos obligatorios, con el array vacío como caso 7.

**EN:** The specification requires returning the language's failure indicator when the input is null or invalid. In Raku, a parameter with the `@array` sigil **cannot receive `Nil`**: it is a compile-time error, not a runtime one. With the `(@arr)` signature, `raku` rejects the call with `Calling f(Nil) will never work with declared signature (@arr)`, so the null input is not representable in the signature and the 7 mandatory cases are kept, with the empty array as case 7.

### 🧬 Ordenamiento *in-place* sobre la copia local del parámetro / In-place sorting over the parameter's local copy

**ES:** El pseudocódigo ordena el propio array con `swap(arr, i, j)`. En Raku un parámetro `@array` **sin `is rw`** es una copia local, así que las tres funciones ordenan **esa** copia con `@array[$i] = …` y devuelven el array ordenado con `return @array`: el array del llamador no cambia y el resultado llega por el valor devuelto, la variante que la especificación permite. Por eso la suite ordena una **copia** del fixture en cada caso (`my @actual-input = $input.clone`) y no puede contaminar los siguientes.

**EN:** The pseudocode sorts the array itself with `swap(arr, i, j)`. In Raku an `@array` parameter **without `is rw`** is a local copy, so all three functions sort **that** copy with `@array[$i] = …` and return the sorted array with `return @array`: the caller's array does not change and the result arrives through the returned value, the variant the specification allows. That is why the suite sorts a **copy** of the fixture in each case (`my @actual-input = $input.clone`) and cannot contaminate the next ones.

### ➿ Rangos de Raku: `..^` exclusivo y `..` inclusivo / Raku ranges: exclusive `..^` and inclusive `..`

**ES:** El pseudocódigo usa cotas **inclusivas** (`for i = 0 to n - 2`, `for j = 0 to n - 2 - i`). En Raku, el rango exclusivo `..^` expresa lo mismo de forma más breve en el bucle exterior (`0 ..^ $n - 1` es `0 .. n-2`), pero en el bucle interior la cota del pseudocódigo es inclusiva y se escribe `0 .. $n - 2 - $i`: con `..^` el bucle haría **una comparación menos por pasada** y el mayor no llegaría al final. En Raku `1..0` es un rango **vacío**, así que las cotas no producen iteraciones fantasma como en otros lenguajes.

**EN:** The pseudocode uses **inclusive** bounds (`for i = 0 to n - 2`, `for j = 0 to n - 2 - i`). In Raku, the exclusive range `..^` expresses the same thing more briefly in the outer loop (`0 ..^ $n - 1` is `0 .. n-2`), but in the inner loop the pseudocode's bound is inclusive and is written `0 .. $n - 2 - $i`: with `..^` the loop would make **one comparison fewer per pass** and the maximum would not reach the end. In Raku `1..0` is an **empty** range, so the bounds do not produce phantom iterations as in other languages.

### 🔁 `bubble-sort` y la bandera de intercambio / `bubble-sort` and the swap flag

**ES:** El criterio de aceptación exige la optimización de salida temprana. `bubble-sort` pone la bandera en `False` al empezar cada pasada (`my @swapped = False`), la activa al intercambiar (`@swapped[0] = True`) y corta con `last unless @swapped[0]` cuando la pasada no cambió nada, que es el `if not swapped then break` del pseudocódigo: un array ya ordenado se resuelve en **una sola pasada** y el mejor caso es $O(n)$. La bandera **no es observable en la salida** (las tres funciones devuelven un array ordenado), así que la suite no puede detectar su ausencia: su presencia se verifica comparando el código con el pseudocódigo.

**EN:** The acceptance criteria require the early-exit optimisation. `bubble-sort` sets the flag to `False` at the start of each pass (`my @swapped = False`), sets it when swapping (`@swapped[0] = True`) and breaks with `last unless @swapped[0]` when the pass changed nothing, which is the pseudocode's `if not swapped then break`: an already sorted array is solved in **a single pass** and the best case is $O(n)$. The flag is **not observable in the output** (all three functions return a sorted array), so the suite cannot detect its absence: its presence is verified by comparing the code against the pseudocode.

### 🔀 Estabilidad de `insertion-sort` / `insertion-sort` stability

**ES:** El desplazamiento usa la comparación estricta `@array[$j] > $current` con la guarda `$j >= 0`, así que los elementos iguales conservan su orden relativo y `insertion-sort` es estable. El caso 1 (`(5, 2, 9, 1, 5, 6)`, con dos cincos) se beneficia de ello, aunque los tests comparan valores y no identidad.

**EN:** The shifting uses the strict comparison `@array[$j] > $current` with the `$j >= 0` guard, so equal elements keep their relative order and `insertion-sort` is stable. Case 1 (`(5, 2, 9, 1, 5, 6)`, with two fives) benefits from it, although the tests compare values rather than identity.

### 🏷️ Naming: kebab-case y nombres de la especificación / Naming: kebab-case and specification names

**ES:** Las funciones usan **kebab-case** (`selection-sort`), que es la convención de Raku, mientras que la especificación las nombra en `snake_case`. El nombre de la especificación se conserva como **nombre del `subtest`** y en el **mensaje del contrato** (`"selection_sort should sort an unsorted array"`), de modo que el reporte sigue mostrando `selection_sort`, `bubble_sort` e `insertion_sort`. El módulo usa `unit module NaiveSort;` y las tres funciones se exportan con `is export`; el parámetro conserva el nombre `array` (el `arr` de la documentación) y no hay helpers exportados.

**EN:** Functions use **kebab-case** (`selection-sort`), which is Raku's convention, while the specification names them in `snake_case`. The specification name is preserved as the **`subtest` name** and in the **contract message** (`"selection_sort should sort an unsorted array"`), so the report still shows `selection_sort`, `bubble_sort` and `insertion_sort`. The module uses `unit module NaiveSort;` and the three functions are exported with `is export`; the parameter keeps the `array` name (the documentation's `arr`) and no helper is exported.

### 📍 Desviaciones respecto a la ubicación esperada / Deviations from the expected location

| Especificación | Implementación | Motivo |
|----------------|----------------|--------|
| `src/naive_sort.ext` | `lib/NaiveSort.rakumod` | El layout idiomático de Raku es `lib/` (no `src/`) y el fichero se llama como el módulo, en `PascalCase`, como `Numbers.rakumod` en `numbers/`. |
| `test/naive_sort_test.ext` | `t/naive_sort_tests.rakutest` | El directorio es `t/`, el sufijo va en plural (`_tests`) y la extensión es `.rakutest`, como en `numbers/` (`t/recursive_tests.rakutest`). |
| `test/run_tests.ext` | — | `prove6` es el punto de entrada del ecosistema y descubre `t/*.rakutest` por sí solo, así que la especificación no pide un archivo de ejecución aparte. |

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

---

*[← Volver a Algoritmos Puros](../README.md) · [↑ Volver a Core](../../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
