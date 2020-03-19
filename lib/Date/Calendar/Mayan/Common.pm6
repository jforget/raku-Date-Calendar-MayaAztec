use v6.c;
use Date::Calendar::Mayan::Names;
use Date::Calendar::MayanAztec;

unit role Date::Calendar::Mayan::Common:ver<0.0.1>:auth<cpan:JFORGET>;


# Mayan days are numbered 0 to 19 in the civil calendar, while Aztec days are numbered 1 to 20
method day-nb-begin-with {
  0;
}

# method specific-format { %( Oj => { $.feast },
#                            '*' => { $.feast },
#                             Ej => { $.feast-long },
#                             EJ => { $.feast-caps },
#                             Ey => { $.year-roman.lc },
#                             EY => { $.year-roman },
#                              u => { $.day-of-décade },
#                              V => { $.décade-number },
#                            ) }

=begin pod

=head1 NAME

Date::Calendar::Mayan::Common - Common code for the variants of Date::Calendar::Mayan

=head1 DESCRIPTION

Date::Calendar::Mayan is a  module defining a role which  is shared by
the variants of the Date::Calendar::Mayan class.

See the full documentation in the main module, C<Date::Calendar::Mayan>.

=head1 AUTHOR

Jean Forget <JFORGET at cpan dot org>

=head1 COPYRIGHT AND LICENSE

Copyright © 2020 Jean Forget, all rights reserved

This library is  free software; you can redistribute  it and/or modify
it under the Artistic License 2.0.

=end pod
