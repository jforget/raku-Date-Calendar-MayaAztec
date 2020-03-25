use v6.c;
use Test;
use Date::Calendar::Mayan;


my @tests = load-data();

plan 4 × @tests.elems;

for @tests -> $data {
  my ($greg, $long-count, $tzolkin, $haab) = $data;
  my Date::Calendar::Mayan $date-m .= new( long-count => $long-count);
  my Date $date-g = $date-m.to-date('Date');
  is($date-g.gist, $greg);
}
for @tests -> $data {
  my ($greg, $long-count, $tzolkin, $haab) = $data;
  my Date::Calendar::Mayan $date-m .= new-from-date(Date.new($greg));
  is($date-m.gist   , $long-count);
  is($date-m.tzolkin, $tzolkin);
  is($date-m.haab   , $haab);
}

sub load-data {
  # generated with Reingold's and Dershowitz' calendar.l
  # some dates cross-checked with http://research.famsi.org/date_mayaLC.php
  return ( 
      ('-3113-08-11', '0.0.0.0.0'      , '4 Ahau'       , '8 Cumku'      )
    , ('-3113-08-13', '0.0.0.0.2'      , '6 Ik'         , '10 Cumku'     )
    , ('-3113-08-31', '0.0.0.1.0'      , '11 Ahau'      , '3 Pop'        )
    , ('-3112-08-04', '0.0.0.17.19'    , '12 Cauac'     , '2 Cumku'      )
    , ('-3112-08-05', '0.0.1.0.0'      , '13 Ahau'      , '3 Cumku'      )
    , ( '1618-09-17', '11.19.19.17.19' , '4 Cauac'      , '12 Zotz'      )
    , ( '1618-09-18', '12.0.0.0.0'     , '5 Ahau'       , '13 Zotz'      )
    , ( '2012-12-20', '12.19.19.17.19' , '3 Cauac'      , '2 Kankin'     )
    , ( '2012-12-21', '13.0.0.0.0'     , '4 Ahau'       , '3 Kankin'     )
    , ( '2019-11-14', '13.0.6.17.19'   , '1 Cauac'      , '7 Ceh'        )
    , ( '2019-11-15', '13.0.7.0.0'     , '2 Ahau'       , '8 Ceh'        )
    , ( '2020-03-23', '13.0.7.6.9'     , '1 Muluc'      , '17 Cumku'     )
    , ( '2020-11-08', '13.0.7.17.19'   , '10 Cauac'     , '2 Ceh'        )
    , ( '2020-11-09', '13.0.8.0.0'     , '11 Ahau'      , '3 Ceh'        )
);
}
