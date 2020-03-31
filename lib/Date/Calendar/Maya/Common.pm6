use v6.c;
use Date::Calendar::Maya::Names;
use Date::Calendar::MayaAztec;

unit role Date::Calendar::Maya::Common:ver<0.0.2>:auth<cpan:JFORGET>;

has Int $.kin    where { 0 ≤ $_ ≤ 19 };
has Int $.uinal  where { 0 ≤ $_ ≤ 17 };
has Int $.tun    where { 0 ≤ $_ ≤ 19 };
has Int $.katun  where { 0 ≤ $_ ≤ 19 };
has Int $.baktun where { 0 ≤ $_ ≤ 19 };
has Int $.daycount;

multi method BUILD(Str:D :$long-count, Str :$locale = 'yua') {
  # Checking values
  my ($baktun, $katun, $tun, $uinal, $kin) =  parse-long-count($long-count);
  check-locale($locale);

  # Computing derived attributes
  my $daycount = $.daycount-from-long-count($baktun, $katun, $tun, $uinal, $kin);
  my ($day, $month, $clerical-number, $clerical-index) = $.calendar-round-from-daycount($daycount);

  # Building the object
  self!build-calendar-round($month, $day, $clerical-index, $clerical-number, $locale);
  self!build-long-count($baktun, $katun, $tun, $uinal, $kin, $daycount);
}

multi method BUILD(Int:D :$daycount, Str :$locale = 'yua') {
  # Checking values
  check-locale($locale);

  # Computing derived attributes
  my ($day, $month, $clerical-number, $clerical-index) = $.calendar-round-from-daycount($daycount);
  my ($baktun, $katun, $tun, $uinal, $kin)             =     $.long-count-from-daycount($daycount);

  # Building the object
  self!build-calendar-round($month, $day, $clerical-index, $clerical-number, $locale);
  self!build-long-count($baktun, $katun, $tun, $uinal, $kin, $daycount);
}

sub check-locale(Str $locale) {
  unless Date::Calendar::Maya::Names::allowed-locale($locale) {
    X::Invalid::Value.new(:method<BUILD>, :name<locale>, :value($locale)).throw;
  }
}

method !build-long-count(Int $baktun, Int $katun, Int $tun, Int $uinal, Int $kin, Int $daycount) {
  $!baktun   = $baktun;
  $!katun    = $katun;
  $!tun      = $tun;
  $!uinal    = $uinal;
  $!kin      = $kin;
  $!daycount = $daycount;
}

method daycount-from-long-count(Int $baktun, Int $katun, Int $tun, Int $uinal, Int $kin) {
  # Inspired by Horner's method to compute values for polynomials
  return ((($baktun × 20 + $katun
                  ) × 20 + $tun
                  ) × 18 + $uinal
                  ) × 20 + $kin + $.epoch -  2400001;
}

method long-count-from-daycount(Int $daycount) {
  my $nbj = $daycount - $.epoch + 2400001;
  my ($kin, $uinal, $tun, $katun, $baktun) = $nbj.polymod(20, 18, 20, 20, 20);
  return ($baktun, $katun, $tun, $uinal, $kin) ;
}

method new-from-daycount(Int $nb) {
  $.new(daycount => $nb);
}

method to-date($class = 'Date') {
  # See "Learning Perl 6" page 177
  my $d = ::($class).new-from-daycount($.daycount);
  return $d;
}

method gist {
  $.long-count;
}

method long-count {
  sprintf("%d.%d.%d.%d.%d", $.baktun, $.katun, $.tun, $.uinal, $.kin);
}

method day-of-year {
  $.day + 20 × ($.month - 1);
}

method month-name {
  Date::Calendar::Maya::Names::month-name($.locale, $.month);
}

method day-name {
  Date::Calendar::Maya::Names::day-name($.locale, $.clerical-index);
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

method year-bearer-number {
  ($.tzolkin-number - $.day-of-year - 1) % 13 + 1;
}

method year-bearer-index {
  ($.tzolkin-index - $.day-of-year) % 20;
}

method year-bearer-name {
  Date::Calendar::Maya::Names::day-name($.locale, $.year-bearer-index);
}

method year-bearer {
  "{$.year-bearer-number} {$.year-bearer-name}";
}

# Maya days are numbered 0 to 19 in the civil calendar, while Aztec days are numbered 1 to 20
method day-nb-begin-with {
  0;
}

# For any correlation, the Maya Epoch is 4 Ahau 8 Cumku and the Aztec Epoch is 4 Xochitl 2 Huei Tecuilhuitl.
# No problem with the clerical calendars, but the civil calendars are not synchronised.
# Here is the "day of year" (0..364) for the Maya epoch 8 Cumku
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
  return $0.map( { + $_ } );
}

method specific-format { %(  A => { $.tzolkin-name },
                             F => { $.long-count },
                             G => { $.year-bearer },
                             u => { $.tzolkin-index },
                             V => { $.tzolkin-number },
                             Y => { $.year-bearer },
                            ) }

=begin pod

=head1 NAME

Date::Calendar::Maya::Common - Common code for the variants of Date::Calendar::Maya

=head1 DESCRIPTION

Date::Calendar::Maya::Common  is a  module  defining a  role which  is
shared by the variants of the Date::Calendar::Maya class.

See the full documentation in the main class, C<Date::Calendar::Maya>.

=head1 AUTHOR

Jean Forget <JFORGET at cpan dot org>

=head1 COPYRIGHT AND LICENSE

Copyright © 2020 Jean Forget, all rights reserved

This library is  free software; you can redistribute  it and/or modify
it under the Artistic License 2.0.

=end pod
