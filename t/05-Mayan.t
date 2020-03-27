use v6.c;
use Test;
use Date::Calendar::Maya;
use Date::Calendar::Maya::Spinden;
use Date::Calendar::Maya::Astronomical;

# Checking 2020-03-11 with the Goodman Martinez Thompson correlation
# see http://research.famsi.org/date_mayaLC.php
# or checking 2020-03-12 with the Spinden correlation

plan 4              # dates
     × ( 9          # locale-independant methods
        + 3 × 9)    # locales and locale-dependant methods
;

my Date::Calendar::Maya               $d1 .= new-from-date(Date.new(2020, 3, 11));
my Date::Calendar::Maya               $d2 .= new(long-count => '13.0.7.5.17');
my Date::Calendar::Maya::Spinden      $d3 .= new-from-date(Date.new(2020, 3, 12));
my Date::Calendar::Maya::Astronomical $d4 .= new-from-date(Date.new(2020, 3, 13));

for $d1, $d2, $d3, $d4 -> $d {
  testing-calendar-round($d);
  testing-Yucatec($d);
  $d.locale = 'en';
  testing-English($d);
  $d.locale = 'fr';
  testing-French($d);
}

done-testing;

sub testing-calendar-round($date) {
  is($date.month               , 18);
  is($date.day                 ,  5);
  is($date.clerical-number     ,  2);
  is($date.clerical-index      , 17);
  is($date.tzolkin-number      ,  2);
  is($date.tzolkin-index       , 17);
  is($date.haab-number         ,  5);
  is($date.year-bearer-number  ,  8);
  is($date.year-bearer-index   , 12);
}

sub testing-Yucatec($date) {
  is($date.locale          , 'yua');
  is($date.month-name      , 'Cumku');
  is($date.day-name        , 'Caban');
  is($date.tzolkin-name    , 'Caban');
  is($date.tzolkin         , '2 Caban');
  is($date.haab-name       , 'Cumku');
  is($date.haab            , '5 Cumku');
  is($date.year-bearer-name, 'Eb');
  is($date.year-bearer     , '8 Eb');
}

sub testing-English($date) {
  is($date.locale          , 'en');
  is($date.month-name      , 'Dark god');
  is($date.day-name        , 'Quake');
  is($date.tzolkin-name    , 'Quake');
  is($date.tzolkin         , '2 Quake');
  is($date.haab-name       , 'Dark god');
  is($date.haab            , '5 Dark god');
  is($date.year-bearer-name, 'Tooth');
  is($date.year-bearer     , '8 Tooth');
}

sub testing-French($date) {
  is($date.locale          , 'fr');
  is($date.month-name      , 'Cumku');
  is($date.day-name        , 'Mouvement');
  is($date.tzolkin-name    , 'Mouvement');
  is($date.tzolkin         , '2 Mouvement');
  is($date.haab-name       , 'Cumku');
  is($date.haab            , '5 Cumku');
  is($date.year-bearer-name, 'Herbe');
  is($date.year-bearer     , '8 Herbe');
}
