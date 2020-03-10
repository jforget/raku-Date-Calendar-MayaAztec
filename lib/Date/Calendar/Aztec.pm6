use v6.c;

use Date::Calendar::Strftime;
use Date::Calendar::MayanAztec;

unit class Date::Calendar::Aztec:ver<0.0.1>:auth<cpan:JFORGET>
      does Date::Calendar::MayanAztec
      does Date::Calendar::Strftime;


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

=head1 AUTHOR

Jean Forget <JFORGET@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright © 2020 Jean Forget

This library is  free software; you can redistribute  it and/or modify
it under the Artistic License 2.0.

=end pod
