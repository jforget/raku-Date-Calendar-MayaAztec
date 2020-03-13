use v6.c;
use Date::Calendar::Aztec::Names;
use Date::Calendar::MayanAztec;

unit role Date::Calendar::Aztec::Common:ver<0.0.1>:auth<cpan:JFORGET>;

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

  unless Date::Calendar::Aztec::Names::allowed-locale($locale) {
    X::Invalid::Value.new(:method<BUILD>, :name<locale>, :value($locale)).throw;
  }
}

method new-from-date($date) {
  $.new-from-daycount($date.daycount);
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
  Date::Calendar::Aztec::Names::day-name($.locale, $.day);
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

Date::Calendar::Aztec is a module defining a role
which is shared by the two variants of the
Date::Calendar::Aztec class.

See the full documentation in the main module, 
C<Date::Calendar::Aztec>.

=head1 AUTHOR

Jean Forget <JFORGET at cpan dot org>

=head1 COPYRIGHT AND LICENSE

Copyright © 2020 Jean Forget, all rights reserved

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
