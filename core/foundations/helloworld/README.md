# Hello, World! — Raku

Implementación de la especificación [01_Hello_World](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) en **Raku**, con un enfoque manual y minimalista.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`hello_world.raku`](hello_world.raku) | Código fuente: imprime `"Hello, World! from Raku"` en la salida estándar. |

**Estructura de directorios esperada:**

```text
helloworld/
├── hello_world.raku  # Código fuente
└── README.md         # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente, sin herramientas de scaffolding. Un único archivo `.raku` es suficiente: Raku es un lenguaje interpretado (compila a bytecode sobre la marcha), por lo que no requiere compilación previa para ejecutarse.

**EN:** The project was created manually, without scaffolding tools. A single `.raku` file is enough: Raku is an interpreted language (it compiles to bytecode on the fly), so no prior compilation is required to run it.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p raku/core/foundations/helloworld
   ```

2. Escribir el archivo `hello_world.raku` con el código fuente.

3. No se necesita ningún paso adicional de construcción o vinculación de dependencias.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración de build. El programa se ejecuta directamente con el intérprete `raku`.

```raku
say 'Hello, World! from Raku';
```

| Elemento | Propósito |
|----------|-----------|
| `say` | Función que imprime sus argumentos en la salida estándar, separados por espacios y seguidos de un salto de línea (`\n`). |
| `'Hello, World! from Raku'` | Argumento: la cadena a imprimir (comillas simples = cadena literal, sin interpolación). |

> **ES:** Raku distingue `say` (con salto de línea al final) de `print` (sin salto de línea). Con comillas simples la cadena es literal; con comillas dobles (`"..."`) se interpola `$variable` y secuencias como `\n`.
> **EN:** Raku distinguishes `say` (with a trailing newline) from `print` (without newline). With single quotes the string is literal; with double quotes (`"..."`) it interpolates `$variable` and sequences like `\n`.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener Rakudo instalado

```bash
# Verificar instalación
raku --version
```

> **ES:** Rakudo es la implementación de Raku; puede instalarse con el gestor de versiones `rakubrew` (`rakubrew download 2026.07` + `rakubrew global 2026.07`) o con `sudo apt install rakudo`.
> **EN:** Rakudo is the Raku implementation; it can be installed with the `rakubrew` version manager (`rakubrew download 2026.07` + `rakubrew global 2026.07`) or with `sudo apt install rakudo`.

### Ejecutar directamente / Run directly

```bash
cd raku/core/foundations/helloworld
raku hello_world.raku
```

### Verificar sintaxis sin ejecutar (opcional) / Check syntax without running (optional)

```bash
raku -c hello_world.raku
```

### Salida esperada / Expected output

```text
Hello, World! from Raku
```

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Raku no requiere una función `main`: el script se ejecuta de arriba a abajo como en lenguajes de scripting.
- **EN:** Raku does not require a `main` function: the script executes top to bottom like in scripting languages.
- **ES:** `say` escribe en `stdout` y añade automáticamente un salto de línea.
- **EN:** `say` writes to `stdout` and automatically appends a newline.
- **ES:** El punto y coma (`;`) es el separador de sentencias de Raku.
- **EN:** The semicolon (`;`) is Raku's statement separator.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
