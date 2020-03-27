use v6.c;
use Test;
use Date::Calendar::Aztec;


my @tests = ( (2020,  3, 18, '6-9 9-4'     , '8 Tecpatl'  )
            , (2011, 10,  6, '5-19 4-18'   , '12 Acatl'   )
            , (2011, 10,  7, '1-1 5-19'    , '13 Tecpatl' )
            , (2012, 10,  5, '5-19 5-3'    , '13 Tecpatl' )
            , (2012, 10,  6, '1-1 6-4'     , '1 Calli'    )
            , (2018, 10,  5, '1-1 12-14'   , '7 Acatl'    )
            , (2018, 10, 24, '20-1 5-13'   , '7 Acatl'    )
            , (2018, 10, 25, '1-2 6-14'    , '7 Acatl'    )
            , (2019,  9,  9, '20-17 13-13' , '7 Acatl'    )
            , (2019,  9, 10, '1-18 1-14'   , '7 Acatl'    )
            , (2019,  9, 29, '20-18 7-13'  , '7 Acatl'    )
            , (2019,  9, 30, '1-19 8-14'   , '7 Acatl'    )
            , (2019, 10,  4, '5-19 12-18'  , '7 Acatl'    )
            , (2019, 10,  5, '1-1 13-19'   , '8 Tecpatl'  )
            );

plan 2 × @tests.elems;

for @tests -> $data {
  my ($y, $m, $d, $gist, $year-bearer) = $data;
  my Date::Calendar::Aztec $date .= new-from-date(Date.new($y, $m, $d));
  is($date.gist, $gist);
  is($date.year-bearer, $year-bearer);
}
