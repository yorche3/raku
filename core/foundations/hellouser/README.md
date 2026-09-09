# Hello, User! — Raku

Implementación de la especificación [02_Hello_User](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) en **Raku**, con un enfoque manual y minimalista.

Solicita un nombre al usuario por la entrada estándar (estilo prompt) y saluda.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`hello_user.raku`](hello_user.raku) | Código fuente: solicita un nombre al usuario y saluda. |

**Estructura de directorios esperada:**

```text
hellouser/
├── hello_user.raku  # Código fuente
└── README.md        # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este programa introduce tres conceptos nuevos respecto a `helloworld`:

1. **Variables con sigilo** — `my $name` declara una variable escalar léxica (el sigilo `$` indica escalar).
2. **Entrada de usuario** — `$*IN.get` lee una línea desde la entrada estándar (la variable dinámica `$*IN` es el handle de `stdin`).
3. **Interpolación de cadenas** — las comillas dobles interpolan la variable: `"Hello, $name!"`.

**EN:** This program introduces three new concepts compared to `helloworld`:

1. **Sigiled variables** — `my $name` declares a lexical scalar variable (the sigil `$` indicates a scalar).
2. **User input** — `$*IN.get` reads a line from standard input (the dynamic variable `$*IN` is the `stdin` handle).
3. **String interpolation** — double quotes interpolate the variable: `"Hello, $name!"`.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p raku/core/foundations/hellouser
   ```

2. Escribir el archivo `hello_user.raku` con el código fuente.

3. No se necesita ningún paso adicional de construcción o vinculación de dependencias.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración de build. El programa se ejecuta directamente con el intérprete `raku`.

**ES:** El flujo del programa es:

1. Imprimir `"What is your name?"` con `say` (con salto de línea).
2. Leer una línea desde `stdin` con `$*IN.get` y guardarla en `$name`.
3. Imprimir `"Hello, <nombre>!"` interpolando la variable en la cadena.

**EN:** Program flow:

1. Print `"What is your name?"` with `say` (with newline).
2. Read a line from `stdin` with `$*IN.get` and store it in `$name`.
3. Print `"Hello, <name>!"` interpolating the variable into the string.

```raku
say "What is your name?";
my $name = $*IN.get;
say "Hello, $name!";
```

| Elemento | Propósito |
|----------|-----------|
| `say "..."` | Imprime la cadena en `stdout` con salto de línea al final. |
| `my $name` | Declara una variable escalar léxica; `my` limita su ámbito al bloque actual y `$` es el sigilo de escalar. |
| `$*IN.get` | `$*IN` es el handle dinámico de `stdin`; `.get` lee una línea y la devuelve **sin** el salto de línea final. |
| `"Hello, $name!"` | Comillas dobles: interpolan la variable `$name` dentro de la cadena. |
| `;` | Separador de sentencias de Raku. |

> **ES:** `$*IN` es una variable *twigil*: el `*` indica que es dinámica (se puede redefinir en ámbito dinámico). Su `.get` devuelve `Nil`/`Failure` si la entrada ya terminó.
> **EN:** `$*IN` is a *twigil* variable: the `*` indicates it is dynamic (can be redefined in dynamic scope). Its `.get` returns `Nil`/`Failure` if the input has already ended.

> **ES:** En Raku, con comillas simples (`'...'`) la cadena es literal; la interpolación de `$variables` y secuencias como `\n` solo ocurre con comillas dobles (`"..."`).
> **EN:** In Raku, with single quotes (`'...'`) the string is literal; interpolation of `$variables` and sequences like `\n` only happens with double quotes (`"..."`).

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener Rakudo instalado

```bash
# Verificar instalación
raku --version
```

### Ejecutar / Run

```bash
cd raku/core/foundations/hellouser
raku hello_user.raku
```

**ES:** El programa muestra el prompt y espera a que escribas tu nombre y presiones Enter.
**EN:** The program shows the prompt and waits for you to type your name and press Enter.

### Salida esperada / Expected output

```text
What is your name?
Ada
Hello, Ada!
```

> **ES:** También admite entrada redirigida: `printf 'Ada\n' | raku hello_user.raku` produce el mismo saludo.
> **EN:** It also accepts redirected input: `printf 'Ada\n' | raku hello_user.raku` produces the same greeting.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Raku no requiere una función `main`: el script se ejecuta de arriba a abajo como en lenguajes de scripting.
- **EN:** Raku does not require a `main` function: the script executes top to bottom like in scripting languages.
- **ES:** El prompt usa `say` (con salto de línea) y el saludo interpola la variable con comillas dobles.
- **EN:** The prompt uses `say` (with newline) and the greeting interpolates the variable with double quotes.
- **ES:** El sigilo `$` es parte del nombre de la variable: `name`, `$name`, `@name` y `%name` son variables distintas.
- **EN:** The sigil `$` is part of the variable name: `name`, `$name`, `@name` and `%name` are distinct variables.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
