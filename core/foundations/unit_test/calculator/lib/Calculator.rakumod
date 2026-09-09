unit module Calculator;

sub addition($a, $b) is export {
  return $a + $b;
}

sub subtraction($a, $b) is export {
  return $a - $b;
}

sub multiplication($a, $b) is export {
  my $result = 0;
  for 1..$b {
    $result = addition($result, $a);
  }
  return $result;
}

sub division($a, $b) is export {
  my $quotient = 0;
  my $rest = $a;
  while $rest >= $b {
    $rest = subtraction($rest, $b);
    $quotient = addition($quotient, 1);
  }
  return $quotient;
}

sub modulus($a, $b) is export {
  my $q = division($a, $b);
  my $p = multiplication($q, $b);
  return subtraction($a, $p);
}
