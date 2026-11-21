# Data Structures Advanced — Raku

Implementación de la especificación [07_Data_Structures_Advanced](../../../../docs/core/algorithms/07_Data_Structures_Advanced.md) en **Raku**, con el módulo **Test** (incluido en Rakudo) como framework de pruebas unitarias y **prove6** como runner.

Implementation of the [07_Data_Structures_Advanced](../../../../docs/core/algorithms/07_Data_Structures_Advanced.md) specification in **Raku**, using the standard **Test** module (bundled with Rakudo) as the unit testing framework and **prove6** as the test runner.

El módulo declara una clase base `Node` que porta únicamente el valor, y dos tipos derivados: `TreeNode` (para un árbol binario de búsqueda `BinaryTree`) y `GraphNode` (para un grafo dirigido `Graph`). Todas las estructuras y operaciones se implementan manualmente sin recurrir a colecciones avanzadas ni tablas hash.

The module declares a base `Node` class holding only the value, and two derived types: `TreeNode` (for a `BinaryTree` binary search tree) and `GraphNode` (for a directed `Graph`). All structures and operations are implemented manually without relying on high-level collections or hash tables.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directory | Propósito / Purpose |
|---|---|
| [`lib/DataStructuresAdvanced.rakumod`](lib/DataStructuresAdvanced.rakumod) | Módulo `DataStructuresAdvanced` con las clases `Node`, `TreeNode`, `BinaryTree`, `GraphNode` y `Graph`. / Module with all core and exported classes. |
| [`t/tree-node-tests.rakutest`](t/tree-node-tests.rakutest) | Suite de pruebas unitarias para `TreeNode`. / Unit test suite for `TreeNode`. |
| [`t/binary-tree-tests.rakutest`](t/binary-tree-tests.rakutest) | Suite de pruebas unitarias para `BinaryTree`. / Unit test suite for `BinaryTree`. |
| [`t/graph-tests.rakutest`](t/graph-tests.rakutest) | Suite de pruebas unitarias para `Graph`. / Unit test suite for `Graph`. |
| [`.gitignore`](.gitignore) | Archivos generados excluidos (`.precomp/`). / Ignored generated files. |
| [`README.md`](README.md) | Documentación de Nivel 3 del módulo. / Level 3 module documentation. |

**Estructura de directorios esperada / Expected directory structure:**

```text
data_structures_advanced/
├── lib/
│   └── DataStructuresAdvanced.rakumod
├── t/
│   ├── binary-tree-tests.rakutest
│   ├── graph-tests.rakutest
│   └── tree-node-tests.rakutest
├── .gitignore
└── README.md
```

> **ES:** En Raku, la separación `src/` + `test/` de la especificación se traduce idiomáticamente a **`lib/` + `t/`**, el layout estándar del ecosistema y el que `prove6` descubre por defecto. Los tests usan nombres con guiones en kebab-case (`binary-tree-tests.rakutest`).
> **EN:** In Raku, the specification's `src/` + `test/` separation idiomatically becomes **`lib/` + `t/`**, the ecosystem's standard layout and what `prove6` discovers by default. Test files follow Raku's kebab-case convention (`binary-tree-tests.rakutest`).

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este módulo se construye de forma manual y minimalista en un único archivo de biblioteca (`lib/DataStructuresAdvanced.rakumod`). La clase base `Node` almacena únicamente el valor sin enlaces ni validaciones; `TreeNode` y `GraphNode` la reutilizan mediante herencia directa (`is Node`). El registro canónico de vértices de `Graph` se construye mediante una lista enlazada simple interna a través del puntero `$!next-vertex`, y la adyacencia de vecinos se modela con secuencias inmutables `List` ordenadas e insertadas manualmente.

**EN:** This module is built manually and minimalistically in a single library file (`lib/DataStructuresAdvanced.rakumod`). The base `Node` class stores only the value without links or validations; `TreeNode` and `GraphNode` reuse it via direct inheritance (`is Node`). The canonical vertex registry in `Graph` is built as an internal singly linked list via the `$!next-vertex` pointer, and neighbor adjacency is modeled with immutable `List` sequences sorted and inserted manually.

### Inicialización / Initialization

