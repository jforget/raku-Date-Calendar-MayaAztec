use v6.c;
unit role Date::Calendar::MayanAztec:ver<0.0.1>:auth<cpan:JFORGET>;


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
$d-aztec.locale = 'en';
say "{.tonalpohualli} {.xiuhpohualli}" with $d-aztec;
# --> 12 Flint 20 God arrives

say "{.tzolkin} {.haab"}" with $d-mayan;
# --> 12 Etznab 1 Tzec
$d-mayan.locale = 'en';
say "{.tzolkin} {.haab"}" with $d-mayan;
# --> 12 Flint 1 Skull

=end code

=head1 DESCRIPTION

Date::Calendar::MayanAztec is  a distribution  with two  main classes,
Date::Calendar::Mayan  implementing the  Mayan calendars  (long count,
Haab  and Tzolkin)  and Date::Calendar::Aztec  implementing the  Aztec
calendars (tonalpohualli and xiuhpohualli).

=head1 AUTHOR

Jean Forget <JFORGET@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright © 2020 Jean Forget

This library is  free software; you can redistribute  it and/or modify
it under the Artistic License 2.0.

=end pod
