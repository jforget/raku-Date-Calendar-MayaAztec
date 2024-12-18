# -*- encoding: utf-8; indent-tabs-mode: nil -*-

use v6.d;
use Date::Calendar::Strftime:api<1>;

# Warning: "vague year" and "calendar round" are known concepts that you can find in external documentation.
# On the other hand, "sub calendar round" is only used here.
#
# Vague year:         period length for the (month, day) couple
# Calendar round:     period length for the (month, day, clerical index, clerical number) tuple
# Sub calendar round: period length for the (month, day, clerical index) triple
#
constant VAGUE-YEAR         = 365;
constant SUB-CALENDAR-ROUND = 365 lcm 20;
constant CALENDAR-ROUND     = 365 lcm 20 lcm 13;

unit role Date::Calendar::MayaAztec:ver<0.1.0>:auth<zef:jforget>:api<1>;

has Int $.day             where { 0 ≤ $_ ≤ 20 }; # Haab number (0 to 19) or xiuhpohualli number (1 to 20)
has Int $.month           where { 1 ≤ $_ ≤ 19 }; # Number equivalent of Haab name or xiuhpohualli name
has Int $.clerical-number where { 1 ≤ $_ ≤ 13 }; # Tzolkin number or tonalpohualli number
has Int $.clerical-index  where { 1 ≤ $_ ≤ 20 }; # Number equivalent of the Tzolkin name or tonalpohualli name
has Int $.daycount;
has Int $.daypart where { before-sunrise() ≤ $_ ≤ after-sunset() };
has Str $.locale is rw;


method !build-calendar-round(Int $month, Int $day, Int $clerical-index, Int $clerical-number, Int $daycount, Str $locale, Int $daypart) {
  $!month           = $month;
  $!day             = $day;
  $!clerical-index  = $clerical-index;
  $!clerical-number = $clerical-number;
  $!daycount        = $daycount;
  $!daypart         = $daypart;
  $!locale          = $locale;
}