```bash
mkdir -p raku/core/algorithms/data_structures_advanced/{lib,t}
```

No se requieren herramientas externas de compilación ni gestores de dependencias; Rakudo resuelve el módulo mediante `use lib 'lib'`.

## 📄 Configuración clave / Key Configuration

No se requieren archivos de build ni manifiestos (`META6.json`), ya que el módulo forma parte de la jerarquía core del repositorio y se ejecuta directamente con Rakudo y `prove6`. El archivo `.gitignore` ignora la caché de compilación `.precomp/`.

## 🚀 Compilación y ejecución / Build & Run

### Requisitos / Requirements

- **Rakudo** (`raku` v2026.07 o compatible / or compatible).
- **prove6** (`App::Prove6` 0.0.18 o compatible / or compatible).

```bash
# Verificación estática / Static check
raku -c -Ilib lib/DataStructuresAdvanced.rakumod
for f in t/*.rakutest; do raku -c -Ilib "$f"; done

# Ejecutar las pruebas / Run tests
prove6
```

**Salida real / Actual output:**

```text
t/binary-tree-tests.rakutest .................................................................................... ok
t/graph-tests.rakutest .......................................................................................... ok
t/tree-node-tests.rakutest ...................................................................................... ok
All tests successful.
Files=3, Tests=3,  1 wallclock secs
Result: PASS
```

