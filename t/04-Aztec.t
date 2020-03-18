use v6.c;
use Test;
use Date::Calendar::Aztec;


my @tests = ( (2020,  3, 18, '6-9 9-4')
            , (2018, 10,  5, '1-1 12-14')
            , (2018, 10, 24, '20-1 5-13')
            , (2018, 10, 25, '1-2 6-14')
            , (2019,  9,  9, '20-17 13-13')
            , (2019,  9, 10, '1-18 1-14')
            , (2019,  9, 29, '20-18 7-13')
            , (2019,  9, 30, '1-19 8-14')
            , (2019, 10,  4, '5-19 12-18')
	    );

plan @tests.elems;

for @tests -> $data {
  my ($y, $m, $d, $gist) = $data;
  my Date::Calendar::Aztec $date .= new-from-date(Date.new($y, $m, $d));
  is($date.gist, $gist);
}
