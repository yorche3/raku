unit module DataStructuresBasics;

# data_structures_basics — Node, LinkedList, Stack y Queue sobre un nodo compartido.
#
# Especificación: 06_Data_Structures_Basics
#
# Contrato Raku: cuatro clases exportadas, una por estructura, con los atributos tipados y
# una operación por cada una de las del contrato. Los identificadores usan kebab-case, que
# es la convención de Raku (`get-value`, `insert-head`, `is-empty`), mientras que la
# especificación y su pseudocódigo los escriben en snake_case (`get_value`, `insert_head`,
# `is_empty`).
#
# Adecuaciones:
#   - `init` del contrato es la construcción de Raku: `Node.new(value => 10)` y
#     `LinkedList.new` / `Stack.new` / `Queue.new` sin argumentos. Las tres estructuras no
#     declaran constructor: sus enlaces quedan ausentes y su contador arranca en 0 por el
#     valor por defecto declarado. `Node` sí declara `new` porque su valor es un argumento
#     del contrato y Raku no asigna argumentos nombrados a atributos privados.
#   - La ausencia de enlace usa el valor indefinido del propio tipo (`Node:U`), que es la
#     representación nativa de Raku; no se fuerza `Nil` ni un tipo opcional nuevo.
#   - El indicador natural de fallo de las lecturas que pueden fallar (`get-head`, `pop`,
#     `peek`, `dequeue`) es `Nil`, la ausencia total de valor de Raku; por eso su tipo de
#     retorno es `Int:_`. No se introducen `Option`/`Maybe`/`Result` ni excepciones.
#   - Las inserciones (`insert-head`, `insert-tail`, `push`, `enqueue`) devuelven el nodo
#     insertado: la especificación fija su efecto sobre el tamaño, no su resultado.
#   - Los esqueletos usan el operador *yada* (`...`), que es el idiom de Raku para «no
#     implementado»: muere con `X::StubCode`. El algoritmo es del paso 5.

# El `Node` es la única celda enlazada del módulo: `LinkedList`, `Stack` y `Queue` usan
# este mismo tipo y gestionan sus propios punteros.
class Node is export {
    has Int $!value;
    has Node $!next;

    # `init(value)` del contrato.
    method new(Int :$value --> Node) {
        ...
    }

    method get-value(--> Int) {
        ...
    }

    method get-next(--> Node:_) {
        ...
    }

    method set-next(Node $next --> Node) {
        ...
    }
}

class LinkedList is export {
    has Node $!head;
    has Node $!tail;
    has Int $!count = 0;

    method get-head(--> Int:_) {
        ...
    }

    method insert-head(Int $value --> Node) {
        ...
    }

    method insert-tail(Int $value --> Node) {
        ...
    }

    method delete(Int $value --> Bool) {
        ...
    }

    method is-empty(--> Bool) {
        ...
    }

    method size(--> Int) {
        ...
    }
}

class Stack is export {
    has Node $!top;
    has Int $!count = 0;

    method push(Int $value --> Node) {
        ...
    }

    method pop(--> Int:_) {
        ...
    }

    method peek(--> Int:_) {
        ...
    }

    method is-empty(--> Bool) {
        ...
    }

    method size(--> Int) {
        ...
    }
}

class Queue is export {
    has Node $!front;
    has Node $!rear;
    has Int $!count = 0;

    method enqueue(Int $value --> Node) {
        ...
    }

    method dequeue(--> Int:_) {
        ...
    }

    method peek(--> Int:_) {
        ...
    }

    method is-empty(--> Bool) {
        ...
    }

    method size(--> Int) {
        ...
    }
}