> **ES:** `Tests=3` corresponde a los tres subtests planificados (uno por suite: 5 casos en `TreeNode`, 7 casos en `BinaryTree`, 11 casos en `Graph`; 23 aserciones compuestas en total).
> **EN:** `Tests=3` corresponds to the three planned subtests (one per test file: 5 cases in `TreeNode`, 7 cases in `BinaryTree`, 11 cases in `Graph`; 23 composite assertions in total).

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `Node.new(value => $v)` | `Int → Node` | $O(1)$ | Constructor base con valor; sin enlaces ni validaciones. No se instancia directamente. / Base constructor with value; no links or validations. Not directly instantiated. |
| `Node.get-value` | `() → Int` | $O(1)$ | Observa el valor del nodo. Heredado por `TreeNode` y `GraphNode`. / Observes node value. Inherited by `TreeNode` and `GraphNode`. |
| `TreeNode.new(value => $v)` | `Int → TreeNode` | $O(1)$ | Inicializa valor vía `Node`; `$!left` y `$!right` quedan ausentes (`TreeNode:U`). / Initializes value via `Node`; children start absent (`TreeNode:U`). |
| `TreeNode.get-left` | `() → TreeNode:_` | $O(1)$ | Devuelve hijo izquierdo o tipo indefinido (`TreeNode:U`). / Returns left child or undefined type object. |
| `TreeNode.get-right` | `() → TreeNode:_` | $O(1)$ | Devuelve hijo derecho o tipo indefinido (`TreeNode:U`). / Returns right child or undefined type object. |
| `TreeNode.set-left($node)` | `TreeNode:_ → TreeNode:_` | $O(1)$ | Asigna hijo izquierdo (definido o `TreeNode:U`) y devuelve la referencia. / Sets left child and returns reference. |
| `TreeNode.set-right($node)` | `TreeNode:_ → TreeNode:_` | $O(1)$ | Asigna hijo derecho (definido o `TreeNode:U`) y devuelve la referencia. / Sets right child and returns reference. |
| `BinaryTree.new` | `() → BinaryTree` | $O(1)$ | Inicializa árbol vacío (`$!root` ausente, `$!count = 0`). / Initializes empty tree (`$!root` absent, count 0). |
| `BinaryTree.is-empty` | `() → Bool` | $O(1)$ | Evalúa `$!count == 0`. / Evaluates `$!count == 0`. |
| `BinaryTree.size` | `() → Int` | $O(1)$ | Devuelve `$!count`. / Returns element count. |
| `BinaryTree.insert($value)` | `Int → Bool` | $O(h)$ | Inserta según invariante ABB; duplicados no alteran tamaño (`h` = altura). / Inserts following BST invariant; duplicates do not grow size (`h` = height). |
| `BinaryTree.contains($value)` | `Int → Bool` | $O(h)$ | Búsqueda según invariante ABB (`h` = altura). / Traverses tree following BST invariant (`h` = height). |
| `GraphNode.new(value => $label)` | `Int → GraphNode` | $O(1)$ | Inicializa vértice con etiqueta, vecinos vacíos (`()`) y `$!next-vertex` indefinido. / Initializes vertex node with label, empty neighbors, absent next pointer. |
| `Graph.new` | `() → Graph` | $O(1)$ | Inicializa grafo vacío (`$!vertices` ausente, 0 vértices, 0 aristas). / Initializes empty usable graph. |
| `Graph.is-empty` | `() → Bool` | $O(1)$ | Evalúa `$!vertex-total == 0`. / Evaluates `$!vertex-total == 0`. |
| `Graph.vertex-count` | `() → Int` | $O(1)$ | Devuelve `$!vertex-total`. / Returns total vertex count. |
| `Graph.edge-count` | `() → Int` | $O(1)$ | Devuelve `$!edges`. / Returns total edge count. |
| `Graph.add-vertex($label)` | `Int → Bool` | $O(V)$ | Registra vértice; duplicado es éxito sin mutar adyacencia. / Registers vertex; duplicate succeeds preserving adjacency. |
| `Graph.add-edge($u, $v)` | `(Int, Int) → Bool` | $O(V + d(u))$ | Añade arista $u \to v$ ordenada; falla si falta $u$ o $v$. Admite bucles e idempotencia. / Adds directed edge $u \to v$; fails if endpoint missing. Allows loops and duplicates. |
| `Graph.has-edge($u, $v)` | `(Int, Int) → Bool` | $O(V + d(u))$ | Comprueba existencia de arista $u \to v$. / Checks presence of directed edge $u \to v$. |
| `Graph.get-neighbors($u)` | `Int → List:_` | $O(V + d(u))$ | Devuelve `List` inmutable ordenada de vecinos, o `Nil` si $u$ falta. / Returns immutable sorted `List` of neighbors, or `Nil` if $u$ missing. |

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Reutilización de valor mediante herencia (`class TreeNode is Node`, `class GraphNode is Node`) con `submethod BUILD` en `Node` / Value reuse via class inheritance | Valor embebido por composición de atributos / Embedded value by field composition | Raku soporta herencia de clases nativa y constructores `BUILD` heredados; encapsular `$!value` en `Node` centraliza el valor sin duplicar código y cumple el contrato. / Raku provides native single inheritance and inheritable `BUILD` submethods; keeping `$!value` in `Node` centralizes storage without duplication. |
| Adyacencia almacenada como `List` inmutable de Raku (`()`), construida manualmente / Adjacency stored as immutable Raku `List` | Array mutable (`Array`) o lista enlazada manual (`NeighborNode`) / Mutable array or custom linked nodes | `List` en Raku es inmutable por diseño. Al insertar aristas se genera una nueva lista ordenada a mano (`!insert-neighbor`), lo que garantiza de forma inmediata el aislamiento del resultado devuelto por `get-neighbors` sin copias defensivas. / Raku's `List` is immutable by design. Inserting an edge creates a new sorted list, guaranteeing neighbor-result isolation without defensive copies. |
| Registro canónico de vértices mediante lista enlazada simple (`$!next-vertex`) / Canonical vertex registry via singly linked list | Diccionario (`Hash`), conjunto (`Set`) o tabla indexada / Hash map, set, or indexed table | La especificación prohíbe delegar el registro de vértices en tablas hash o colecciones asociativas para preservar el coste manual $O(V)$ canónico en Fase 1. / The specification strictly forbids hash tables or associative collections for the vertex registry to ensure manual $O(V)$ complexity in Phase 1. |
| Nomenclatura en kebab-case (`get-value`, `get-left`, `add-vertex`, etc.) / Kebab-case naming convention | snake_case exacto (`get_value`, `add_vertex`) / Exact snake_case | Convención léxica e idiomática estándar en Raku, alineada con las bases `data_structures_basics`, `naive_sort` y `numbers`. / Idiomatic Raku naming standard, aligned with reference bases. |

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| `type Node`, `type TreeNode extends Node`, `type GraphNode extends Node` | `class Node`, `class TreeNode is Node is export`, `class GraphNode is Node` | Clases nativas de Raku con atributos privados estrictamente encapsulados (`$!value`, `$!left`, etc.) y exportación selectiva mediante `is export`. / Idiomatic Raku OOP classes with private encapsulated attributes and explicit exports. |
| Representación de ausencia de enlaces (`absent`) / Absent link representation | Tipos indefinidos `TreeNode:U`, `GraphNode:U` y centinela `Nil` / Undefined type objects and `Nil` | Raku modela la ausencia tipada mediante objetos de tipo no instanciados (`Type:U`), que evalúan a `False` con `.defined`, evitando punteros nulos no tipados. / Raku uses undefined type objects (`Type:U`) to represent typed absence cleanly. |
| Nombres de métodos en snake_case (`get_value`, `is_empty`, etc.) / Method naming | Nombres de métodos en kebab-case (`get-value`, `is-empty`, etc.) / Kebab-case method names | Convención léxica de Raku para identificadores de métodos públicos. / Standard lexical convention for Raku public methods. |
| Layout `src/` y `test/` con script `run_tests.ext` / Expected layout | Layout `lib/` y `t/` con runner `prove6` / `lib/` and `t/` with `prove6` | Disposición canónica de proyectos en el ecosistema de Raku. / Canonical project structure in the Raku ecosystem. |
| Caso de entrada nula (`Nil`) en operaciones públicas / Null input cases | Omitido en la suite de pruebas / Omitted in test suite | Los parámetros de métodos públicos están tipados como `Int`; pasar `Nil` o tipos incompatibles produce un error de firma de tipos en tiempo de llamada, no un valor evaluable como caso de prueba. / Method parameters are strictly typed as `Int`; passing `Nil` fails at signature binding. |
| Modificación in-place de la copia devuelta por `get_neighbors` / Modify returned copy in-place | Omitida la mutación in-place de la secuencia / In-place mutation omitted | En Raku, `List` es inmutable. El aislamiento se verifica comprobando que la referencia guardada previamente conserva sus elementos tras insertar aristas posteriores. / `List` is immutable in Raku; isolation is verified by asserting that prior results remain unchanged after subsequent edge insertions. |

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `TreeNode.get-left` / `get-right` | Enlace ausente (`$!left` o `$!right` no asignado o desenlazado) / Absent link | `TreeNode:U` (`.defined == False`) | `TreeNode.new(value => 10).get-left.defined` → `False` |
| `BinaryTree.contains` | Valor no presente en el árbol / Value absent from tree | `False` | `BinaryTree.new.contains(50)` → `False` |
| `Graph.add-edge` | Vértice origen $u$ o destino $v$ no registrado / Missing endpoint | `False` | `graph.add-edge(10, 99)` → `False` |
| `Graph.has-edge` | Arista inexistente o extremo no registrado / Missing edge or endpoint | `False` | `graph.has-edge(10, 30)` → `False` |
| `Graph.get-neighbors` | Vértice $u$ no registrado en el grafo / Missing vertex | `Nil` | `graph.get-neighbors(99)` → `Nil` |
| Operaciones con parámetros de entrada (`$value`, `$u`, `$v`) | Entrada nula (`Nil`) / Null input | No representable / Not representable | La firma tipada (`Int $value`, `Int $u`, `Int $v`) rechaza `Nil` en tiempo de signatura en Raku. / Strictly typed signatures reject `Nil`. |

