use v6.c;

use Date::Calendar::Strftime;
use Date::Calendar::MayaAztec;
use Date::Calendar::Maya::Common;

unit class Date::Calendar::Maya:ver<0.0.1>:auth<cpan:JFORGET>
      does Date::Calendar::MayaAztec
      does Date::Calendar::Maya::Common
      does Date::Calendar::Strftime;

# Goodman-Martinez-Thompson correlation: day 0.0.0.0.0 is 11 August -3113 (or 3114 BC)
method epoch {
  584283;
}

=begin pod

=head1 NAME

Date::Calendar::Maya - conversions from/to the Maya calendar

=head1 SYNOPSIS

=begin code :lang<perl6>

use Date::Calendar::Maya;
my Date                 $d-greg .= new(2020, 6, 20);
my Date::Calendar::Maya $d-maya .= new-from-date($d-greg);

say "{.tzolkin} {.haab} {.long-count}" with $d-maya;
# --> 12 Etznab 1 Tzec 13.0.7.10.18
$d-maya.locale = 'en';
say "{.tzolkin} {.haab}" with $d-maya;
# --> 12 Flint 1 Skull

=end code

=head1 DESCRIPTION

Date::Calendar::Maya is  a class  which implements the  Maya calendars
(long count, Haab and Tzolkin).

This  class  uses  the  Goodman-Martinez-Thompson  correlation.  Other
classes use the Spinden correlation or what is named "Astronomical" on
the website L<http://research.famsi.org/date_mayaLC.php>.

Mayas  used  three different  calendars,  the  Long Count,  the  civil
calendar or "Haab" and the clerical calendar or "Tzolkin".

The  civil  calendar is  organized  like  other calendars,  with  days
grouped  in  months  grouped  in  years.  The  difference  with  other
calendars is  that the months  last 20 days  each, not around  30, and
there are 18 months,  not 12. Days are numbered 0 to 19,  not 1 to 20.
In theory  months are not numbered,  but in this module  they are, for
convenience reasons. In addition, there are 5 additional days (uayeb),
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
instead of 365.24.

=head1 METHODS

=head2 Object Creation

=head3 new

Build a  Maya date by giving  a string containing the  long count. The
method accepts two keyword parameters:

=item C<long-count>  a string built  of 5 numbers in  dotted notation.
These numbers  are the  components of the  long count,  baktun, katun,
tun, uinal and kin.  Each one is in the 0..19  range, except the uinal
component which is in the 0..17 range.

=item C<locale>  a string giving the  language in which the  names are
displayed.  For the  moment,  you  can use  C<'yua'>  for the  Yucatec
language,  C<'en'> for  the  English language  and  C<'fr'> a  partial
support of the French language.

=head3 new-from-date

Build an Maya date by cloning an object from another class. This other
class can be  the core class C<Date>  or any C<Date::Calendar::>R<xxx>
class with a C<daycount> method.

=head3 new-from-daycount

Build an Maya date from the Modified Julian Day number.

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

=head3 year-bearer-number, year-bearer-index, year-bearer-name, year-bearer

The year bearer is  the Tzolkin date for the first  day of the current
Haab year, that  is, 0 Pop. The  year bearer is some kind  of name for
the Haab year, which is unnumbered. Yet it cannot define unambiguously
the year, since it cycles every 52 Haab years (a calendar round).

These four methods define the year  bearer. Their names are similar to
the C<clerical->R<xxx> and the  C<tzolkin->R<xxx> methods, because the
year bearer is a Tzolkin date.


=head3 gist, long-count

The long count in dotted notation.

=head3 daycount

The MJD (Modified Julian Date) number for the date.

=head2 Other Methods

=head3 to-date

Clones  the   date  into   a  core  class   C<Date>  object   or  some
C<Date::Calendar::>R<xxx> compatible calendar  class. The target class
name is given  as a positional parameter. This  parameter is optional,
the default value is C<"Date"> for the Gregorian calendar.

To convert a date from a  calendar to another, you have two conversion
styles,  a "push"  conversion and  a "pull"  conversion. For  example,
while converting  "13.0.7.6.11" to the French  Revolutionary calendar,
you can code:

=begin code :lang<perl6>

use Date::Calendar::Maya;
use Date::Calendar::FrenchRevolutionary;

my  Date::Calendar::Maya                $d-orig;
my  Date::Calendar::FrenchRevolutionary $d-dest-push;
my  Date::Calendar::FrenchRevolutionary $d-dest-pull;

$d-orig .= new(long-count => '13.0.7.6.11');
$d-dest-push  = $d-orig.to-date("Date::Calendar::FrenchRevolutionary");
$d-dest-pull .= new-from-date($d-orig);

=end code

When converting I<from> Gregorian, use the pull style. When converting
I<to> Gregorian, use the push style. When converting from any calendar
other than Gregorian  to any other calendar other  than Gregorian, use
the style you prefer.

Even  if both  calendars use  a C<locale>  attribute, when  a date  is
created by  the conversion  of another  date, it  is created  with the
default  locale. If  you  want the  locale to  be  transmitted in  the
conversion, you should add this line:

=begin code :lang<perl6>

$d-dest-pull.locale = $d-orig.locale;

=end code


=head1 ISSUES

=head2 Mayan or Maya?

According to L<http://www.famsi.org/research/vanstone/2012/faq.html#mayan>,
the word  "Mayan" applies only to  the class of languages  used by the
Mayas. In all other cases, including  the calendars, we should use the
word "Maya".

=head2 Day Definition

This class  assumes that days  are midnight to midnight.  According to
Reingold and  Dershowitz, we suppose  that actually the Haab  days are
sunrise to sunrise and that the Tzolkin days are sunset to sunset. But
this is only a supposition.

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

=head2 Calendar Rollover

As a  consequence of the  previous paragraph, the calendar  rolls over
every 20 baktuns, that is, every 7885 years. The next rollover date is
4772-10-12. So there is time before a fix is needed.

=head2 French Translation

I have  found the French  translation for  Tzolkin names, but  not for
Haab names.  So while using  the French  locale, Haab names  are given
with the default locale, Yucatec.

=head2 Year Bearer For Additional Days

According to Reingold  and Dershowitz, the year bearer  is not defined
for  additional  days   (uayeb).  On  the  other   hand,  the  website
L<http://research.famsi.org/date_mayaLC.php> displays  the year bearer
for additional  days. I have  taken the programmer-friendly  option of
computing the year bearer for additional days as for the normal days.

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
