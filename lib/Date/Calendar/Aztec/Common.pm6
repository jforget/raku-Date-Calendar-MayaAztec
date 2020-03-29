use v6.c;
use Date::Calendar::Aztec::Names;
use Date::Calendar::MayaAztec;

unit role Date::Calendar::Aztec::Common:ver<0.0.1>:auth<cpan:JFORGET>;

multi method BUILD(Int:D :$month, Int:D :$day, Int:D :$clerical-index, Int:D :$clerical-number, Str :$locale = 'nah') {
  self!check-build-args(    $month, $day, $clerical-index, $clerical-number, $locale);
  self!build-calendar-round($month, $day, $clerical-index, $clerical-number, $locale);
}

multi method BUILD(Int:D :$xiuhpohualli-index, Int:D :$xiuhpohualli-number, Int:D :$tonalpohualli-index, Int:D :$tonalpohualli-number, Str :$locale = 'nah') {
  self!check-build-args(    $xiuhpohualli-index, $xiuhpohualli-number, $tonalpohualli-index, $tonalpohualli-number, $locale);
  self!build-calendar-round($xiuhpohualli-index, $xiuhpohualli-number, $tonalpohualli-index, $tonalpohualli-number, $locale);
}

method !check-build-args(Int $month, Int $day, Int $clerical-index, Int $clerical-number, Str $locale) {

  unless 1 ≤ $month ≤ 19 {
    X::OutOfRange.new(:what<Month>, :got($month), :range<1..19>).throw;
  }

  if $month ≤ 18 {
    unless 1 ≤ $day ≤ 20 {
      X::OutOfRange.new(:what<Day>, :got($day), :range<1..20>).throw;
    }
  }
  else {
    unless 1 ≤ $day ≤ 5 {
      X::OutOfRange.new(:what<Day>, :got($day), :range<1..5>).throw;
    }
  }

  # check clerical values
  unless 1 ≤ $clerical-index ≤ 20 {
    X::OutOfRange.new(:what<Clerical-Index>, :got($clerical-index), :range<1..20>).throw;
  }
  unless 1 ≤ $clerical-number ≤ 13 {
    X::OutOfRange.new(:what<Clerical-Number>, :got($clerical-number), :range<1..13>).throw;
  }

  # check compatibility between civil values and clerical values: TODO
  unless ($day - $clerical-index) % 5 == 2 {
    die "Clerical index $clerical-index is incompatible with the day number $day";
  }

  check-locale($locale);
}

sub check-locale(Str $locale) {
  unless Date::Calendar::Aztec::Names::allowed-locale($locale) {
    X::Invalid::Value.new(:method<BUILD>, :name<locale>, :value($locale)).throw;
  }
}

method new-from-daycount($nb) {
  my ($day, $month, $clerical-num, $clerical-idx) = $.calendar-round-from-daycount($nb);
  $.new( month => $month, day => $day, clerical-index => $clerical-idx, clerical-number => $clerical-num);
}

method gist {
  sprintf("%d-%d %d-%d", $.day, $.month, $.clerical-number, $.clerical-index);
}

method day-of-year {
  $.day + 20 × ($.month - 1);
}

method month-name {
  Date::Calendar::Aztec::Names::month-name($.locale, $.month);
}

method day-name {
  Date::Calendar::Aztec::Names::day-name($.locale, $.clerical-index);
}

method tonalpohualli-number {
  $.clerical-number;
}

method tonalpohualli-index {
  $.clerical-index;
}

method tonalpohualli-name {
  $.day-name;
}

method tonalpohualli {
  "{$.tonalpohualli-number} {$.tonalpohualli-name}";
}

method xiuhpohualli-number {
  $.day;
}

method xiuhpohualli-name {
  $.month-name;
}

method xiuhpohualli {
  "{$.xiuhpohualli-number} {$.xiuhpohualli-name}";
}

method year-bearer-number {
  ($.tonalpohualli-number - $.day-of-year - 5) % 13 + 1;
}

method year-bearer-index {
  ($.tonalpohualli-index - $.day-of-year) % 20;
}

method year-bearer-name {
  Date::Calendar::Aztec::Names::day-name($.locale, $.year-bearer-index);
}

method year-bearer {
  "{$.year-bearer-number} {$.year-bearer-name}";
}


# Aztec days are numbered 1 to 20 in the civil calendar, while Maya days are numbered 0 to 19
method day-nb-begin-with {
  1;
}

# For any correlation, the Aztec Epoch is 4 Xochitl 2 Huei Tecuilhuitl and the Maya Epoch is 4 Ahau 8 Cumku.
# No problem with the clerical calendars, but the civil calendars are not synchronised.
# Here is the "day of year" (0..364) for the Aztec epoch
method epoch-doy {
  161;
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

Date::Calendar::Aztec::Common - Common code for the two variants of Date::Calendar::Aztec

=head1 SYNOPSIS

=begin code :lang<perl6>

use Date::Calendar::Aztec;

=end code

=head1 DESCRIPTION

Date::Calendar::Aztec is a  module defining a role which  is shared by
the two variants of the Date::Calendar::Aztec class.

See the full documentation in the main class, 
C<Date::Calendar::Aztec>.

=head1 AUTHOR

Jean Forget <JFORGET at cpan dot org>

=head1 COPYRIGHT AND LICENSE

Copyright © 2020 Jean Forget, all rights reserved

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