## ✅ Cobertura de pruebas / Test coverage

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| `TreeNode`: Crear un nodo de árbol / Create a tree node | Sí / Yes | `t/tree-node-tests.rakutest:23` | `TreeNode.new(value => 10)` verifica `get-value == 10`. |
| `TreeNode`: Enlaces iniciales ausentes / Absent initial links | Sí / Yes | `t/tree-node-tests.rakutest:31` | `get-left` y `get-right` no están definidos (`TreeNode:U`). |
| `TreeNode`: Enlazar dos hijos / Link two children | Sí / Yes | `t/tree-node-tests.rakutest:39` | `set-left(20)` y `set-right(30)`; verifica valores. |
| `TreeNode`: Recorrer cada enlace / Traverse each link | Sí / Yes | `t/tree-node-tests.rakutest:48` | Recorrido a hijos y confirmación de enlaces ausentes en hojas. |
| `TreeNode`: Desenlazar hijos / Unlink children | Sí / Yes | `t/tree-node-tests.rakutest:65` | Asignación de `TreeNode:U` a enlaces izquierdo y derecho. |
| `TreeNode`: Adaptación inmutable (si aplica) / Immutable adaptation | Omitido / Omitted | — | `TreeNode` es mutable en Raku; muta atributos in-place. |
| `BinaryTree`: Crear vacío / Create empty | Sí / Yes | `t/binary-tree-tests.rakutest:24` | `is-empty == True`, `size == 0`, `contains(50) == False`. |
| `BinaryTree`: Insertar la raíz / Insert the root | Sí / Yes | `t/binary-tree-tests.rakutest:32` | `insert(50)` exitoso, `size == 1`, `contains(50) == True`. |
| `BinaryTree`: Insertar menor y mayor / Insert lower and higher | Sí / Yes | `t/binary-tree-tests.rakutest:40` | Inserción de 50, 30, 70; `size == 3` y los 3 presentes. |
| `BinaryTree`: Ramas de varios niveles / Multilevel branches | Sí / Yes | `t/binary-tree-tests.rakutest:56` | Inserción de 50, 30, 70, 20, 40; `size == 5`. |
| `BinaryTree`: Valor ausente en árbol no vacío / Missing value in nonempty tree | Sí / Yes | `t/binary-tree-tests.rakutest:67` | `contains(99) == False`; conserva tamaño y raíz. |
| `BinaryTree`: Duplicado idempotente / Idempotent duplicate | Sí / Yes | `t/binary-tree-tests.rakutest:76` | Reinsertar 30 retorna `True` pero conserva `size == 3`. |
| `BinaryTree`: Inserciones ordenadas / Ordered insertions | Sí / Yes | `t/binary-tree-tests.rakutest:86` | Inserción ordenada 20, 30, 40, 50, 70; pertenencia total. |
| `Graph`: Crear vacío / Create empty | Sí / Yes | `t/graph-tests.rakutest:32` | Grafo vacío: `vertex-count == 0`, `edge-count == 0`, `is-empty == True`, `has-edge` y `get-neighbors` fallan. |
| `Graph`: Vértice aislado / Isolated vertex | Sí / Yes | `t/graph-tests.rakutest:43` | `add-vertex(10)`; 1 vértice, 0 aristas, vecinos vacíos `()`. |
| `Graph`: Etiquetas no consecutivas y arista dirigida / Nonconsecutive labels and directed edge | Sí / Yes | `t/graph-tests.rakutest:52` | Vértices 10 y 70; `add-edge(10, 70)` dirigida; `has-edge(70, 10) == False`. |
| `Graph`: Vértice duplicado conserva adyacencia / Duplicate vertex preserves adjacency | Sí / Yes | `t/graph-tests.rakutest:69` | Re-registrar vértice 10 preserva adyacencia previa `(30,)`. |
| `Graph`: Arista duplicada / Duplicate edge | Sí / Yes | `t/graph-tests.rakutest:83` | `add-edge(10, 30)` repetido es idempotente: 1 arista. |
| `Graph`: Extremo inexistente sin mutación / Missing endpoint without mutation | Sí / Yes | `t/graph-tests.rakutest:97` | Fallo con extremos 98 o 99; no altera vértices ni aristas. |
| `Graph`: Vecinos ordenados y contadores / Sorted neighbours and counts | Sí / Yes | `t/graph-tests.rakutest:122` | Aristas insertadas desordenadas resultan en vecinos ordenados `(30, 50, 70)`. |
| `Graph`: Consulta de arista ausente / Missing-edge query | Sí / Yes | `t/graph-tests.rakutest:145` | `has-edge(10, 30) == False` en grafo sin aristas añadidas. |
| `Graph`: Vecinos de vértice inexistente / Neighbours of missing vertex | Sí / Yes | `t/graph-tests.rakutest:158` | `get-neighbors(99)` devuelve `Nil`, distinto de `()`. |
| `Graph`: Bucle y duplicado / Self-loop and duplicate | Sí / Yes | `t/graph-tests.rakutest:170` | `add-edge(10, 10)` dos veces; bucle `(10,)` y 1 arista. |
| `Graph`: Aislamiento del resultado de vecinos / Neighbour-result isolation | Sí / Yes | `t/graph-tests.rakutest:184` | Resultado guardado `(30,)` no varía tras insertar arista `(10, 50)`. |
| `Graph`: Modificar copia devuelta / Modify returned copy | Omitido / Omitted | — | `List` es inmutable en Raku; no admite mutación in-place. |
| Casos con entrada nula (`Nil`) / Null input cases | Omitido / Omitted | — | Parámetros tipados estrictamente como `Int`; `Nil` no admisible. |

