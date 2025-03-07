use v6.d;

use Date::Calendar::Strftime;
use Date::Calendar::MayaAztec;
use Date::Calendar::Aztec::Common;

unit class Date::Calendar::Aztec::Cortes:ver<0.1.1>:auth<zef:jforget>:api<1>
      does Date::Calendar::MayaAztec
      does Date::Calendar::Aztec::Common
      does Date::Calendar::Strftime;

# Julian day of the epoch.
method epoch {
  584280;
}

=begin pod

=head1 NAME

Date::Calendar::Aztec::Cortes - conversions to the Aztec calendar with the Francisco Cortes correlation

=head1 SYNOPSIS

=begin code :lang<raku>

use Date::Calendar::Aztec::Cortes;
my Date  $d-greg  .= new(2020, 6, 20);
my Date::Calendar::Aztec::Cortes
         $d-aztec .= new-from-date($d-greg);

say "{.tonalpohualli} {.xiuhpohualli}" with $d-aztec;
# --> 2 Cipactli 3 Tepeilhuitl
$d-aztec.locale = 'en';
say "{.tonalpohualli} {.xiuhpohualli}" with $d-aztec;
# --> 2 Crocodile 3 Mountain feast

=end code

=head1 DESCRIPTION

Date::Calendar::Aztec::Cortes  is a  class that  implements the  Aztec
calendars (tonalpohualli and xiuhpohualli).

This class uses  Francisco Cortes the correlation.  Another class uses
the Alfonso Caso correlation, see C<Date::Calendar::Aztec>.

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

See   the   documentation  in   the   other   Aztec  calendar   class,
C<Date::Calendar::Aztec>.

=head1 AUTHOR

Jean Forget <J2N-FORGET at orange dot fr>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2020, 2023, 2024, 2025 Jean Forget

This library is  free software; you can redistribute  it and/or modify
it under the Artistic License 2.0.

=end pod
