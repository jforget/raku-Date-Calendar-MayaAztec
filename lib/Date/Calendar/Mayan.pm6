use v6.c;

use Date::Calendar::Strftime;
use Date::Calendar::MayanAztec;

unit class Date::Calendar::Mayan:ver<0.0.1>:auth<cpan:JFORGET>
      does Date::Calendar::MayanAztec
      does Date::Calendar::Strftime;


=begin pod

=head1 NAME

Date::Calendar::Mayan - conversions from/to the Mayan calendar

=head1 SYNOPSIS

=begin code :lang<perl6>

use Date::Calendar::Mayan;
my Date                  $d-greg  .= new(2020, 6, 20);
my Date::Calendar::Mayan $d-mayan .= new-from-date($d-greg);

say "{.tzolkin} {.haab"} {.long-count}" with $d-mayan;
# --> 12 Etznab 1 Tzec 13.0.7.10.18
$d-mayan.locale = 'en';
say "{.tzolkin} {.haab"}" with $d-mayan;
# --> 12 Flint 1 Skull

=end code

=head1 DESCRIPTION

Date::Calendar::Mayan is a class  which implements the Mayan calendars
(long count, Haab and Tzolkin).

=head1 AUTHOR

Jean Forget <JFORGET@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright © 2020 Jean Forget

This library is  free software; you can redistribute  it and/or modify
it under the Artistic License 2.0.

=end pod
