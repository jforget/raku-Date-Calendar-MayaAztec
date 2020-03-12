use v6.c;
use Test;
use Date::Calendar::Aztec;

plan 6;

my Date::Calendar::Aztec $date .= new(month           =>  8
                                    , day             => 19
                                    , clerical-number =>  2
                                    , clerical-index  =>  7
                                    , locale          => 'nah');

is($date.month          ,  8);
is($date.day            , 19);
is($date.clerical-number,  2);
is($date.clerical-index ,  7);
is($date.locale         , 'nah');
# is($date.tonalpohualli-number,  7);
# is($date.tonalpohualli-name  , 'Ollin');
# is($date.tonalpohualli       , '7 Ollin');
# is($date.xiuhpohualli-number , 19
# is($date.xiuhpohualli-name   , 'Tecuilhuitontli');
# is($date.xiuhpohualli        , '19 Tecuilhuitontli');

$date.locale = 'en';
is($date.locale         , 'en');
# is($date.tonalpohualli-number,  7);
# is($date.tonalpohualli-name  , 'Movement');
# is($date.tonalpohualli       , '7 Movement');
# is($date.xiuhpohualli-number , 19
# is($date.xiuhpohualli-name   , '1-lords feast');
# is($date.xiuhpohualli        , '19 1-lords feast');

done-testing;
