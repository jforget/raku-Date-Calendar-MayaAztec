use v6.c;
use Test;
use Date::Calendar::Aztec;
use Date::Calendar::Aztec::Cortes;

# Checking 2020-03-11 with the Alfonso Caso correlation
# see https://www.azteccalendar.com/?day=11&month=3&year=2020
# or checking 2020-03-08 with the Francisco Cortès correlation
# or checking 2072-02-27 with the Caso correlation (1 calendar round later)
# or checking 1968-03-24 with the Caso correlation (1 calendar round earlier)

plan 6              # dates
     × ( 10         # locale-independant methods
        + 3 × 8)    # locales and locale-dependant methods
;

my Date::Calendar::Aztec $date1 .= new(month           =>  8
                                     , day             => 19
                                     , clerical-number =>  2
                                     , clerical-index  => 17
				     , on-or-after     => Date.new(2000, 1, 1)
                                     , locale          => 'nah');

my Date::Calendar::Aztec $date2 .= new(xiuhpohualli-index   =>  8
                                     , xiuhpohualli-number  => 19
                                     , tonalpohualli-number =>  2
                                     , tonalpohualli-index  => 17
				     , on-or-before         => Date.new(2000, 1, 1)
                                     , locale               => 'nah');

my Date::Calendar::Aztec         $d1 .= new-from-date(Date.new(1968, 3, 24));
my Date::Calendar::Aztec         $d2 .= new-from-date(Date.new(2020, 3, 11));
my Date::Calendar::Aztec         $d3 .= new-from-date(Date.new(2072, 2, 27));
my Date::Calendar::Aztec::Cortes $dc .= new-from-date(Date.new(2020, 3,  8));

for $date1, $date2, $d1, $d2, $d3, $dc -> $d {
  testing-calendar-round($d);
  testing-Nahuatl($d);
  $d.locale = 'en';
  testing-English($d);
  $d.locale = 'fr';
  testing-French($d);
}
is($date1.daycount, 58919);
is($date2.daycount, 39939);
is(   $d1.daycount, 39939);
is(   $d2.daycount, 58919);
is(   $d3.daycount, 77899);
is(   $dc.daycount, 58916);

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
  is($date.strftime("%a %b %c %d %e %f %F %j %m %u %V"), "%a %b %c 19 19  8 %F 159 08 17 2");
}

sub testing-Nahuatl($date) {
  is($date.locale                 , 'nah');
  is($date.month-name             , 'Tecuilhuitontli');
  is($date.day-name               , 'Ollin');
  is($date.tonalpohualli-name     , 'Ollin');
  is($date.tonalpohualli          , '2 Ollin');
  is($date.xiuhpohualli-name      , 'Tecuilhuitontli');
  is($date.xiuhpohualli           , '19 Tecuilhuitontli');
  is($date.strftime("%A %B %G %Y"), "Ollin Tecuilhuitontli 8 Tecpatl 8 Tecpatl");
}

sub testing-English($date) {
  is($date.locale                 , 'en');
  is($date.month-name             , '1-lords feast');
  is($date.day-name               , 'Movement');
  is($date.tonalpohualli-name     , 'Movement');
  is($date.tonalpohualli          , '2 Movement');
  is($date.xiuhpohualli-name      , '1-lords feast');
  is($date.xiuhpohualli           , '19 1-lords feast');
  is($date.strftime("%A %B %G %Y"), "Movement 1-lords feast 8 Flint 8 Flint");
}

sub testing-French($date) {
  is($date.locale                 , 'fr');
  is($date.month-name             , 'Petite fête des dignitaires');
  is($date.day-name               , 'Mouvement');
  is($date.tonalpohualli-name     , 'Mouvement');
  is($date.tonalpohualli          , '2 Mouvement');
  is($date.xiuhpohualli-name      , 'Petite fête des dignitaires');
  is($date.xiuhpohualli           , '19 Petite fête des dignitaires');
  is($date.strftime("%A %B %G %Y"), "Mouvement Petite fête des dignitaires 8 Silex 8 Silex");
}
