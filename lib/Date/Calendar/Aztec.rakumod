use v6.d;

use Date::Calendar::Strftime;
use Date::Calendar::MayaAztec;
use Date::Calendar::Aztec::Common;

unit class Date::Calendar::Aztec:ver<0.1.0>:auth<zef:jforget>:api<1>
      does Date::Calendar::MayaAztec
      does Date::Calendar::Aztec::Common
      does Date::Calendar::Strftime;

# Julian day of the epoch.
# Since tonalpohualli-Caso is synchronised with Tzolkin-GMT, I have used the same value.
method epoch {
  584283;
}

=begin pod

=head1 NAME

Date::Calendar::Aztec - conversions from / to the Aztec calendar

=head1 SYNOPSIS

=begin code :lang<raku>

use Date::Calendar::Aztec;
my Date                  $d-greg  .= new(2020, 6, 20);
my Date::Calendar::Aztec $d-aztec .= new-from-date($d-greg);

say "{.tonalpohualli} {.xiuhpohualli}" with $d-aztec;
# --> 12 Tecpatl 20 Teotleco
$d-aztec.locale = 'en';
say "{.tonalpohualli} {.xiuhpohualli}" with $d-aztec;
# --> 12 Flint 20 God arrives

=end code

And in the other direction

=begin code :lang<raku>

use Date::Calendar::Aztec;
my Date $reference  .= new(2020, 1, 1);
my Date::Calendar::Aztec
        $d-aztec .= new(month           => 13
                     ,  day             => 20
                     ,  clerical-index  => 18
                     ,  clerical-number => 12
                     ,  on-or-after     => $reference);
my Date $d-greg = $d-aztec.to-date('Date');
say $d-greg;
# --> 2020-06-20

=end code


=head1 DESCRIPTION

Date::Calendar::Aztec is  a class that implements  the Aztec calendars
(tonalpohualli and xiuhpohualli).

This class uses  the Alfonso Caso correlation. Another  class uses the
Francisco Cortes correlation, see L<Date::Calendar::Aztec::Cortes>.

Aztecs   used  two   different  calendars,   the  civil   calendar  or
"xiuhpohualli" and the clerical calendar or "tonalpohualli".

The  civil  calendar is  organized  like  other calendars,  with  days
grouped  in  months  grouped  in  years.  The  difference  with  other
calendars is  that the months  last 20 days  each, not around  30, and
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

You should add  a reference date (from the core  C<Date> class or from
any  C<Class::Calendar::>R<xxx>  class),  tagged with  a  relationship
C<before>,  C<on-or-before>, C<after>,  C<on-or-after> or  C<nearest>.
The  reason why  is explained  in the  B<Issues> chapter,  B<Rollover>
subchapter below. By default, the c<new> method will use:

=begin code :lang<raku>

  nearest => Date.today,

=end code

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

For C<strftime>, use the C<%m> specifier.

=head3 month-name, xiuhpohualli-name

The name part of the  civil calendar (xiuhpohualli). Its value depends
on the value of the C<locale> attribute.

For C<strftime>, use the C<%B> specifier.

=head3 day

The numeric part of the civil calendar (xiuhpohualli), 1 to 20.

For C<strftime>, use the C<%d> or C<%e> specifier.

=head3 xiuhpohualli

A  string merging  the numeric  part and  the name  part of  the civil
calendar  (xiuhpohualli).  Its  value  depends on  the  value  of  the
C<locale> attribute.

No single C<strftime> specifier, you have to mix C<%B> with C<%d>.

=head3 clerical-number, tonalpohualli-number

The numeric part of the clerical calendar (tonalpohualli).

For C<strftime>, use the C<%V> specifier.

=head3 clerical-name, tonalpohualli-name

The  name part  of the  clerical calendar  (tonalpohualli). Its  value
depends on the value of the C<locale> attribute.

For C<strftime>, use the C<%A> specifier.

=head3 clerical-index, tonalpohualli-index

The  numeric equivalent  of the  name  part of  the clerical  calendar
(tonalpohualli), 1 to 20.

For C<strftime>, use the C<%u> specifier.

=head3 tonalpohualli

