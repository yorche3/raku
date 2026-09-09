unit module Numbers;

# Direct recursion (_rec)

sub sum_of_first_n_rec($n) is export {
  return $n == 0 ?? 0 !! $n + sum_of_first_n_rec($n - 1);
}

sub factorial_rec($n) is export {
  return $n == 0 ?? 1 !! $n * factorial_rec($n - 1);
}

sub fibonacci_rec($n) is export {
  return $n <= 1 ?? $n !! fibonacci_rec($n - 1) + fibonacci_rec($n - 2);
}

sub greatest_common_divisor_rec($a, $b) is export {
  return $b == 0 ?? $a !! greatest_common_divisor_rec($b, $a % $b);
}

sub least_common_multiple_rec($a, $b) is export {
  return ($a * $b) div greatest_common_divisor_rec($a, $b);
}

# Accumulator recursion (_acc): tail calls, TCO in Rakudo

sub sum_of_first_n_acc($n) is export {
  return sum_of_first_n_acc_help($n, 0);
}

sub sum_of_first_n_acc_help($n, $acc) {
  return $n <= 0 ?? $acc !! sum_of_first_n_acc_help($n - 1, $n + $acc);
}

sub factorial_acc($n) is export {
  return factorial_acc_help($n, 1);
}

sub factorial_acc_help($n, $acc) {
  return $n <= 1 ?? $acc !! factorial_acc_help($n - 1, $n * $acc);
}

sub fibonacci_acc($n) is export {
  return fibonacci_acc_help($n, 0, 1);
}

sub fibonacci_acc_help($n, $acc2, $acc1) {
  return $n <= 0 ?? $acc2 !!
         $n <= 2 ?? $acc1 + $acc2 !!
         fibonacci_acc_help($n - 1, $acc1, $acc1 + $acc2);
}

sub greatest_common_divisor_acc($a, $b) is export {
  return greatest_common_divisor_acc_help($a, $b);
}

sub greatest_common_divisor_acc_help($a, $b) {
  return $b == 0 ?? $a !! greatest_common_divisor_acc_help($b, $a % $b);
}

sub least_common_multiple_acc($a, $b) is export {
  return ($a * $b) div greatest_common_divisor_acc($a, $b);
}

# Iterative (_ite): native loops

sub sum_of_first_n_ite($n) is export {
  my $result = 0;
  for 1..$n -> $i {
    $result = $result + $i;
  }
  return $result;
}

sub factorial_ite($n) is export {
  my $result = 1;
  for 1..$n -> $i {
    $result = $result * $i;
  }
  return $result;
}

sub fibonacci_ite($n) is export {
  return $n if $n <= 1;
  my $acc2 = 0;
  my $acc1 = 1;
  for 2..$n -> $i {
    my $temp = $acc1 + $acc2;
    $acc2 = $acc1;
    $acc1 = $temp;
  }
  return $acc1;
}

sub greatest_common_divisor_ite($a, $b) is export {
  my $a2 = $a;
  my $b2 = $b;
  while $b2 != 0 {
    my $temp = $b2;
    $b2 = $a2 % $b2;
    $a2 = $temp;
  }
  return $a2;
}

sub least_common_multiple_ite($a, $b) is export {
  return ($a * $b) div greatest_common_divisor_ite($a, $b);
}
