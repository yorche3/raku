# Data Structures Basics — Raku

Implementación de la especificación [06_Data_Structures_Basics](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics/) en **Raku**, con el módulo **Test** (incluido en Rakudo) como framework de pruebas unitarias y **prove6** como runner.

El módulo implementa una celda enlazada compartida `Node` y tres estructuras de datos construidas manualmente sobre ella: `LinkedList`, `Stack` (LIFO) y `Queue` (FIFO). Cada ADT gestiona directamente sus punteros sin delegar en `LinkedList` ni en colecciones de la biblioteca estándar de Raku.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directory | Propósito / Purpose |
|---|---|
| [`lib/DataStructuresBasics.rakumod`](lib/DataStructuresBasics.rakumod) | Módulo `DataStructuresBasics` con las cuatro clases: `Node`, `LinkedList`, `Stack` y `Queue`. |
| [`t/node-tests.rakutest`](t/node-tests.rakutest) | Suite de pruebas para `Node`: inicialización, enlace y recorrido. |
| [`t/linked-list-tests.rakutest`](t/linked-list-tests.rakutest) | Suite de pruebas para `LinkedList`: inserción en ambos extremos, eliminación, vaciado y observación. |
| [`t/stack-tests.rakutest`](t/stack-tests.rakutest) | Suite de pruebas para `Stack`: contrato LIFO, peek no mutante, extracción y reutilización. |
| [`t/queue-tests.rakutest`](t/queue-tests.rakutest) | Suite de pruebas para `Queue`: contrato FIFO, peek no mutante, extracción y reutilización. |
| [`.gitignore`](.gitignore) | Archivos generados excluidos (`.precomp/`). |
| [`README.md`](README.md) | Documentación de Nivel 3 del módulo. |

**Estructura de directorios esperada:**

```text
data_structures_basics/
├── lib/
│   └── DataStructuresBasics.rakumod
├── t/
│   ├── linked-list-tests.rakutest
│   ├── node-tests.rakutest
│   ├── queue-tests.rakutest
│   └── stack-tests.rakutest
├── .gitignore
└── README.md
```

> **ES:** En Raku, la separación `src/` + `test/` de la especificación se traduce idiomáticamente a **`lib/` + `t/`**, el layout estándar del ecosistema y el que prove6 descubre por defecto. Los tests usan nombres con guiones (`linked-list-tests.rakutest`), convención kebab-case estándar de Raku.
> **EN:** In Raku, the specification's `src/` + `test/` separation idiomatically becomes **`lib/` + `t/`**, the ecosystem's standard layout and what prove6 discovers by default. Test files follow Raku's kebab-case convention (`linked-list-tests.rakutest`).

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este módulo se construye de forma minimalista en un único archivo de biblioteca (`lib/DataStructuresBasics.rakumod`), exportando cuatro clases mediante `is export`. Cada estructura administra directamente sus propios punteros (`$!head`/`$!tail`, `$!top`, `$!front`/`$!rear`) y su contador de elementos (`$!count`).

**EN:** This module is built minimalistically in a single library file (`lib/DataStructuresBasics.rakumod`), exporting four classes via `is export`. Each structure directly manages its own pointers (`$!head`/`$!tail`, `$!top`, `$!front`/`$!rear`) and element counter (`$!count`).

### Inicialización / Initialization

```bash
mkdir -p raku/core/algorithms/data_structures_basics/{lib,t}
```

No se requieren gestores de dependencias externos ni pasos adicionales de compilación; Rakudo resuelve el módulo mediante `use lib 'lib'`.

## 📄 Configuración clave / Key Configuration

No se requieren archivos de build ni manifiestos (`META6.json`), ya que el módulo forma parte de la jerarquía core del repositorio y se ejecuta directamente con Rakudo y `prove6`. El archivo `.gitignore` ignora la caché `.precomp/`.

## 🚀 Compilación y ejecución / Build & Run

### Requisitos / Requirements

- **Rakudo** (`raku` v2026.07 o compatible).
- **prove6** (`App::Prove6` 0.0.18 o compatible).

```bash
# Verificación estática / Static check
raku -c -Ilib lib/DataStructuresBasics.rakumod
for f in t/*.rakutest; do raku -c -Ilib "$f"; done

# Ejecutar las pruebas / Run tests
prove6
```

**Salida real / Actual output:**

```text
t/linked-list-tests.rakutest .................................................................................. ok
t/node-tests.rakutest ......................................................................................... ok
t/queue-tests.rakutest ........................................................................................ ok
t/stack-tests.rakutest ........................................................................................ ok
All tests successful.
Files=4, Tests=4,  0 wallclock secs
Result: PASS
```

