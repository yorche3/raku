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
#     valor por defecto declarado. `Node` declara el gancho `BUILD` porque su valor es un
#     argumento del contrato: el `BUILD` por defecto de Raku no asigna argumentos nombrados
#     a atributos privados.
#   - La ausencia de enlace —lo único que puede ser `Nil` en esta fase— usa el valor
#     indefinido del propio tipo (`Node:U`) o `Nil`, ambos nativos de Raku; no se introduce
#     un tipo opcional nuevo.
#   - Indicadores de fallo de esta fase (centinelas): las lecturas enteras que pueden fallar
#     (`get-head`, `pop`, `peek`, `dequeue`) devuelven **-1**, y por eso su tipo de retorno es
#     `Int`; los booleanos (`delete`, `is-empty`) devuelven `False`. No se introducen
#     `Option`/`Maybe`/`Result` ni excepciones.
#   - Las inserciones (`insert-head`, `insert-tail`, `push`, `enqueue`) devuelven el nodo
#     insertado: la especificación fija su efecto sobre el tamaño, no su resultado.
#   - Implementación (paso 5): las 23 operaciones siguen el pseudocódigo de la
#     especificación. Los valores de prueba son enteros positivos, así que no colisionan con
#     el centinela -1.

# El `Node` es la única celda enlazada del módulo: `LinkedList`, `Stack` y `Queue` usan
# este mismo tipo y gestionan sus propios punteros.
class Node is export {
    has Int $!value;
    has Node $!next;

    # `init(value)` del contrato: `Node.new(value => 10)`.
    submethod BUILD(Int :$value) {
        $!value = $value;
    }

    method get-value(--> Int) {
        $!value;
    }

    method get-next(--> Node:_) {
        $!next;
    }

    method set-next(Node $next --> Node) {
        $!next = $next;
        self;
    }
}

class LinkedList is export {
    has Node $!head;
    has Node $!tail;
    has Int $!count = 0;

    method get-head(--> Int) {
        return -1 unless $!head;
        $!head.get-value;
    }

    method insert-head(Int $value --> Node) {
        my $node = Node.new(value => $value);
        $node.set-next($!head);
        $!head = $node;
        $!tail //= $node;
        $!count++;
        $node;
    }

    method insert-tail(Int $value --> Node) {
        my $node = Node.new(value => $value);
        if $!tail {
            $!tail.set-next($node);
        }
        $!tail = $node;
        $!head //= $node;
        $!count++;
        $node;
    }

    method delete(Int $value --> Bool) {
        my $current = $!head;
        my Node $previous;
        while $current {
            if $current.get-value == $value {
                if $previous {
                    $previous.set-next($current.get-next);
                } else {
                    $!head = $current.get-next;
                }
                $!tail = $previous if $!tail === $current;
                $!count-- if $!count > 0;
                return True;
            }
            $previous = $current;
            $current = $current.get-next;
        }
        False;
    }

    method is-empty(--> Bool) {
        $!count == 0;
    }

    method size(--> Int) {
        $!count;
    }
}

class Stack is export {
    has Node $!top;
    has Int $!count = 0;

    method push(Int $value --> Node) {
        my $node = Node.new(value => $value);
        $node.set-next($!top);
        $!top = $node;
        $!count++;
        $node;
    }

    method pop(--> Int) {
        return -1 unless $!top;
        my $value = $!top.get-value;
        $!top = $!top.get-next;
        $!count-- if $!count > 0;
        $value;
    }

    method peek(--> Int) {
        return -1 unless $!top;
        $!top.get-value;
    }

    method is-empty(--> Bool) {
        $!count == 0;
    }

    method size(--> Int) {
        $!count;
    }
}

class Queue is export {
    has Node $!front;
    has Node $!rear;
    has Int $!count = 0;

    method enqueue(Int $value --> Node) {
        my $node = Node.new(value => $value);
        if $!rear {
            $!rear.set-next($node);
        }
        $!rear = $node;
        $!front //= $node;
        $!count++;
        $node;
    }

    method dequeue(--> Int) {
        return -1 unless $!front;
        my $value = $!front.get-value;
        $!front = $!front.get-next;
        $!rear = Nil unless $!front;
        $!count-- if $!count > 0;
        $value;
    }

    method peek(--> Int) {
        return -1 unless $!front;
        $!front.get-value;
    }

    method is-empty(--> Bool) {
        $!count == 0;
    }

    method size(--> Int) {
        $!count;
    }
}
