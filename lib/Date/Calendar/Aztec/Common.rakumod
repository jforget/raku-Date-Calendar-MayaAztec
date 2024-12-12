# -*- encoding: utf-8; indent-tabs-mode: nil -*-

use v6.d;
use Date::Calendar::Strftime:api<1>;
use Date::Calendar::Aztec::Names;
use Date::Calendar::MayaAztec;

unit role Date::Calendar::Aztec::Common:ver<0.1.0>:auth<zef:jforget>:api<1>;

multi method BUILD(Int:D :$daycount, Str :$locale = 'nah', Int :$daypart = daylight()) {
  my ($day, $month, $clerical-number, $clerical-index) = $.calendar-round-from-daycount($daycount, $daypart);
  check-locale($locale);
  self!build-calendar-round($month, $day, $clerical-index, $clerical-number, $daycount, $locale, $daypart);
}

multi method BUILD(Int:D :$month, Int:D :$day, Int:D :$clerical-index, Int:D :$clerical-number
                 , Str   :$locale  = 'nah'
                 , Int   :$daypart = daylight()
                 , :$before, :$on-or-before, :$after, :$on-or-after, :$nearest) {
  check-locale($locale);
  my Int $ref = self!check-ref-date-and-normalize(before  => $before, on-or-before => $on-or-before
                                                , after   => $after,  on-or-after  => $on-or-after
                                                , nearest => $nearest);
  self!check-calendar-round($month, $day, $clerical-index, $clerical-number, $daypart);
  my Int $daycount = self!daycount-from-calendar-round($month, $day, $clerical-index, $clerical-number, $ref, $daypart);
  self!build-calendar-round($month, $day, $clerical-index, $clerical-number, $daycount, $locale, $daypart);
}

multi method BUILD(Int:D  :$xiuhpohualli-index, Int:D  :$xiuhpohualli-number
                 , Int:D :$tonalpohualli-index, Int:D :$tonalpohualli-number
                 , Str   :$locale = 'nah'
                 , Int   :$daypart = daylight()
                 , :$before, :$on-or-before, :$after, :$on-or-after, :$nearest) {
  check-locale($locale);
  my Int $ref = self!check-ref-date-and-normalize(before  => $before, on-or-before => $on-or-before
                                                , after   => $after,  on-or-after  => $on-or-after
                                                , nearest => $nearest);
  self!check-calendar-round($xiuhpohualli-index,  $xiuhpohualli-number
                         , $tonalpohualli-index, $tonalpohualli-number
                         , $daypart);
  my Int $daycount = self!daycount-from-calendar-round($xiuhpohualli-index,  $xiuhpohualli-number
                                                    , $tonalpohualli-index, $tonalpohualli-number
                                                    , $ref, $daypart);
  self!build-calendar-round($xiuhpohualli-index,  $xiuhpohualli-number
                         , $tonalpohualli-index, $tonalpohualli-number, $daycount
                         , $locale, $daypart);
}

sub check-locale(Str $locale) {
  unless Date::Calendar::Aztec::Names::allowed-locale($locale) {
    X::Invalid::Value.new(:method<BUILD>, :name<locale>, :value($locale)).throw;
  }
}

method new-from-daycount(Int $nb, Int :$daypart = daylight) {
  $.new(daycount => $nb, daypart => $daypart);
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

method compat-day-clerical-idx {
  2;
}

# For any correlation, the Aztec Epoch is 4 Xochitl 2 Huei Tecuilhuitl and the Maya Epoch is 4 Ahau 8 Cumku.
# No problem with the clerical calendars, but the civil calendars are not synchronised.
# Here is the "day of year" (0..364) for the Aztec epoch
method epoch-doy {
  161;
}

method specific-format { %(  A => { $.tonalpohualli-name   },
                             F => Nil,
                             G => { $.year-bearer          },
                             u => { $.tonalpohualli-index  },
                             V => { $.tonalpohualli-number },
                             Y => { $.year-bearer          },
                            ) }

=begin pod

=head1 NAME

Date::Calendar::Aztec::Common - Common code for the two variants of Date::Calendar::Aztec

=head1 DESCRIPTION

Date::Calendar::Aztec is a  module defining a role which  is shared by
the two variants of the Date::Calendar::Aztec class.

See the full documentation in the main class,
C<Date::Calendar::Aztec>.

=head1 AUTHOR

Jean Forget <J2N-FORGET at orange dot fr>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2020, 2023, 2024 Jean Forget

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