method new-from-date($date) {
  $.new-from-daycount($date.daycount, daypart => $date.?daypart // daylight);
}

method calendar-round-from-daycount($nb, Int $daypart = daylight) {
  my $delta   = $nb + 2400001 - $.epoch;
  my $doy     = ($delta + $.epoch-doy) % 365;       # day of year, range 0..364
  if $daypart == before-sunrise() {
    -- $doy;
    if $doy == -1 {
      $doy = 364;
    }
  }
  if $daypart == after-sunset() {
    ++ $delta
  }
  my $day     = $doy % 20 + $.day-nb-begin-with;
  my $month   = floor($doy / 20) + 1;
  my $cle-num = 1 + ($delta +  3) % 13;
  my $cle-idx = 1 + ($delta + 19) % 20;
  return $day, $month, $cle-num, $cle-idx;
}

method !check-ref-date-and-normalize(:$before, :$on-or-before, :$after, :$on-or-after, :$nearest) {
  my Int $count = 0;
  my Int $ref;
  for ( ($before      , 'before'      , CALENDAR-ROUND)
      , ($on-or-before, 'on-or-before', CALENDAR-ROUND - 1)
      , ($after       , 'after'       , -1)
      , ($on-or-after , 'on-or-after' , 0)
      , ($nearest     , 'nearest'     , (CALENDAR-ROUND / 2).Int)
      ) -> ($var, $name, $offset) {
    if $var.defined {
      ++$count;
      unless $var.can('daycount') {
        die "Parameter $name should be a Date object or a Date::Calendar::whatever object";
      }
      $ref = $var.daycount - $offset;
    }
  }
  if $count > 1 {
    die "No more than one reference date";
  }
  if $count == 0 {
    $ref = Date.today.daycount - (CALENDAR-ROUND / 2).Int;
  }
  return $ref;
}

method !check-calendar-round(Int $month, Int $day is copy, Int $clerical-index is copy, Int $clerical-number, Int $daypart) {
  unless 1 ≤ $month ≤ 19 {
    X::OutOfRange.new(:what<Month>, :got($month), :range<1..19>).throw;
  }

  my Int $min = $.day-nb-begin-with;
  my Int $max;
  my Str $range;
  if $month ≤ 18 {
    $max = $min + 19;
    $range = "$min..$max";
    unless $min ≤ $day ≤ $max {
      X::OutOfRange.new(:what<Day>, :got($day), :range($range)).throw;
    }
  }
  else {
    $max = $min + 4;
    $range = "$min..$max";
    unless $min ≤ $day ≤ $max {
      X::OutOfRange.new(:what<Day>, :got($day), :range($range)).throw;
    }
  }

  # check clerical values
  unless 1 ≤ $clerical-index ≤ 20 {
    X::OutOfRange.new(:what<Clerical-Index>, :got($clerical-index), :range<1..20>).throw;
  }
  unless 1 ≤ $clerical-number ≤ 13 {
    X::OutOfRange.new(:what<Clerical-Number>, :got($clerical-number), :range<1..13>).throw;
  }

  # check compatibility between civil values and clerical values
  if $daypart == before-sunrise() {
    ++ $day;
  }
  if $daypart == after-sunset() {
    -- $clerical-index
  }
  unless ($day - $clerical-index) % 5 == $.compat-day-clerical-idx {
    die "Clerical index $clerical-index is incompatible with the day number $day";
  }
}

method !daycount-from-calendar-round(Int $month, Int $day is copy, Int $clerical-index is copy, Int $clerical-number is copy, Int $ref, Int $daypart) {
  if $daypart == before-sunrise() {
    ++ $day;
  }
  if $daypart == after-sunset() {
    -- $clerical-index;
    -- $clerical-number;
  }
  # First step: normalize the reference date
  # -- using "on-or-after" instead of the 4 other modes
  # -- using MJD instead of a Date or Date::Calendar::xxx object.
  # Already done in check-ref-date-and-normalize
  # For example, Finding "3-Quecholli 9-Cipactli" nearest to 2020-01-01 (MJD 58849) is the same
  # as finding this date on or after  MJD 49359  (1994-01-07)

  # Second step: find the MJD with the proper month and day, without bothering with clerical index and number
  #
  # Example (continued): MJD 49359 is "9-5 10-17", that is, day 89 of the year, while the target
  # is "3-15 9-1", that is, day 283 in the year. By adding 283 - 89 = 194, we obtain MJD 49553,
  # which translates as 1994-07-20, or "3-15 9-11", or "3-Quecholli 9-Ozomahtli"
  # The clerical number happens to be correct, but this is a coincidence and we do not take advantage of it.
  #
  my ($ref-day, $ref-month, $ref-cle-num, $ref-cle-idx) = $.calendar-round-from-daycount($ref);
  my $q-ref = 20 × ($ref-month - 1) + $ref-day;
  my $q     = 20 × ($month     - 1) + $day;
  my $daycount = $ref + $q - $q-ref;
  if $q-ref > $q {
    $daycount += VAGUE-YEAR;
  }

  # Third step: find the MJD with the proper month and day and clerical index without bothering with clerical number
  #
  # Example (continued): adding two vague years, we obtain the following:
  #   49918 (1995-07-20)  →  "3-15 10-16" (3-Quecholli 10-Cozcacuauhtli)
  #   50283 (1996-07-19)  →  "3-15 11-1"  (3-Quecholli 11-Cipactli)
  my ($month1, $day1, $cle-num1, $cle-idx1) = $.calendar-round-from-daycount($daycount);
  while $cle-idx1 != $clerical-index | ($clerical-index + 20) {
    $daycount += VAGUE-YEAR;
    ($day1, $month1, $cle-num1, $cle-idx1) = $.calendar-round-from-daycount($daycount);
  }

  # Fourth step: find the MJD with the proper month and day and clerical index and clerical number
  #
  # Example (continued): adding 6 "sub calendar rounds", we obtain the following:
  #   51743 (2000-07-18)  →  "3-15 2-1"  (3-Quecholli 2-Cipactli)
  #   53203 (2004-07-17)  →  "3-15 6-1"  (3-Quecholli 6-Cipactli)
  #   54663 (2008-07-16)  →  "3-15 10-1" (3-Quecholli 10-Cipactli)
  #   56123 (2012-07-15)  →  "3-15 1-1"  (3-Quecholli 1-Cipactli)
  #   57583 (2016-07-14)  →  "3-15 5-1"  (3-Quecholli 5-Cipactli)
  #   59043 (2020-07-13)  →  "3-15 9-1"  (3-Quecholli 9-Cipactli)
  while $cle-num1 != $clerical-number | ($clerical-number + 13) {
    $daycount += SUB-CALENDAR-ROUND;
    ($day1, $month1, $cle-num1, $cle-idx1) = $.calendar-round-from-daycount($daycount);
  }
  return $daycount;

}

method to-date($class = 'Date') {
  # See "Learning Perl 6" page 177
  my $d = ::($class).new-from-daycount($.daycount, daypart => $.daypart);
  return $d;
}

=begin pod

=head1 NAME

Date::Calendar::MayaAztec - conversions from/to the Maya calendar and conversions to the Aztec calendar

=head1 SYNOPSIS

=begin code :lang<raku>

use Date::Calendar::Maya;
use Date::Calendar::Aztec;
my Date                  $d-greg  .= new(2020, 6, 20);
my Date::Calendar::Aztec $d-aztec .= new-from-date($d-greg);
my Date::Calendar::Maya  $d-maya  .= new-from-date($d-greg);

say "{.tzolkin} {.haab} {.long-count}" with $d-maya;
# --> 12 Etznab 1 Tzec 13.0.7.10.18
$d-maya.locale = 'en';
say "{.tzolkin} {.haab}" with $d-maya;
# --> 12 Flint 1 Skull

say "{.tonalpohualli} {.xiuhpohualli}" with $d-aztec;
# --> 12 Tecpatl 20 Teotleco
$d-aztec.locale = 'en';
say "{.tonalpohualli} {.xiuhpohualli}" with $d-aztec;
# --> 12 Flint 20 God arrives

=end code

Conversion while paying attention to sun rise and sun set:

=begin code :lang<raku>

use Date::Calendar::Strftime;
use Date::Calendar::Gregorian;
use Date::Calendar::Aztec;
use Date::Calendar::Maya;

my Date::Calendar::Gregorian $d-gr;
my Date::Calendar::Aztec     $d-az;
my Date::Calendar::Maya      $d-ma;

$d-gr .= new('2024-11-13', daypart => before-sunrise());
$d-az .= new-from-date($d-gr);
$d-ma .= new-from-date($d-gr);
say $d-az.strftime("%V %A %e %B"), $d-ma.strftime(" / %F %V %A %e %B");
# -->  "7 Coatl 1 Tlacaxipehualiztli / 13.0.12.1.5 7 Chicchan 7 Ceh"

$d-gr .= new('2024-11-13', daypart => daylight());
$d-az .= new-from-date($d-gr);
$d-ma .= new-from-date($d-gr);
say $d-az.strftime("%V %A %e %B"), $d-ma.strftime(" / %F %V %A %e %B");
# -->  "7 Coatl 2 Tlacaxipehualiztli / 13.0.12.1.5 7 Chicchan 8 Ceh"

$d-gr .= new('2024-11-13', daypart => after-sunset());
$d-az .= new-from-date($d-gr);
$d-ma .= new-from-date($d-gr);
say $d-az.strftime("%V %A %e %B"), $d-ma.strftime(" / %F %V %A %e %B");
# -->  "8 Miquiztli 2 Tlacaxipehualiztli / 13.0.12.1.5 8 Cimi Ceh"
=end code

=head1 DESCRIPTION

Date::Calendar::MayaAztec  is a  distribution with  two main  classes,
Date::Calendar::Maya implementing the Maya calendars (long count, Haab
and   Tzolkin)  and   Date::Calendar::Aztec  implementing   the  Aztec
calendars (tonalpohualli and xiuhpohualli).

See the full documentation  in each class, C<Date::Calendar::Maya> and
C<Date::Calendar::Aztec>.

=head1 SEE ALSO

=head2 Raku Software

L<Date::Calendar::Strftime|https://raku.land/zef:jforget/Date::Calendar::Strftime>
or L<https://github.com/jforget/raku-Date-Calendar-Strftime>

L<Date::Calendar::Gregorian|https://raku.land/zef:jforget/Date::Calendar::Gregorian>
or L<https://github.com/jforget/raku-Date-Calendar-Gregorian>

L<Date::Calendar::Julian|https://raku.land/zef:jforget/Date::Calendar::Julian>
or L<https://github.com/jforget/raku-Date-Calendar-Julian>

L<Date::Calendar::Hebrew|https://raku.land/zef:jforget/Date::Calendar::Hebrew>
or L<https://github.com/jforget/raku-Date-Calendar-Hebrew>

L<Date::Calendar::CopticEthiopic|https://raku.land/zef:jforget/Date::Calendar::CopticEthiopic>
or L<https://github.com/jforget/raku-Date-Calendar-CopticEthiopic>

L<Date::Calendar::FrenchRevolutionary|https://raku.land/zef:jforget/Date::Calendar::FrenchRevolutionary>
or L<https://github.com/jforget/raku-Date-Calendar-FrenchRevolutionary>

L<Date::Calendar::Hijri|https://raku.land/zef:jforget/Date::Calendar::Hijri>
or L<https://github.com/jforget/raku-Date-Calendar-Hijri>

L<Date::Calendar::Persian|https://raku.land/zef:jforget/Date::Calendar::Persian>
or L<https://github.com/jforget/raku-Date-Calendar-Persian>

L<Date::Calendar::Bahai|https://raku.land/zef:jforget/Date::Calendar::Bahai>
or L<https://github.com/jforget/raku-Date-Calendar-Bahai>

=head2 Perl 5 Software

L<Date::Maya|https://metacpan.org/pod/Date::Maya>

L<DateTime::Calendar::Mayan|https://metacpan.org/dist/DateTime-Calendar-Mayan/view/lib/DateTime/Calendar/Mayan.pod>

=head2 Other Software

C<calendar/cal-mayan.el>  in Emacs

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
(website no longer responding).

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

Jean Forget <J2N-FORGET at orange dot fr>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2020, 2023, 2024 Jean Forget

This library is  free software; you can redistribute  it and/or modify
it under the Artistic License 2.0.

=end pod
