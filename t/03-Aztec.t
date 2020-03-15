use v6.c;
use Test;
use Date::Calendar::Aztec;

plan 11;

my Date::Calendar::Aztec $date .= new(month           =>  8
                                    , day             => 19
                                    , clerical-number =>  2
                                    , clerical-index  => 17
                                    , locale          => 'nah');

# Checking 2020-03-11 with the Caso correlation
# see https://www.azteccalendar.com/?day=11&month=3&year=2020

is($date.month          ,  8);
is($date.day            , 19);
is($date.clerical-number,  2);
is($date.clerical-index , 17);
is($date.locale         , 'nah');
is($date.gist           , '19-8 2-17');
is($date.month-name     , 'Tecuilhuitontli');
is($date.day-name       , 'Ollin');
# is($date.tonalpohualli-number,  2);
# is($date.tonalpohualli-name  , 'Ollin');
# is($date.tonalpohualli       , '2 Ollin');
# is($date.xiuhpohualli-number , 19
# is($date.xiuhpohualli-name   , 'Tecuilhuitontli');
# is($date.xiuhpohualli        , '19 Tecuilhuitontli');

$date.locale = 'en';
is($date.locale         , 'en');
is($date.month-name     , '1-lords feast');
is($date.day-name       , 'Movement');
# is($date.tonalpohualli-number,  2);
# is($date.tonalpohualli-name  , 'Movement');
# is($date.tonalpohualli       , '2 Movement');
# is($date.xiuhpohualli-number , 19
# is($date.xiuhpohualli-name   , '1-lords feast');
# is($date.xiuhpohualli        , '19 1-lords feast');

done-testing;
