use v6.c;

use Date::Calendar::Strftime;
use Date::Calendar::MayaAztec;
use Date::Calendar::Maya::Common;

unit class Date::Calendar::Maya::Spinden:ver<0.0.1>:auth<cpan:JFORGET>
      does Date::Calendar::MayaAztec
      does Date::Calendar::Maya::Common
      does Date::Calendar::Strftime;

# Spinden correlation: day 0.0.0.0.0 is 15 October -3373 (or 3374 BC)
method epoch {
  489384;
}

=begin pod

=head1 NAME

Date::Calendar::Maya::Spinden - conversions from/to the Maya calendar

=head1 SYNOPSIS

=begin code :lang<perl6>

use Date::Calendar::Maya::Spinden;
my Date $d-greg .= new(2020, 6, 20);
my Date::Calendar::Maya::Spinden
        $d-maya .= new-from-date($d-greg);

say "{.tzolkin} {.haab} {.long-count}" with $d-maya;
# --> 11 Caban 0 Tzec 13.13.11.3.17
$d-maya.locale = 'en';
say "{.tzolkin} {.haab}" with $d-maya;
# --> 11 Quake 0 Skull

=end code

=head1 DESCRIPTION

Date::Calendar::Maya::Spinden  is a  class which  implements the  Maya
calendars (long count, Haab and Tzolkin).

This  class  uses the  Spinden  correlation.  Other classes  uses  the
Goodman-Martinez-Thompson correlation or  what is named "Astronomical"
on the website L<http://research.famsi.org/date_mayaLC.php>.

Mayas  used  three different  calendars,  the  Long Count,  the  civil
calendar or "Haab" and the clerical calendar or "Tzolkin".

The  civil  calendar is  organized  like  other calendars,  with  days
grouped  in  months  grouped  in  years.  The  difference  with  other
calendars is  that the months  last 20 days  each, not around  30, and
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

See the full documentation in the main class C<Date::Calendar::Maya>.

=head1 AUTHOR

Jean Forget <JFORGET@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright © 2020 Jean Forget

This library is  free software; you can redistribute  it and/or modify
it under the Artistic License 2.0.

=end pod
