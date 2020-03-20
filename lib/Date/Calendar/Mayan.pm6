use v6.c;

use Date::Calendar::Strftime;
use Date::Calendar::MayanAztec;
use Date::Calendar::Mayan::Common;

unit class Date::Calendar::Mayan:ver<0.0.1>:auth<cpan:JFORGET>
      does Date::Calendar::MayanAztec
      does Date::Calendar::Mayan::Common
      does Date::Calendar::Strftime;

# Goodman-Martinez-Thompson correlation: day 0.0.0.0.0 is 11 August -3113 (or 3114 BC)
method epoch {
  584283;
}

=begin pod

=head1 NAME

Date::Calendar::Mayan - conversions from/to the Mayan calendar

=head1 SYNOPSIS

=begin code :lang<perl6>

use Date::Calendar::Mayan;
my Date                  $d-greg  .= new(2020, 6, 20);
my Date::Calendar::Mayan $d-mayan .= new-from-date($d-greg);

say "{.tzolkin} {.haab} {.long-count}" with $d-mayan;
# --> 12 Etznab 1 Tzec 13.0.7.10.18
$d-mayan.locale = 'en';
say "{.tzolkin} {.haab}" with $d-mayan;
# --> 12 Flint 1 Skull

=end code

=head1 DESCRIPTION

Date::Calendar::Mayan is a class  which implements the Mayan calendars
(long count, Haab and Tzolkin).

This  class  uses  the  Goodman-Martinez-Thompson  correlation.  Other
classes uses the  Spinden correlation or what  is named "Astronomical"
on the website L<http://research.famsi.org/date_mayaLC.php>.

Mayas  used  three different  calendars,  the  Long Count,  the  civil
calendar or "Haab" and the clerical calendar or "Tzolkin".

The  civil  calendar is  organized  like  other calendars,  with  days
grouped  in  months  groupes  in  years.  The  difference  with  other
calendars is  that the months lasts  20 days each, not  around 30, and
there are 18 months,  not 12. Days are numbered 0 to 19,  not 1 to 20.
In theory  months are not numbered,  but in this module  they are, for
convenience reasons. In addition, there are 5 additional days (uyaeb),
but no leap days are defined.

A last difference with other calendars is that years are not numbered.

The clerical calendar  consists of two simultaneous  cycles, the first
one with numbers 1  to 13, the second one with 20  names. This gives a
clerical year of 260 days. As for the civil calendar, the 20 names are
numbered for convenience reasons.

The long count consists of five embedded cycles:

=item kin or day
=item uinal, 1 uinal = 20 days
=item tun, 1 tun = 18 uinals
=item katun, 1 katun = 20 tuns
=item baktun, 1 baktun = 20 katuns

The uinal can  be considered as a  month, its duration is  the same as
the Haab month. The  tun is a bit shorter than a  solar year, 360 days
instead of 36.24.

=head1 METHODS

=head2 Object Creation

=head3 new


=head3 new-from-date

Build an  Mayan date  by cloning  an object  from another  class. This
other   class    can   be    the   core    class   C<Date>    or   any
C<Date::Calendar::>R<xxx> class with a C<daycount> method.

=head3 new-from-daycount

Build an Mayan date from the Modified Julian Day number.

=head2 Attribute getters

=head3 month

The numeric equivalent of the Haab name.

=head3 month-name, Haab-name

The name part  of the civil calendar (Haab). Its  value depends on the
value of the C<locale> attribute.

=head3 day

The numeric part of the civil calendar (Haab), 0 to 19.

=head3 Haab

A  string merging  the numeric  part and  the name  part of  the civil
calendar  (Haab). Its  value depends  on  the value  of the  C<locale>
attribute.

=head3 clerical-number, tzolkin-number

The numeric part of the clerical calendar (Tzolkin).

=head3 clerical-name, tzolkin-name

The name part of the clerical calendar (Tzolkin). Its value depends on
the value of the C<locale> attribute.

=head3 clerical-index, tzolkin-index

The  numeric equivalent  of the  name  part of  the clerical  calendar
(Tzolkin), 1 to 20.

=head3 tzolkin

A string  merging the numeric part  and the name part  of the clerical
calendar (Tzolkin).  Its value depends  on the value of  the C<locale>
attribute.

=head3 gist, long-count

The long count in dotted notation.

=head1 ISSUES

=head2 Baktun Numbering

The long count uses base-20 numbering, with the exception of the uinal
number, which uses  the 0..17 range instead of 0..19.  But some people
think that  there is another  exception with the baktun  number, which
uses a cycle  ending with number 13. See  L<Claus Tøndering's Calendar
FAQ|https://www.tondering.dk/claus/cal/maya.php#baktun>.

The belief that baktun 13 is a special one may come from the fact that
for end-of-the-worldists  in the  late XXth century  and in  the early
XXIst  century, the  switch from  12 to  13 would  occur during  their
lifetimes. Other  considerations point at the  special significance of
number  13  in  the  Maya  civilization.  Actually,  as  described  in
Wikipedia   (L<https://en.wikipedia.org/wiki/Maya_calendar#Long_Count>
and L<https://en.wikipedia.org/wiki/Mesoamerican_Long_Count_calendar#2012_and_the_Long_Count>)
archeologists have found carved long count dates beyond the 13.0.0.0.0
date, which means that in the mind  of the carver, the world would not
end at 13.0.0.0.0.

This module  assumes that  baktun 13 has  no special  significance and
that baktuns are  numbered until 19. The  higher-order cycles, piktun,
calabtun, kinchiltun and alautun are not implemented.

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

L<https://en.wikipedia.org/wiki/Maya_calendar>

L<https://www.tondering.dk/claus/cal/maya.php>

L<https://www.timeanddate.com/calendar/mayan.html>

L<http://research.famsi.org/date_mayaLC.php>

=head1 AUTHOR

Jean Forget <JFORGET@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright © 2020 Jean Forget

This library is  free software; you can redistribute  it and/or modify
it under the Artistic License 2.0.

=end pod
