unit module NaiveSort;

# naive_sort — ordenamientos elementales O(n²).
#
# Especificación: 05_Naive_Sort
#
# Contrato: recibe una lista de enteros y devuelve la lista ordenada de menor a
# mayor, sin invocar `.sort` ni ninguna biblioteca de ordenamiento, y sin
# estructuras auxiliares complejas. Los tres algoritmos ordenan in-place la
# copia local del parámetro y devuelven el array ordenado; la lista vacía se
# devuelve tal cual y no se lanza ninguna excepción.
#
# En Raku un parámetro con sigilo `@array` no admite `Nil` —el compilador
# rechaza la llamada con «Calling f(Nil) will never work with declared signature
# (@arr)»—, así que el caso nulo de la especificación no es representable y se
# conservan sus 7 casos.
#
# Los identificadores usan kebab-case, que es la convención de Raku, y los
# nombres `snake_case` de la especificación se conservan como nombre del
# `subtest` y en el mensaje de cada aserción.
sub selection-sort(@array) is export {
    my $n = @array.elems;
    if $n <= 1 {
        return @array;
    }
    for 0 ..^ $n - 1 -> $i {
        my $min-index = $i;
        for $i + 1 ..^ $n -> $j {
            if @array[$j] < @array[$min-index] {
                $min-index = $j;
            }
        }
        if $min-index != $i {
            my $temp = @array[$i];
            @array[$i] = @array[$min-index];
            @array[$min-index] = $temp;
        }
    }
    return @array;
}

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

sub insertion-sort(@array) is export {
    my $n = @array.elems;
    if $n <= 1 {
        return @array;
    }
    for 1 ..^ $n -> $i {
        my $current = @array[$i];
        my $j = $i - 1;
        while $j >= 0 && @array[$j] > $current {
            @array[$j + 1] = @array[$j];
            $j--;
        }
        @array[$j + 1] = $current;
    }
    return @array;
}