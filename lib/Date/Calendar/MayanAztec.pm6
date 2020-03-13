use v6.c;
unit role Date::Calendar::MayanAztec:ver<0.0.1>:auth<cpan:JFORGET>;

has Int $.day             where { 0 ≤ $_ ≤ 20 }; # Haab number (0 to 19) or xiuhpohualli number (1 to 20)
has Int $.month           where { 1 ≤ $_ ≤ 19 }; # Number equivalent of Haab name or xiuhpohualli name
has Int $.clerical-number where { 1 ≤ $_ ≤ 13 }; # Tzolkin number or tonalpohualli number
has Int $.clerical-index  where { 1 ≤ $_ ≤ 20 }; # Number equivalent of the Tzolkin name or tonalpohualli name
has Str $.locale is rw;


method !build-calendar-round(Int $month, Int $day, Int $clerical-index, Int $clerical-number, Str $locale) {
  $!month           = $month;
  $!day             = $day;
  $!clerical-index  = $clerical-index;
  $!clerical-number = $clerical-number;
  $!locale          = $locale;
}

=begin pod

=head1 NAME

Date::Calendar::MayanAztec - conversions from/to the Mayan calendar and conversions to the Aztec calendar

=head1 SYNOPSIS

=begin code :lang<perl6>

use Date::Calendar::Mayan;
use Date::Calendar::Aztec;
my Date                  $d-greg  .= new(2020, 6, 20);
my Date::Calendar::Aztec $d-aztec .= new-from-date($d-greg);
my Date::Calendar::Mayan $d-mayan .= new-from-date($d-greg);

say "{.tzolkin} {.haab"} {.long-count}" with $d-mayan;
# --> 12 Etznab 1 Tzec 13.0.7.10.18
$d-mayan.locale = 'en';
say "{.tzolkin} {.haab"}" with $d-mayan;
# --> 12 Flint 1 Skull

say "{.tonalpohualli} {.xiuhpohualli}" with $d-aztec;
# --> 12 Tecpatl 20 Teotleco
$d-aztec.locale = 'en';
say "{.tonalpohualli} {.xiuhpohualli}" with $d-aztec;
# --> 12 Flint 20 God arrives

=end code

=head1 DESCRIPTION

Date::Calendar::MayanAztec is  a distribution  with two  main classes,
Date::Calendar::Mayan  implementing the  Mayan calendars  (long count,
Haab  and Tzolkin)  and Date::Calendar::Aztec  implementing the  Aztec
calendars (tonalpohualli and xiuhpohualli).

=head1 SEE ALSO

=head2 Raku Software

L<Date::Calendar::Strftime>
or L<https://github.com/jforget/raku-Date-Calendar-Strftime>

L<Date::Calendar::Julian>
or L<https://github.com/jforget/raku-Date-Calendar-Julian>

L<Date::Calendar::Hebrew>
or L<https://github.com/jforget/raku-Date-Calendar-Hebrew>

L<Date::Calendar::CopticEthiopic>
or L<https://github.com/jforget/raku-Date-Calendar-CopticEthiopic>

L<Date::Calendar::FrenchRevolutionary>
or L<https://github.com/jforget/raku-Date-Calendar-FrenchRevolutionary>

=head2 Perl 5 Software

L<Date::Maya>

L<DateTime::Calendar::Mayan>

=head2 Other Software

F<calendar/cal-mayan.el>  in Emacs

CALENDRICA 4.0 -- Common Lisp, which can be download in the "Resources" section of
L<https://www.cambridge.org/us/academic/subjects/computer-science/computing-general-interest/calendrical-calculations-ultimate-edition-4th-edition?format=PB&isbn=9781107683167>

=head2 Books

Calendrical Calculations (Third or Fourth Edition) by Nachum Dershowitz and
Edward M. Reingold, Cambridge University Press, see
L<http://www.calendarists.com>
or L<https://www.cambridge.org/us/academic/subjects/computer-science/computing-general-interest/calendrical-calculations-ultimate-edition-4th-edition?format=PB&isbn=9781107683167>.
ISBN 978-0-521-70238-6 for the third edition.

I<La saga des calendriers>, by Jean Lefort, published by I<Belin> (I<Pour la Science>), ISBN 2-90929-003-5
See L<https://www.belin-editeur.com/la-saga-des-calendriers>

I<Histoire comparée des numérations écrites> by Geneviève Guitel, published by I<Flammarion> (I<Nouvelle bibliothèque scientifique>), ISBN 2-08-21114-0

=head2 Internet

L<https://en.wikipedia.org/wiki/Aztec_calendar>

L<https://en.wikipedia.org/wiki/Maya_calendar>

L<https://www.tondering.dk/claus/cal/maya.php>

L<https://www.britannica.com/topic/Aztec-calendar>

L<https://www.timeanddate.com/calendar/mayan.html>

L<https://www.azteccalendar.com/>

L<http://research.famsi.org/date_mayaLC.php>

=head1 AUTHOR

Jean Forget <JFORGET@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright © 2020 Jean Forget

This library is  free software; you can redistribute  it and/or modify
it under the Artistic License 2.0.

=end pod
