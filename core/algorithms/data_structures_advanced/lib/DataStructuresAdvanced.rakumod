unit module DataStructuresAdvanced;

# Node guarda solo el valor. El constructor por defecto de Raku no asigna
# atributos privados desde argumentos con nombre, así que BUILD lo hace; las
# subclases lo heredan y no necesitan redefinirlo.
class Node {
    has Int $!value;

    submethod BUILD(Int :$value!) {
        $!value = $value;
    }

    method get-value(--> Int:_) {
        $!value;
    }
}

# Los enlaces ausentes son el tipo `TreeNode` sin instanciar, que responde
# `False` a `.defined`.
class TreeNode is Node is export {

    has TreeNode $!left = TreeNode;
    has TreeNode $!right = TreeNode;

    method get-left(--> TreeNode:_) {
        $!left;
    }

    method get-right(--> TreeNode:_) {
        $!right;
    }

    method set-left(TreeNode:_ $node --> TreeNode:_) {
        $!left = $node;
        $!left;
    }

    method set-right(TreeNode:_ $node --> TreeNode:_) {
        $!right = $node;
        $!right;
    }
}

class BinaryTree is export {

    has TreeNode $!root;
    has Int $!count = 0;

    method insert(Int $value --> Bool) {
        if !$!root.defined {
            $!root = TreeNode.new(value => $value);
            $!count++;
            return True;
        }
        my $current = $!root;
        loop {
            my $v = $current.get-value;
            if $value == $v {
                return True;
            }
            elsif $value < $v {
                if !$current.get-left.defined {
                    $current.set-left(TreeNode.new(value => $value));
                    $!count++;
                    return True;
                }
                $current = $current.get-left;
            }
            else {
                if !$current.get-right.defined {
                    $current.set-right(TreeNode.new(value => $value));
                    $!count++;
                    return True;
                }
                $current = $current.get-right;
            }
        }
    }

    method contains(Int $value --> Bool) {
        my $current = $!root;
        while $current.defined {
            my $v = $current.get-value;
            if $value == $v {
                return True;
            }
            elsif $value < $v {
                $current = $current.get-left;
            }
            else {
                $current = $current.get-right;
            }
        }
        return False;
    }

    method is-empty(--> Bool) {
        $!count == 0;
    }

    method size(--> Int) {
        $!count;
    }
}

class GraphNode is Node {

    has List $!neighbors = ();
    has GraphNode $!next-vertex = GraphNode;

    method get-neighbors(--> List:_) {
        $!neighbors;
    }
    method set-neighbors(List $neighbors --> List:_) {
        $!neighbors = $neighbors;
        $!neighbors;
    }

    method get-next-vertex(--> GraphNode:_) {
        $!next-vertex;
    }
    method set-next-vertex(GraphNode:_ $next --> GraphNode:_) {
        $!next-vertex = $next;
        $!next-vertex;
    }
}

class Graph is export {

    has GraphNode $!vertices;
    has Int $!vertex-total = 0;
    has Int $!edges = 0;

    method !find-vertex(Int $label --> GraphNode:_) {
        my $current = $!vertices;
        while $current.defined {
            if $current.get-value == $label {
                return $current;
            }
            $current = $current.get-next-vertex;
        }
        return GraphNode;
    }

    # Pertenencia manual: la Fase 1 no admite rutinas de búsqueda de la
    # biblioteca para el paso interno. Se recorre por índice porque iterar una
    # List vacía con `-> $x` produce una vuelta con la lista entera.
    method !has-neighbor(List $neighbors, Int $label --> Bool) {
        for ^$neighbors.elems -> $index {
            return True if $neighbors[$index] == $label;
        }
        False;
    }

    # Inserción ordenada y sin duplicados, construida a mano.
    method !insert-neighbor(List $neighbors, Int $label --> List) {
        my @sorted;
        my Bool $inserted = False;
        for ^$neighbors.elems -> $index {
            my $current = $neighbors[$index];
            if !$inserted && $label < $current {
                @sorted.push($label);
                $inserted = True;
            }
            @sorted.push($current);
        }
        @sorted.push($label) if !$inserted;
        @sorted.List;
    }

    method add-vertex(Int $label --> Bool) {
        if self!find-vertex($label).defined {
            return True;
        }
        my $new-vertex = GraphNode.new(value => $label);
        $new-vertex.set-next-vertex($!vertices);
        $!vertices = $new-vertex;
        $!vertex-total++;
        return True;
    }

    method add-edge(Int $u, Int $v --> Bool) {
        my $u-vertex = self!find-vertex($u);
        return False if !$u-vertex.defined;
        return False if !self!find-vertex($v).defined;

        my $neighbors = $u-vertex.get-neighbors;
        return True if self!has-neighbor($neighbors, $v);
        $u-vertex.set-neighbors(self!insert-neighbor($neighbors, $v));
        $!edges++;
        return True;
    }

    method has-edge(Int $u, Int $v --> Bool) {
        my $u-vertex = self!find-vertex($u);
        return False if !$u-vertex.defined;
        self!has-neighbor($u-vertex.get-neighbors, $v);
    }

    method get-neighbors(Int $u --> List:_) {
        my $u-vertex = self!find-vertex($u);
        return Nil if !$u-vertex.defined;
        return $u-vertex.get-neighbors;
    }

    method is-empty(--> Bool) {
        return $!vertex-total == 0;
    }

    method vertex-count(--> Int) {
        return $!vertex-total;
    }

    method edge-count(--> Int) {
        return $!edges;
    }
}