> **ES:** `Tests=4` corresponde a los cuatro subtests planificados (uno por suite: 5 casos en LinkedList, 2 en Node, 4 en Queue, 4 en Stack; 15 aserciones compuestas en total).
> **EN:** `Tests=4` corresponds to the four planned subtests (one per test file: 5 cases in LinkedList, 2 in Node, 4 in Queue, 4 in Stack; 15 composite assertions in total).

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `Node.new(value => $v)` | `Int → Node` | $O(1)$ | Inicializa valor; `$!next` queda indefinido (`Node:U`). |
| `Node.get-value` | `() → Int` | $O(1)$ | Observa el valor almacenado. |
| `Node.get-next` | `() → Node:_` | $O(1)$ | Devuelve el enlace al siguiente nodo o indefinido. |
| `Node.set-next($next)` | `Node → Node` | $O(1)$ | Enlaza el siguiente nodo y devuelve `self`. |
| `LinkedList.new` | `() → LinkedList` | $O(1)$ | Cabeza y cola ausentes, `$!count = 0`. |
| `LinkedList.is-empty` | `() → Bool` | $O(1)$ | Evalúa `$!count == 0`. |
| `LinkedList.size` | `() → Int` | $O(1)$ | Devuelve `$!count`. |
| `LinkedList.get-head` | `() → Int` | $O(1)$ | Valor de la cabeza, o `-1` si está vacía. |
| `LinkedList.insert-head($v)` | `Int → Node` | $O(1)$ | Inserta nodo al inicio, actualiza cabeza y cola si aplica, incrementa `$!count`. |
| `LinkedList.insert-tail($v)` | `Int → Node` | $O(1)$ | Inserta nodo al final, actualiza cola y cabeza si aplica, incrementa `$!count`. |
| `LinkedList.delete($v)` | `Int → Bool` | $O(n)$ | Elimina la primera ocurrencia linealmente y decrementa `$!count`; devuelve `True` o `False`. |
| `Stack.new` | `() → Stack` | $O(1)$ | `$!top` ausente, `$!count = 0`. |
| `Stack.is-empty` | `() → Bool` | $O(1)$ | Evalúa `$!count == 0`. |
| `Stack.size` | `() → Int` | $O(1)$ | Devuelve `$!count`. |
| `Stack.push($v)` | `Int → Node` | $O(1)$ | Coloca un nuevo nodo sobre `$!top` e incrementa `$!count`. |
| `Stack.pop` | `() → Int` | $O(1)$ | Extrae y devuelve el valor del tope y decrementa `$!count`, o `-1` si está vacía. |
| `Stack.peek` | `() → Int` | $O(1)$ | Observa el valor en `$!top` sin extraer, o `-1` si está vacía. |
| `Queue.new` | `() → Queue` | $O(1)$ | `$!front` y `$!rear` ausentes, `$!count = 0`. |
| `Queue.is-empty` | `() → Bool` | $O(1)$ | Evalúa `$!count == 0`. |
| `Queue.size` | `() → Int` | $O(1)$ | Devuelve `$!count`. |
| `Queue.enqueue($v)` | `Int → Node` | $O(1)$ | Inserta nodo tras `$!rear` e incrementa `$!count`. |
| `Queue.dequeue` | `() → Int` | $O(1)$ | Extrae y devuelve el valor de `$!front` y decrementa `$!count`, o `-1` si está vacía. |
| `Queue.peek` | `() → Int` | $O(1)$ | Observa el valor en `$!front` sin extraer, o `-1` si está vacía. |

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Clases independientes con atributos privados (`$!head`, `$!tail`, `$!top`, `$!front`, `$!rear`) | Delegar `Stack` y `Queue` sobre `LinkedList` | La especificación prohíbe explícitamente envolver `LinkedList`. Cada estructura gestiona de forma autónoma su puntero o punteros sobre el tipo `Node`. |
| Nomenclatura kebab-case (`get-value`, `insert-head`, `is-empty`) | Respetar snake_case exacto (`get_value`, `insert_head`) | Convención léxica e idiomática de Raku; alineado con módulos previos de algoritmos (`naive_sort`). |
| Construcción mediante constructores estándar de Raku (`Type.new`) con submethod `BUILD` para `Node` | Procedimientos externos o funciones independientes `init()` | En Raku orientado a objetos, `.new` es el punto idiomático de instanciación. `BUILD` permite mapear argumentos nombrados a atributos estrictamente privados `$!value`. |
| Retorno de `Node` en operaciones de inserción (`insert-head`, `insert-tail`, `push`, `enqueue`) | Retornar `self` o no retornar nada (`Nil`) | Devuelve la referencia al nodo creado, permitiendo inspección si se requiere, sin afectar el contrato del tamaño y complejidad. |

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| `type Node`, `type LinkedList`, etc. con `init()` | `class Node is export`, `class LinkedList is export` con `Node.new(...)` y `Type.new` | Las clases nativas de Raku con atributos tipados (`has Int $!value; has Node $!next;`) proporcionan encapsulación sin necesidad de constructores auxiliares artificiales. |
| Ausencia de enlace (`absent`) | `Node:U` (instancia indefinida del tipo `Node`) o `Nil` | Representación nativa y tipada de ausencia en el sistema de tipos de Raku sin requerir envoltorios `Option` o centinelas no tipados. |
| Identificadores en snake_case (`get_value`, `insert_head`, `is_empty`, etc.) | Identificadores en kebab-case (`get-value`, `insert-head`, `is-empty`, etc.) | Idioma estándar de Raku para métodos públicos. |
| `src/` y `test/` (`run_tests.ext`) | `lib/` y `t/` (`prove6`) | Layout canónico de proyectos y herramientas de prueba en el ecosistema Raku. |
| Caso nulo como entrada de operaciones | Omitido en la suite de pruebas | Los parámetros públicos están tipados como `Int` o `Node` definidos; pasar `Nil` o tipos incompatibles es un error léxico/sintáctico de tipos en Raku, no un valor evaluable en ejecución. |

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `LinkedList.get-head` | Lista vacía (`$!head` ausente / `$!count == 0`) | `-1` | `LinkedList.new.get-head` → `-1` |
| `LinkedList.delete` | Elemento no encontrado en la lista | `False` | `list.delete(99)` → `False` |
| `Stack.pop` | Pila vacía (`$!top` ausente / `$!count == 0`) | `-1` | `Stack.new.pop` → `-1` |
| `Stack.peek` | Pila vacía (`$!top` ausente / `$!count == 0`) | `-1` | `Stack.new.peek` → `-1` |
| `Queue.dequeue` | Cola vacía (`$!front` ausente / `$!count == 0`) | `-1` | `Queue.new.dequeue` → `-1` |
| `Queue.peek` | Cola vacía (`$!front` ausente / `$!count == 0`) | `-1` | `Queue.new.peek` → `-1` |
| Operaciones con parámetros de entrada (`$value`, `$next`) | Entrada nula (`Nil`) | No representable | La firma tipada (`Int $value`, `Node $next`) rechaza `Nil` en tiempo de compilación/firma de Raku. |