A string  merging the numeric part  and the name part  of the clerical
calendar  (tonalpohualli).  Its value  depends  on  the value  of  the
C<locale> attribute.

No single C<strftime>  specifier, you have to mix C<%V>  with C<%u>.

=head3 year-bearer-number, year-bearer-index, year-bearer-name, year-bearer

The year bearer  is a tonalpohualli date which is  shared by all dates
from a given "1  Tititl" to the next "5 Nemontemi"  364 days later. So
we may  consider that it sort  of names the xiuhpohualli  year. Yet it
cannot  define  unambiguously  the  year, since  it  cycles  every  52
xiuhpohualli years (a calendar round).

These four methods define the year  bearer. Their names are similar to
the  C<clerical->R<xxx>   and  the   C<tonalpohualli->R<xxx>  methods,
because the year bearer is a tonalpohualli date.

For C<strftime>,  use the C<%Y> of  C<%G> specifier to print  the year
bearer (number and name).

=head3 gist

Print the numeric values for the civil and clerical calendar.

=head3 locale

The  abbreviation  of the  language  used  for names.  Actually,  this
attribute is  read-write. You can  create a  date object with  a first
locale and then change it to another locale.

For the moment,  the allowed values are C<'nah'>  for Nahuatl, C<'en'>
for English and C<'fr'> for French.

=head3 strftime

This method gives a string containing several attributes listed above.
It is similar  to the homonymous function in other  languages. See the
L<strftime Specifiers> paragraph below.

=head2 Other Methods

=head3 to-date

Clones  the   date  into   a  core  class   C<Date>  object   or  some
C<Date::Calendar::>R<xxx> compatible calendar  class. The target class
name is given  as a positional parameter. This  parameter is optional,
the default value is C<"Date"> for the Gregorian calendar.

To convert a date from a  calendar to another, you have two conversion
styles,  a "push"  conversion and  a "pull"  conversion. For  example,
while converting  "11 Calli 5  Quecholli" to the  French Revolutionary
calendar, you can code:

=begin code :lang<raku>

use Date::Calendar::Aztec;
use Date::Calendar::FrenchRevolutionary;

my  Date::Calendar::Aztec               $d-orig;
my  Date::Calendar::FrenchRevolutionary $d-dest-push;
my  Date::Calendar::FrenchRevolutionary $d-dest-pull;

$d-orig .= new(month => 15, day => 5, clerical-number => 11, clerical-index => 3);
$d-dest-push  = $d-orig.to-date("Date::Calendar::FrenchRevolutionary");
$d-dest-pull .= new-from-date($d-orig);

=end code

When converting  I<from> the core  class C<Date>, use the  pull style.
When converting I<to> the core class C<Date>, use the push style. When
converting from any class other than  C<Date> to any other class other
than   C<Date>,   use   the    style   you   prefer.   This   includes
C<Date::Calendar::Gregorian>, a child class to the core class C<Date>.

Even  if both  calendars use  a C<locale>  attribute, when  a date  is
created by  the conversion  of another  date, it  is created  with the
default  locale. If  you  want the  locale to  be  transmitted in  the
conversion, you should add this line:

=begin code :lang<raku>

$d-dest-pull.locale = $d-orig.locale;

=end code

=head2 strftime Specifiers

=head3 Designer's Notes

The Aztec  calendar is  not like the  others, based  on year-month-day
triplets. So defining which data  will be printed by which C<strftime>
specifier  is not  obvious.  Let us  see  what can  be  done with  the
principle of least surprise.

At least,  the common  calendar (xiuhpohualli)  is based  on month-day
pairs. And the  months have an unambiguous  numeric representation. So
we can  easily define  what will  be printed  by C<%B>,  C<%d>, C<%e>,
C<%f> and  C<%m>. The  tonalpohualli names (Cipactli,  Ehecatl...) run
through a cycle, just as the  week days (Monday, Tuesday...), so it is
natural  to assimilate  both notions,  even if  the cycle  lengths are
different: 20 in  the first case, 7 in the  latter case. So specifiers
C<%A> and C<%u> are cared for.

