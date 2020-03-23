use v6.c;
use Test;
use Date::Calendar::Mayan;
#use Date::Calendar::Mayan::Spinden;
#use Date::Calendar::Mayan::Astronomical;

# Checking 2020-03-11 with the Goodman Martinez Thompson correlation
# see http://research.famsi.org/date_mayaLC.php
# or checking 1760-03-14 with the Spinden correlation
# or checking 2020-03-13 with the Astronomical correlation

plan 1     # dates
     × 7   # locale-independant methods
;

#my Date::Calendar::Mayan          $d1 .= new-from-date(Date.new(2020, 3, 11));
my Date::Calendar::Mayan          $d2 .= new(long-count => '13.0.7.5.17');
#my Date::Calendar::Mayan::Spinden      $d3 .= new-from-date(Date.new(1760, 3, 14));
#my Date::Calendar::Mayan::Astronomical $d4 .= new-from-date(Date.new(2020, 3, 13));

for $d2 -> $date {
  is($date.baktun    , 13);
  is($date.katun     ,  0);
  is($date.tun       ,  7);
  is($date.uinal     ,  5);
  is($date.kin       , 17);
  is($date.gist      , '13.0.7.5.17');
  is($date.long-count, '13.0.7.5.17');
}

done-testing;

