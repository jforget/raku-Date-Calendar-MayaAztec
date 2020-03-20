use v6.c;
use Date::Calendar::Mayan::Names;
use Date::Calendar::MayanAztec;

unit role Date::Calendar::Mayan::Common:ver<0.0.1>:auth<cpan:JFORGET>;

multi method BUILD(Str:D :$long-count, Str :$locale = 'yua') {
  #my $daycount = $.long-count-to-daycount($long-count);
  my $daycount = 0; # for the moment
  my ($day, $month, $clerical-number, $clerical-index) = $.calendar-round-from-daycount($daycount);
  self!build-calendar-round($month, $day, $clerical-index, $clerical-number, $locale);
}

multi method BUILD(Int:D :$daycount, Str :$locale = 'yua') {
  my ($day, $month, $clerical-number, $clerical-index) = $.calendar-round-from-daycount($daycount);
  self!build-calendar-round($month, $day, $clerical-index, $clerical-number, $locale);
}


method new-from-daycount(Int $nb) {
  $.new(daycount => $nb);
}

method gist {
  sprintf("%d-%d %d-%d", $.day, $.month, $.clerical-number, $.clerical-index);
}

method day-of-year {
  $.day + 20 × ($.month - 1);
}

method month-name {
  Date::Calendar::Mayan::Names::month-name($.locale, $.month);
}

method day-name {
  Date::Calendar::Mayan::Names::day-name($.locale, $.clerical-index);
}

method tzolkin-number {
  $.clerical-number;
}

method tzolkin-index {
  $.clerical-index;
}

method tzolkin-name {
  $.day-name;
}

method tzolkin {
  "{$.tzolkin-number} {$.tzolkin-name}";
}

method haab-number {
  $.day;
}

method haab-name {
  $.month-name;
}

method haab {
  "{$.haab-number} {$.haab-name}";
}

# Mayan days are numbered 0 to 19 in the civil calendar, while Aztec days are numbered 1 to 20
method day-nb-begin-with {
  0;
}

# For any correlation, the Mayan Epoch is 4 Ahau 8 Cumku and the Aztec Epoch is 4 Xochitl 2 Huei Tecuilhuitl.
# No problem with the clerical calendars, but the civil calendars are not synchronised.
# Here is the "day of year" (0..364) for the Mayan epoch
method epoch-doy {
  348;
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