That is  all for the  obvious equivalences.  Now, we can  define other
specifiers by shoe-horning a Gregorian  concept into them. For example
the C<%V> specifier.  It represents the week number  for the Gregorian
calendar, or how many 7-day cycles have elapsed since the beginning of
the year.  This is not interesting  for the Aztec calendar,  because a
tonalpohualli  20-name cycle  coincidates with  a xiuhpohualli  20-day
month.  Another way  to describe  the C<%V>  specifier is  "the number
which  is  usually  printed  associated  to C<%u>  (in  the  ISO  date
format)".  Since C<%u>  gives the  numeric form  of the  tonalpohualli
name, C<%V> should give the tonalpohualli number.

What about the  year numbers C<%Y> and C<%G>? The  C<%Y> specifier can
be described  as "the specifier  which keeps  the same value  from 1st
January to 31st  December". In the Aztec calendar,  which notion keeps
the  same value  from 1  Izcalli until  5 Nemontemi?  The year  bearer
which, therefore,  can uniquely identify  a year, within  some limits.
More precisely, within a calendar round (52 years), the year bearer is
a unique identifier for the xiuhpohualli year. So the C<%Y> specifier will
print the  year bearer. On the  other hand, identifying the  year with
its year bearer  is flawed with a rollover problem  similar to the Y2K
bug, except that it occurs every  52 years instead of every 100 years.
So  it may  be better  to  associate the  year bearer  with the  C<%y>
specifier, which  can be defined  as the "Y2K-flawed  year specifier".
For the Gregorian calendar, the C<%G> specifier prints the year number
for the week-based "ISO" date. There  is no week-related "ISO" date in
the Aztec calendar, so C<%G> will print the same as C<%Y>.

And the C<%F> specifier? For the  Maya calendar, I have decided to use
it to  print the long count.  But the Aztec calendar  has nothing like
the Maya  long count.  So the  C<%F> specifier will  not print  a date
value, it will be printed without change in the output string.

=head3 Specifiers

=defn C<%A>

The tonalpohualli name, similar to the name of the day of week.

=defn C<%B>

The xiuhpohualli name, similar to a month name.

=defn C<%d>

The xiuhpohualli number, which can be  seen as the numeric form of the
day of the month (range 01 to 20).

=defn C<%e>

Like C<%d>, the  xiuhpohualli number or day of the  month as a decimal
number, but a leading zero is replaced by a space.

=defn C<%f>

The  numeric form  of the  xiuhpohualli name,  or month  as a  decimal
number (1 to 19). Unlike C<%m>, a leading zero is replaced by a space.

=defn C<%G>

The year bearer.

=defn C<%j>

The day of the year as a decimal number (range 001 to 365).

=defn C<%m>

The  numeric  form of  the  xiuhpohualli  name,  or  the month,  as  a
two-digit decimal number (range 01 to 19), including a leading zero if
necessary.

=defn C<%n>

A newline character.

=defn C<%t>

A tab character.

=defn C<%u>

The tonalpohualli index,  that is the 1..20 numeric  equivalent of the
tonalpohualli name.

=defn C<%V>

The tonalpohualli number.

=defn C<%Y>

The year bearer.

=defn C<%%>