**Organización de pruebas / Test organisation:**

- `TreeNode`: 5 casos aplicables → subtest `TreeNode operations` → archivo `t/tree-node-tests.rakutest` → runner `prove6`.
- `BinaryTree`: 7 casos aplicables → subtest `BinaryTree operations` → archivo `t/binary-tree-tests.rakutest` → runner `prove6`.
- `Graph`: 11 casos aplicables → subtest `Graph operations` → archivo `t/graph-tests.rakutest` → runner `prove6`.

El ejecutor nativo `prove6` ejecuta los 3 archivos y reporta el éxito de los 3 subtests (`Tests=3`), validando las 23 aserciones compuestas de la especificación.

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| Dominio restringido a enteros (`Int`) / Restricted to integer types | Las estructuras no admiten tipos heterogéneos o parametrizados / No parameterized generics | Adecuado para Fase 1 (Algoritmos Puros); la generalización genérica se reservará para fases posteriores. / Sufficient for Phase 1 pure algorithms; generics deferred to later phases. |
| Registro lineal de vértices ($O(V)$) / Linear vertex registry | La localización de vértices en grafos de gran tamaño tiene coste $O(V)$ / Vertex lookup scales linearly | Cumple el requisito de implementación manual de Fase 1 sin tablas hash; optimizaciones indexadas pertenecerán a fases avanzadas. / Complies with Phase 1 manual implementation; indexed lookups belong to future phases. |

