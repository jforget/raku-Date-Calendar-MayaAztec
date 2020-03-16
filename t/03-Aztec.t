use v6.c;
use Test;
use Date::Calendar::Aztec;

# Checking 2020-03-11 with the Alfonso Caso correlation
# see https://www.azteccalendar.com/?day=11&month=3&year=2020
# or checking 2020-03-08 with the Francisco Cortès correlation
# or checking 2072-02-27 with the Caso correlation (1 calendar round later)
# or checking 1968-03-24 with the Caso correlation (1 calendar round earlier)

plan 2              # dates
     × ( 8          # locale-independant methods
        + 3 × 7)    # locales and locale-dependant methods
;

my Date::Calendar::Aztec $date1 .= new(month           =>  8
                                     , day             => 19
                                     , clerical-number =>  2
                                     , clerical-index  => 17
                                     , locale          => 'nah');

my Date::Calendar::Aztec $date2 .= new(xiuhpohualli-index   =>  8
                                     , xiuhpohualli-number  => 19
                                     , tonalpohualli-number =>  2
                                     , tonalpohualli-index  => 17
                                     , locale               => 'nah');

#my Date::Calendar::Aztec         $d1 .= new-from-date(Date.new('1968-03-24');
#my Date::Calendar::Aztec         $d2 .= new-from-date(Date.new('2020-03-11');
#my Date::Calendar::Aztec         $d3 .= new-from-date(Date.new('2072-02-27');
#my Date::Calendar::Aztec::Cortes $dc .= new-from-date(Date.new('2020-03-08');
#
#for ($date1, $date2, $d1, $d2, $d3, $dc) -> $d {
for ($date1, $date2) -> $d {
  testing-calendar-round($d);
  testing-Nahuatl($d);
  $d.locale = 'en';
  testing-English($d);
  $d.locale = 'fr';
  testing-French($d);
}

done-testing;

sub testing-calendar-round($date) {
  is($date.month               ,  8);
  is($date.day                 , 19);
  is($date.clerical-number     ,  2);
  is($date.clerical-index      , 17);
  is($date.gist                , '19-8 2-17');
  is($date.tonalpohualli-number,  2);
  is($date.tonalpohualli-index , 17);
  is($date.xiuhpohualli-number , 19);
}

sub testing-Nahuatl($date) {
  is($date.locale         , 'nah');
  is($date.month-name     , 'Tecuilhuitontli');
  is($date.day-name       , 'Ollin');
  is($date.tonalpohualli-name  , 'Ollin');
  is($date.tonalpohualli       , '2 Ollin');
  is($date.xiuhpohualli-name   , 'Tecuilhuitontli');
  is($date.xiuhpohualli        , '19 Tecuilhuitontli');
}

sub testing-English($date) {
  is($date.locale         , 'en');
  is($date.month-name     , '1-lords feast');
  is($date.day-name       , 'Movement');
  is($date.tonalpohualli-name  , 'Movement');
  is($date.tonalpohualli       , '2 Movement');
  is($date.xiuhpohualli-name   , '1-lords feast');
  is($date.xiuhpohualli        , '19 1-lords feast');
}

sub testing-French($date) {
  is($date.locale         , 'fr');
  is($date.month-name     , 'Petite fête des dignitaires');
  is($date.day-name       , 'Mouvement');
  is($date.tonalpohualli-name  , 'Mouvement');
  is($date.tonalpohualli       , '2 Mouvement');
  is($date.xiuhpohualli-name   , 'Petite fête des dignitaires');
  is($date.xiuhpohualli        , '19 Petite fête des dignitaires');
}