## ✅ Cobertura de pruebas / Test coverage

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| `Node`: Inicializar y observar valor/enlace | Sí | `t/node-tests.rakutest:23` | Caso "initialize and observe value and link". |
| `Node`: Inicializar otro nodo, enlazar y recorrer | Sí | `t/node-tests.rakutest:31` | Caso "initialize another node, link, and traverse". |
| `LinkedList`: Estado vacío | Sí | `t/linked-list-tests.rakutest:26` | Caso "an empty state" (`is-empty`, `size`, `get-head`). |
| `LinkedList`: Insertar por ambos extremos | Sí | `t/linked-list-tests.rakutest:31` | Caso "insertion at both ends" (`insert-tail`, `insert-head`, `size`, recorrido). |
| `LinkedList`: Eliminar primera aparición | Sí | `t/linked-list-tests.rakutest:40` | Caso "deletion of the first occurrence" (`delete(10)`, `size`, `get-head`). |
| `LinkedList`: Valor ausente | Sí | `t/linked-list-tests.rakutest:45` | Caso "an absent value" (`delete(99)`). |
| `LinkedList`: Vaciar | Sí | `t/linked-list-tests.rakutest:50` | Caso "emptying the list" (eliminación sucesiva hasta vacío). |
| `Stack`: Estado vacío y extracción fallida | Sí | `t/stack-tests.rakutest:26` | Caso "an empty state and failed removal" (`is-empty`, `size`, `peek`, `pop`). |
| `Stack`: LIFO y `peek` no mutante | Sí | `t/stack-tests.rakutest:31` | Caso "LIFO order and a non-mutating peek" (`push`, `peek`, `size`). |
| `Stack`: Extracción y reutilización | Sí | `t/stack-tests.rakutest:37` | Caso "removal and reuse" (`pop`, `push`, extracciones sucesivas). |
| `Stack`: Vacío tras extracción | Sí | `t/stack-tests.rakutest:53` | Caso "an empty state after removal" (`pop` sobre pila vacía). |
| `Queue`: Estado vacío y extracción fallida | Sí | `t/queue-tests.rakutest:26` | Caso "an empty state and failed removal" (`is-empty`, `size`, `peek`, `dequeue`). |
| `Queue`: FIFO y `peek` no mutante | Sí | `t/queue-tests.rakutest:31` | Caso "FIFO order and a non-mutating peek" (`enqueue`, `peek`, `size`). |
| `Queue`: Extracción y reutilización | Sí | `t/queue-tests.rakutest:37` | Caso "removal and reuse" (`dequeue`, `enqueue`, extracciones sucesivas). |
| `Queue`: Vacío tras extracción | Sí | `t/queue-tests.rakutest:53` | Caso "an empty state after removal" (`dequeue` sobre cola vacía). |
| Casos con entrada nula (`Nil`) | Omitido | — | Parámetros tipados estrictamente como `Int`; `Nil` no es admisible en la firma. |

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| Dominio restringido a enteros no negativos (`Int >= 0`) | El centinela `-1` colisionaría si se insertara `-1` en la estructura | Los casos de prueba y contrato de Fase 1 operan con enteros positivos. En Fase 4 se reemplazarán los centinelas numéricos por `Option`/`Result`. |
| Ausencia de genéricos parametrizados | Las estructuras almacenan exclusivamente `Int` | Se preserva la simplicidad para Fase 1 (Algoritmos Puros); la parametrización se abordará en fases posteriores. |

