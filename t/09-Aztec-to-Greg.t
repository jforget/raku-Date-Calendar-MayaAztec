use v6.c;
use Test;
use Date::Calendar::Aztec;
use Date::Calendar::Aztec::Cortes;

my @tests-nearest = load-nearest();

plan @tests-nearest.elems;

for @tests-nearest -> $data {
  my ($ref, $month, $day, $cle-num, $cle-idx, $result) = $data;
  my Date::Calendar::Aztec $da .= new(month => $month, day => $day
                                    , clerical-number => $cle-num
                                    , clerical-index => $cle-idx
                                    , nearest => Date.new($ref));
  my Date $dg = $da.to-date;
  is($dg, $result);
}
sub load-nearest {
  return (
      ('2001-01-01', 15,  5, 11,  3, '2020-07-15')
    , ('2001-01-01', 15,  6, 12,  4, '2020-07-16')
  );
}
