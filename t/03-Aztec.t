use v6.c;
use Test;
use Date::Calendar::Aztec;

# Checking 2020-03-11 with the Caso correlation
# see https://www.azteccalendar.com/?day=11&month=3&year=2020

plan 1  # date
     × ( 5     # locale-independant methods
        + 3 × 3)    # locales and locale-dependant methods
 	
;

my Date::Calendar::Aztec $date .= new(month           =>  8
                                    , day             => 19
                                    , clerical-number =>  2
                                    , clerical-index  => 17
                                    , locale          => 'nah');

testing-calendar-round;
testing-Nahuatl;
$date.locale = 'en';
testing-English;
$date.locale = 'fr';
testing-French;

done-testing;

sub testing-calendar-round {
  is($date.month          ,  8);
  is($date.day            , 19);
  is($date.clerical-number,  2);
  is($date.clerical-index , 17);
  is($date.gist           , '19-8 2-17');
  # is($date.tonalpohualli-number,  2);
  # is($date.xiuhpohualli-number , 19
}

sub testing-Nahuatl {
  is($date.locale         , 'nah');
  is($date.month-name     , 'Tecuilhuitontli');
  is($date.day-name       , 'Ollin');
  # is($date.tonalpohualli-name  , 'Ollin');
  # is($date.tonalpohualli       , '2 Ollin');
  # is($date.xiuhpohualli-name   , 'Tecuilhuitontli');
  # is($date.xiuhpohualli        , '19 Tecuilhuitontli');
}

sub testing-English {
  is($date.locale         , 'en');
  is($date.month-name     , '1-lords feast');
  is($date.day-name       , 'Movement');
  # is($date.tonalpohualli-name  , 'Movement');
  # is($date.tonalpohualli       , '2 Movement');
  # is($date.xiuhpohualli-name   , '1-lords feast');
  # is($date.xiuhpohualli        , '19 1-lords feast');
}

sub testing-French {
  is($date.locale         , 'fr');
  is($date.month-name     , 'Petite fête des dignitaires');
  is($date.day-name       , 'Mouvement');
  # is($date.tonalpohualli-name  , 'Mouvement');
  # is($date.tonalpohualli       , '2 Mouvement');
  # is($date.xiuhpohualli-name   , 'Petite fête des dignitaires');
  # is($date.xiuhpohualli        , '19 Petite fête des dignitaires');
}
