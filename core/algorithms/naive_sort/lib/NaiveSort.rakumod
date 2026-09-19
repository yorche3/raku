unit module NaiveSort;

# naive_sort — ordenamientos elementales O(n²).
#
# Especificación: 05_Naive_Sort
#
# Contrato: recibe una lista de enteros y devuelve la lista ordenada de menor a
# mayor (in-place o como copia ordenada), sin invocar `.sort` ni ninguna
# biblioteca de ordenamiento, y sin estructuras auxiliares complejas.
# En Raku un parámetro `@array` no admite `Nil` (el compilador rechaza la
# llamada), así que el caso nulo no es representable y se conservan los 7 casos
# de la especificación. La lista vacía se devuelve tal cual y no lanza
# excepciones.
#
# Implementación pendiente: la escribe el autor. Esta delegación solo genera el
# esqueleto y las pruebas unitarias.
