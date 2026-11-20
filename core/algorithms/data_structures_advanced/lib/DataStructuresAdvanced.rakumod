unit module DataStructuresAdvanced;

class Node {
    has Int $!value;

    submethod BUILD(Int :$value) {
    }

    method get-value(--> Int:_) {
        Nil;
    }
}

class TreeNode is Node is export {
    submethod BUILD(Int :$value!) {
    }

    method get-left(--> TreeNode:_) {
        Nil;
    }

    method get-right(--> TreeNode:_) {
        Nil;
    }

    method set-left(TreeNode:_ $node --> TreeNode:_) {
        Nil;
    }

    method set-right(TreeNode:_ $node --> TreeNode:_) {
        Nil;
    }
}

class BinaryTree is export {
    method insert(Int $value --> Bool) {
        Nil;
    }

    method contains(Int $value --> Bool) {
        Nil;
    }

    method is-empty(--> Bool) {
        Nil;
    }

    method size(--> Int) {
        Nil;
    }
}

class GraphNode is Node {
    submethod BUILD(Int :$label!) {
    }
}

class Graph is export {
    method add-vertex(Int $label --> Bool) {
        Nil;
    }

    method add-edge(Int $u, Int $v --> Bool) {
        Nil;
    }

    method has-edge(Int $u, Int $v --> Bool) {
        Nil;
    }

    method get-neighbors(Int $u --> List:_) {
        Nil;
    }

    method is-empty(--> Bool) {
        Nil;
    }

    method vertex-count(--> Int) {
        Nil;
    }

    method edge-count(--> Int) {
        Nil;
    }
}