## 📝 Notas de implementación / Implementation Notes

- **Herencia y constructor base**: La clase `Node` define `submethod BUILD(Int :$value!)` para enlazar adecuadamente el parámetro con nombre a su atributo privado. `TreeNode` y `GraphNode` heredan de `Node`, evitando duplicación de lógica.
- **Ausencia tipada**: Se utiliza `TreeNode:U` y `GraphNode:U` para modelar punteros vacíos; en Raku, los objetos de tipo no instanciados son seguros y evalúan a `False` en comprobaciones booleanas (`.defined`).
- **Inmutabilidad de secuencias de adyacencia**: La lista de vecinos se almacena como `List` (`()`). La operación privada `!insert-neighbor` inserta de manera ordenada generando una nueva `List` inmutable. Esto garantiza que las referencias devueltas por `get-neighbors` estén aisladas frente a modificaciones posteriores del grafo.
- **Implementación manual estricta**: No se utilizan colecciones asociativas (`Hash`, `Set`, `Map`) ni algoritmos de ordenación integrados de la biblioteca estándar para el registro ni para la adyacencia.
- **Runner nativo `prove6`**: Al igual que en `numbers` y `data_structures_basics`, se prescinde de un script `run_tests` ad hoc, delegando en `prove6` que descubre y ejecuta automáticamente todos los archivos `.rakutest` bajo `t/`.

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
| Especificación / Specification | [`07_Data_Structures_Advanced.md`](../../../../docs/core/algorithms/07_Data_Structures_Advanced.md) |
| Primera base del lenguaje / First language reference | [`raku/core/algorithms/data_structures_basics/`](../data_structures_basics/README.md) |
| Segunda base del lenguaje / Second language reference | [`raku/core/foundations/numbers/`](../../foundations/numbers/README.md) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](../../../../docs/core/00_Project_Initialization_Guide.md) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](../../../../docs/AGENT_Template.md) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](../../../../docs/WORKFLOW.md) |
| Documentación oficial de Raku / Official Raku documentation | [Raku Documentation (Classes and Objects)](https://docs.raku.org/language/classtut) |