## 📝 Notas de implementación / Implementation Notes

- **Clases e instancias en Raku**: Se emplean clases estándar con atributos privados (`$!head`, `$!tail`, `$!top`, `$!front`, `$!rear`, `$!count`). `Node` define `submethod BUILD(Int :$value)` para enlazar adecuadamente el parámetro con nombre a su atributo privado.
- **Ausencia de enlace y nulos**: La ausencia de enlace en los nodos se representa mediante el tipo indefinido (`Node:U`), que en contexto booleano evalúa a `False` (`unless $!head`), manteniendo seguridad de tipos sin requerir nulos no tipados.
- **Centinelas de error**: Siguiendo la regla de Fase 1 (sin excepciones ni envoltorios de error), las consultas en vacío sobre valores enteros devuelven el centinela entero `-1`.
- **Independencia de estructuras**: `Stack` y `Queue` no heredan ni componen `LinkedList`; ambas manipulan sus referencias a `Node` directamente, garantizando la complejidad $O(1)$ prometida en todas sus operaciones.
- **Runner nativo `prove6`**: Al igual que en `numbers` y `naive_sort`, se prescinde de `run_tests` aprovechando que `prove6` ejecuta automáticamente los archivos `.rakutest` en el directorio `t/`.

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

## 🔍 Checklist de validación / Validation checklist

- [x] La suite nativa se ejecutó y su salida real está copiada en este README.
- [x] Cada caso de la especificación tiene su fila en _Cobertura de pruebas_ (o `Omitido` con razón).
- [x] Cada desviación del pseudocódigo o de la ubicación esperada está en _Adaptaciones idiomáticas_.
- [x] Cada operación con fallo posible está en _Indicadores de fallo_.
- [x] No hay rutas absolutas del autor, credenciales ni salidas inventadas.
- [x] Los enlaces relativos resuelven dentro del repositorio y el documento es bilingüe.
- [x] Ninguna sección repite lo que ya dice la especificación.

## 📚 Referencias / References

| Tipo / Kind | Referencia / Reference |
|---|---|
| Especificación / Specification | [`06_Data_Structures_Basics.md`](../../../../docs/core/algorithms/06_Data_Structures_Basics.md) |
| Módulo homologado del lenguaje / Homologated module | [`raku/core/foundations/numbers/`](../../foundations/numbers/README.md) |
| Módulo previo de algoritmos / Previous algorithm module | [`raku/core/algorithms/naive_sort/`](../naive_sort/README.md) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](../../../../docs/core/00_Project_Initialization_Guide.md) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](../../../../docs/AGENT_Template.md) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](../../../../docs/WORKFLOW.md) |
| Documentación oficial de Raku / Official Raku documentation | [Raku Documentation (Classes and Objects)](https://docs.raku.org/language/classtut) |