A literal `%' character.

=head3 Modifiers

A complete C<strftime> specifier consists of:

=item A percent sign,

=item An  optional minus sign, to  indicate on which side  the padding
occurs. If the minus sign is present, the value is aligned to the left
and the padding spaces are added to the right. If it is not there, the
value is aligned to the right and the padding chars (spaces or zeroes)
are added to the left.

=item  An  optional  zero  digit,  to  choose  the  padding  char  for
right-aligned values.  If the  zero char is  present, padding  is done
with zeroes. Else, it is done wih spaces.

=item An  optional length, which  specifies the minimum length  of the
result substring.

=item  An optional  C<"E">  or  C<"O"> modifier.  On  some older  UNIX
system,  these  were used  to  give  the I<extended>  or  I<localized>
version of the date attribute. Here, these C<"E"> and C<"O"> modifiers
are ignored.


=head1 ISSUES

=head2 The First Month of the Civil Year

The website L<https://www.azteccalendar.com>  gives three options: the
Alfonso   Caso  correlation,   the  Alfonso   Caso  correlation   with
Nicholson's alignment  and the Francisco Cortes  correlation. With the
plain Caso  correlation and  with the  Cortes correlation,  the months
follow this sequence:

=item 18 Tititl
=item 19 Nemontemi
=item 1 Izcalli
=item 2 Atlcahualo

while  the  Caso  correlation  with Nicholson's  alignment  uses  this
sequence:

=item 17 Tititl
=item 18 Izcalli
=item 19 Nemontemi
=item 1 Atlcahualo

I have decided to discard  Nicholson's alignment and to implement only
the  plain Alfonso  Caso correlation  (this class)  and the  Francisco
Cortes correlation (see L<Date::Calendar::Aztec::Cortes>).

=head2 Definition of the Day

This class  assumes that days  are midnight  to midnight. My  guess it
that actually, the Aztecs used another convention, sunset to sunset or
sunrise to  sunrise. I have not  found any information on  this in the
sources I have read.

=head2 Rollover

The  Aztecs had  nothing  like the  Mayas' long  count  or like  other
calendars'  year numbers.  By combining  the civil  calendar with  the
clerical calendar, we  get different combinations for  about 52 years.
This period  is called the  "calendar round".  So when given  an Aztec
date with the four values (tonalpohualli number and name, xiuhpohualli
number and name), you cannot define a unique Gregorian date equivalent
to this Aztec date. The Gregorian date 52 years later (or 104, or 156)
and the Gregorian date 52 years earlier (or 104 or...) also correspond
to this Aztec date.

For this  reason, Aztec dates are  created with a reference  date from
another calendar, so the module will  compute which is the first Aztec
date on  or after  the reference  date and  with the  requested month,
name,  clerical  index and  clerical  number  (or  "on or  before  the
reference date", or "nearest to the reference date", etc). This allows
the module to compute a  semi-hidden attribute C<daycount>, which will
be used when converting an Aztec date to another calendar.

=head2 The Name of Month 2

Another   issue    it   month   number   2,    between   Izcalli   and
Tlacaxipehualiztli. Most  sources give the name  "Atlcahualo", but the
website     L<https://www.azteccalendar.com>     gives    the     name
"Cuauhuitlehua".

=head2 Year Bearers

For a given civil year, the year  bearer is the clerical number + name
of new year's day,  or possibly of new year's eve.  In other words, it
is  either  the tonalpohualli  number  +  name  of  1 Izcalli  or  the
tonalpohualli  number +  name  of  5 Nemontemi.  Yet,  when we  browse
L<https://www.azteccalendar.com>, we find that the year bearer has the
tonalpohualli name of  the previous 5 Nemontemi  and the tonalpohualli
number of the previous  1 Nemontemi. Is this a bug  in this website or
is it  a very convoluted definition  of the year bearer,  although the
real definition? I have decided to stick with it.

=head1 SEE ALSO

=head2 Raku Software

L<Date::Calendar::Strftime>
or L<https://github.com/jforget/raku-Date-Calendar-Strftime>

L<Date::Calendar::Gregorian>
or L<https://github.com/jforget/raku-Date-Calendar-Gregorian>

L<Date::Calendar::Julian>
or L<https://github.com/jforget/raku-Date-Calendar-Julian>

L<Date::Calendar::Hebrew>
or L<https://github.com/jforget/raku-Date-Calendar-Hebrew>

L<Date::Calendar::Hijri>
or L<https://github.com/jforget/raku-Date-Calendar-Hijri>

L<Date::Calendar::Persian>
or L<https://github.com/jforget/raku-Date-Calendar-Persian>

L<Date::Calendar::CopticEthiopic>
or L<https://github.com/jforget/raku-Date-Calendar-CopticEthiopic>

L<Date::Calendar::Bahai>
or L<https://github.com/jforget/raku-Date-Calendar-Bahai>

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

L<https://icalendrier.fr/calendriers-saga/calendriers/azteque/> (in French)

=head1 AUTHOR

Jean Forget <J2N-FORGET at orange dot fr>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2020, 2023, 2024 Jean Forget

This library is  free software; you can redistribute  it and/or modify
it under the Artistic License 2.0.

=end pod
