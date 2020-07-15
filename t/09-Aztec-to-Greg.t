use v6.c;
use Test;
use Date::Calendar::Aztec;
use Date::Calendar::Aztec::Cortes;

my @tests-nearest = load-nearest();
my @tests-ooa     = load-ooa();
my @tests-after   = load-after();
my @tests-oob     = load-oob();
my @tests-before  = load-before();

plan @tests-nearest.elems + @tests-ooa.elems + @tests-after.elems + @tests-oob.elems + @tests-before.elems;

for @tests-nearest -> $data {
  my ($ref, $month, $day, $cle-num, $cle-idx, $result) = $data;
  my Date::Calendar::Aztec $da .= new(month => $month, day => $day
                                    , clerical-number => $cle-num
                                    , clerical-index  => $cle-idx
                                    , nearest         => Date.new($ref));
  my Date $dg = $da.to-date;
  is($dg, $result, $da.strftime("%e %B %V %A nearest to $ref should be $result"));
}

for @tests-ooa -> $data {
  my ($ref, $month, $day, $cle-num, $cle-idx, $result) = $data;
  my Date::Calendar::Aztec $da .= new(month => $month, day => $day
                                    , clerical-number => $cle-num
                                    , clerical-index  => $cle-idx
                                    , on-or-after     => Date.new($ref));
  my Date $dg = $da.to-date;
  is($dg, $result, $da.strftime("%e %B %V %A on or after $ref should be $result"));
}

for @tests-after -> $data {
  my ($ref, $month, $day, $cle-num, $cle-idx, $result) = $data;
  my Date::Calendar::Aztec $da .= new(month => $month, day => $day
                                    , clerical-number => $cle-num
                                    , clerical-index  => $cle-idx
                                    , after           => Date.new($ref));
  my Date $dg = $da.to-date;
  is($dg, $result, $da.strftime("%e %B %V %A after $ref should be $result"));
}

for @tests-oob -> $data {
  my ($ref, $month, $day, $cle-num, $cle-idx, $result) = $data;
  my Date::Calendar::Aztec $da .= new(month => $month, day => $day
                                    , clerical-number => $cle-num
                                    , clerical-index  => $cle-idx
                                    , on-or-before    => Date.new($ref));
  my Date $dg = $da.to-date;
  is($dg, $result, $da.strftime("%e %B %V %A on or before $ref should be $result"));
}

for @tests-before -> $data {
  my ($ref, $month, $day, $cle-num, $cle-idx, $result) = $data;
  my Date::Calendar::Aztec $da .= new(month => $month, day => $day
                                    , clerical-number => $cle-num
                                    , clerical-index  => $cle-idx
                                    , before          => Date.new($ref));
  my Date $dg = $da.to-date;
  is($dg, $result, $da.strftime("%e %B %V %A before $ref should be $result"));
}

sub load-nearest {
  return (
      ('2001-01-01', 15,  5, 11,  3, '2020-07-15')
    , ('2001-01-01', 15,  6, 12,  4, '2020-07-16')
    , ('1994-07-22', 15,  5, 11,  3, '1968-07-28')
    , ('1994-07-23', 15,  5, 11,  3, '2020-07-15')
    , ('2046-07-09', 15,  5, 11,  3, '2020-07-15')
    , ('2046-07-10', 15,  5, 11,  3, '2072-07-02')
  );
}

sub load-ooa {
  return (
      ('2001-01-01', 13, 20, 12, 18, '2020-06-20')
    , ('2001-01-01', 14,  1, 13, 19, '2020-06-21')
    , ('2020-06-19', 13, 20, 12, 18, '2020-06-20')
    , ('2020-06-20', 13, 20, 12, 18, '2020-06-20')
    , ('2020-06-21', 13, 20, 12, 18, '2072-06-07')
  );
}

sub load-after {
  return (
      ('2001-01-01', 13, 20, 12, 18, '2020-06-20')
    , ('2001-01-01', 14,  1, 13, 19, '2020-06-21')
    , ('2020-06-19', 13, 20, 12, 18, '2020-06-20')
    , ('2020-06-20', 13, 20, 12, 18, '2072-06-07')
    , ('2020-06-21', 13, 20, 12, 18, '2072-06-07')
  );
}

sub load-oob {
  return (
      ('2001-01-01',  5,  4, 12,  7, '2000-12-31')
    , ('2001-01-01',  5,  5, 13,  8, '2001-01-01')
    , ('2000-12-31',  5,  4, 12,  7, '2000-12-31')
    , ('2000-12-31',  5,  5, 13,  8, '1949-01-14')
  );
}

sub load-before {
  return (
      ('2001-01-01',  5,  4, 12,  7, '2000-12-31')
    , ('2001-01-01',  5,  5, 13,  8, '1949-01-14')
    , ('2000-12-31',  5,  4, 12,  7, '1949-01-13')
    , ('2000-12-31',  5,  5, 13,  8, '1949-01-14')
  );
}
