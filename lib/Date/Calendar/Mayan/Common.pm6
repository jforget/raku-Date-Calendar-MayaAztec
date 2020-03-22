use v6.c;
use Date::Calendar::Mayan::Names;
use Date::Calendar::MayanAztec;

unit role Date::Calendar::Mayan::Common:ver<0.0.1>:auth<cpan:JFORGET>;

has Int $kin     where { 0 ≤ $_ ≤ 19 };
has Int $uinal   where { 0 ≤ $_ ≤ 17 };
has Int $tun     where { 0 ≤ $_ ≤ 19 };
has Int $katun   where { 0 ≤ $_ ≤ 19 };
has Int $baktun  where { 0 ≤ $_ ≤ 19 };

multi method BUILD(Str:D :$long-count, Str :$locale = 'yua') {
  my ($baktun, $katun, $tun, $uinal, $kin) =  parse-long-count($long-count);
  my $daycount = $.daycount-from-long-count($baktun, $katun, $tun, $uinal, $kin);
  my ($day, $month, $clerical-number, $clerical-index) = $.calendar-round-from-daycount($daycount);
  self!build-calendar-round($month, $day, $clerical-index, $clerical-number, $locale);
  self!build-long-count($baktun, $katun, $tun, $uinal, $kin);
}

multi method BUILD(Int:D :$daycount, Str :$locale = 'yua') {
  my ($day, $month, $clerical-number, $clerical-index) = $.calendar-round-from-daycount($daycount);
  self!build-calendar-round($month, $day, $clerical-index, $clerical-number, $locale);
}

method !build-long-count(Int $baktun, Int $katun, Int $tun, Int $uinal, Int $kin) {
  $!baktun = $baktun;
  $!katun  = $katun;
  $!tun    = $tun;
  $!uinal  = $uinal;
  $!kin    = $kin;
}

method daycount-from-long-count(Int $baktun, Int $katun, Int $tun, Int $uinal, Int $kin) {
  return ((($baktun × 20 + $katun
                  ) × 20 + $tun
                  ) × 18 + $uinal
                  ) × 20 + $kin + $.epoch -  2400001;
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

sub parse-long-count(Str $long-count) {
  unless $long-count ~~ / ^ (\d+) ** 5 % '.' $ / {
    X::Invalid::Value.new(:method<BUILD>, :name<long-count>, :value($long-count)).throw;
  }
  unless 0 ≤ $0[0] ≤ 19 { X::OutOfRange.new(:what<Baktun component>, :got(+ $0[0]), :range<0..19>).throw; }
  unless 0 ≤ $0[1] ≤ 19 { X::OutOfRange.new(:what<Katun component>,  :got(+ $0[1]), :range<0..19>).throw; }
  unless 0 ≤ $0[2] ≤ 19 { X::OutOfRange.new(:what<Tun component>,    :got(+ $0[2]), :range<0..19>).throw; }
  unless 0 ≤ $0[3] ≤ 17 { X::OutOfRange.new(:what<Uinal component>,  :got(+ $0[3]), :range<0..17>).throw; }
  unless 0 ≤ $0[4] ≤ 19 { X::OutOfRange.new(:what<Kin component>,    :got(+ $0[4]), :range<0..19>).throw; }
  say $/;
  return $0.map( { + $_ } );
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
