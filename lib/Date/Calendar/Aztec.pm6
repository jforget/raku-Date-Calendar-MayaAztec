use v6.c;

use Date::Calendar::Strftime;
use Date::Calendar::MayanAztec;
use Date::Calendar::Aztec::Common;

unit class Date::Calendar::Aztec:ver<0.0.1>:auth<cpan:JFORGET>
      does Date::Calendar::MayanAztec
      does Date::Calendar::Aztec::Common
      does Date::Calendar::Strftime;

# Julian day of the epoch.
# Since tonalpohualli-Caso is synchronised with Tzolkin-GMT, I have used the same value.
method epoch {
  584283;
}

=begin pod

=head1 NAME

Date::Calendar::Aztec - conversions to the Aztec calendar

=head1 SYNOPSIS

=begin code :lang<perl6>

use Date::Calendar::Aztec;
my Date                  $d-greg  .= new(2020, 6, 20);
my Date::Calendar::Aztec $d-aztec .= new-from-date($d-greg);

say "{.tonalpohualli} {.xiuhpohualli}" with $d-aztec;
# --> 12 Tecpatl 20 Teotleco
$d-aztec.locale = 'en';
say "{.tonalpohualli} {.xiuhpohualli}" with $d-aztec;
# --> 12 Flint 20 God arrives

=end code

=head1 DESCRIPTION

Date::Calendar::Aztec is  a class that implements  the Aztec calendars
(tonalpohualli and xiuhpohualli).

This class uses  the Alfonso Caso correlation. Another  class uses the
Francisco Cortes correlation, see L<Date::Calendar::Aztec::Cortes>.

Aztecs   used  two   different  calendars,   the  civil   calendar  or
"xiuhpohualli" and the clerical calendar or "tonalpohualli".

The  civil  calendar is  organized  like  other calendars,  with  days
grouped  in  months  groupes  in  years.  The  difference  with  other
calendars is  that the months lasts  20 days each, not  around 30, and
there are 18 months, not 12.  In addition, there are 5 additional days
(Nemontemi), but no leap days are defined.

A last difference with other calendars is that years are not numbered.

The clerical calendar  consists of two simultaneous  cycles, the first
one with numbers 1  to 13, the second one with 20  names. This gives a
clerical year of 260 days.

=head1 METHODS

=head2 Object Creation

=head3 new

The C<new> method can be called  either with plain English keywords or
with  Nahuatl  keywords.  Here  is  the  equivalence  between  English
parameters and Nahuatl parameters.

  month            xiuhpohualli-index  
  day              xiuhpohualli-number 
  clerical-index   tonalpohualli-index 
  clerical-number  tonalpohualli-number

In  addition, you  can provide  the optional  parameter C<locale>.  By
default, it will be C<'nah'> for Nahuatl.

=head3 new-from-date

Build an  Aztec date  by cloning  an object  from another  class. This
other   class    can   be    the   core    class   C<Date>    or   any
C<Date::Calendar::>R<xxx> class with a C<daycount> method.

=head3 new-from-daycount

Build an Aztec date from the Modified Julian Day number.

=head2 Attribute getters

=head3 month

The numeric equivalent of the xiuhpohualli name.

=head3 month-name, xiuhpohualli-name

The name part of the  civil calendar (xiuhpohualli). Its value depends
on the value of the C<locale> attribute.

=head3 day

The numeric part of the civil calendar (xiuhpohualli), 1 to 20.

=head3 xiuhpohualli

A  string merging  the numeric  part and  the name  part of  the civil
calendar  (xiuhpohualli).  Its  value  depends on  the  value  of  the
C<locale> attribute.

=head3 clerical-number, tonalpohualli-number

The numeric part of the clerical calendar (tonalpohualli).

=head3 clerical-name, tonalpohualli-name

The  name part  of the  clerical calendar  (tonalpohualli). Its  value
depends on the value of the C<locale> attribute.

=head3 clerical-index, tonalpohualli-index

The  numeric equivalent  of the  name  part of  the clerical  calendar
(tonalpohualli), 1 to 20.

=head3 tonalpohualli

A string  merging the numeric part  and the name part  of the clerical
calendar  (tonalpohualli).  Its value  depends  on  the value  of  the
C<locale> attribute.

=head3 gist

Print the numeric values for the civil and clerical calendar.

=head1 ISSUES

The  Aztecs had  nothing  like the  Mayas' long  count  or like  other
calendars'  year numbers.  By combining  the civil  calendar with  the
clerical calendar, we  get different combinations for  about 52 years.
This period  is called the  "calendar round".  So when given  an Aztec
date with the four values (tonalpohualli number and name, xiuhpohualli
number and name), you cannot define a unique Gregorian date equivalent
to this Aztec date. The Gregorian date 52 years later (or 104, or 156)
and the Gregorian  52 years earlier (or 104 or...)  also correspond to
this Aztec date.

For this reason, there is no method to convert from the Aztec calendar
into another calendar.

Another  issue it  the month  between Izcalli  and Tlacaxipehualiztli.
Most   sources  gives   the   name  "Atlcahualo",   but  the   website
L<https://www.azteccalendar.com> gives the name "Cuauhuitlehua".

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

=head2 Other Software

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

L<https://www.britannica.com/topic/Aztec-calendar>

L<https://www.azteccalendar.com/>

L<http://research.famsi.org/date_mayaLC.php>

=head1 AUTHOR

Jean Forget <JFORGET@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright © 2020 Jean Forget

This library is  free software; you can redistribute  it and/or modify
it under the Artistic License 2.0.

=end pod
