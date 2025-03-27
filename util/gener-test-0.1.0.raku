#!/usr/bin/env raku
# -*- encoding: utf-8; indent-tabs-mode: nil -*-
#
# Générer les données de test pour 10-conv-maya-old.rakutest, 11-conv-maya-new.rakutest, 12-conv-aztec-old.rakutest et 13-conv-aztec-new.rakutest
# Generate test data for 10-conv-maya-old.rakutest, 11-conv-maya-new.rakutest, 12-conv-aztec-old.rakutest and 13-conv-aztec-new.rakutest
#

use v6.d;
use Date::Calendar::Strftime:api<1>;
use Date::Calendar::Aztec;
use Date::Calendar::Aztec::Cortes;
use Date::Calendar::Bahai;
use Date::Calendar::Bahai::Astronomical;
use Date::Calendar::Coptic;
use Date::Calendar::Ethiopic;
use Date::Calendar::Hebrew;
use Date::Calendar::Hijri;
use Date::Calendar::Gregorian;
use Date::Calendar::FrenchRevolutionary;
use Date::Calendar::FrenchRevolutionary::Arithmetic;
use Date::Calendar::FrenchRevolutionary::Astronomical;
use Date::Calendar::Julian;
use Date::Calendar::Julian::AUC;
use Date::Calendar::Maya;
use Date::Calendar::Maya::Astronomical;
use Date::Calendar::Maya::Spinden;
use Date::Calendar::Persian;
use Date::Calendar::Persian::Astronomical;

my %class =   a0 => 'Date::Calendar::Aztec'
            , a1 => 'Date::Calendar::Aztec::Cortes'
            , ba => 'Date::Calendar::Bahai'
            , be => 'Date::Calendar::Bahai::Astronomical'
            , gr => 'Date::Calendar::Gregorian'
            , co => 'Date::Calendar::Coptic'
            , et => 'Date::Calendar::Ethiopic'
            , fr => 'Date::Calendar::FrenchRevolutionary'
            , fa => 'Date::Calendar::FrenchRevolutionary::Arithmetic'
            , fe => 'Date::Calendar::FrenchRevolutionary::Astronomical'
            , he => 'Date::Calendar::Hebrew'
            , hi => 'Date::Calendar::Hijri'
            , jl => 'Date::Calendar::Julian'
            , jc => 'Date::Calendar::Julian::AUC'
            , m0 => 'Date::Calendar::Maya'
            , m1 => 'Date::Calendar::Maya::Astronomical'
            , m2 => 'Date::Calendar::Maya::Spinden'
            , pe => 'Date::Calendar::Persian'
            , pa => 'Date::Calendar::Persian::Astronomical'
            ;

my %midnight = ba => False
             , be => False
             , co => False
             , et => False
             , fr => True
             , fa => True
             , fe => True
             , gr => True
             , he => False
             , hi => False
             , jl => True
             , jc => True
             , pe => True
             , pa => True
             ;

my @old-maya;
my @new-maya;
my @old-aztec;
my @new-aztec;

gener-others('ba', 2021,  7,  4);
gener-others('be', 2024, 10, 16);
gener-others('co', 2023,  2, 27);
gener-others('et', 2022,  4,  6);
gener-others('fr', 2024,  9, 12);
gener-others('fa', 2022,  8, 10);
gener-others('fe', 2023,  6, 21);
gener-others('gr', 2024, 11, 13);
gener-others('he', 2023, 11,  6);
gener-others('hi', 2021,  3, 13);
gener-others('jl', 2024,  9, 29);
gener-others('jc', 2024,  8,  2);
gener-others('pe', 2022, 11, 27);
gener-others('pa', 2021, 10,  2);

say '10-conv-maya-old.rakutest variables @data and then @data-greg';
say @old-maya.join("");
say '-' x 50;
say '11-conv-maya-new.rakutest variables @data-to-do and @data';
say @new-maya.join("");

say '-' x 50;
say '12-conv-aztec-old.rakutest variables @data and then @data-greg';
say @old-aztec.join("");
say '-' x 50;
say '13-conv-aztec-new.rakutest variables @data-to-do and @data';
say @new-aztec.join("");

sub gener-others($key, $year, $month, $day) {
  my Date $dg1 .= new($year, $month, $day);
  my Date $dg0  = $dg1 - 1;
  my Date $dg2  = $dg1 + 1;
  my Str $res-old;
  my Str $res-new;
  my Int $lg-sm = 23;
  my Int $lg-sa = 37;

  my Date::Calendar::Maya $dm0 .= new-from-date($dg0);
  my Date::Calendar::Maya $dm1 .= new-from-date($dg1);
  my Date::Calendar::Maya $dm2 .= new-from-date($dg2);
  ($res-old, $res-new) = gener-one($key, $dg0, $dg1, $dg2, $dm0, $dm1, $dm2, $lg-sm);
  push @old-maya, $res-old;
  push @new-maya, $res-new;

  my Date::Calendar::Aztec $da0 .= new-from-date($dg0);
  my Date::Calendar::Aztec $da1 .= new-from-date($dg1);
  my Date::Calendar::Aztec $da2 .= new-from-date($dg2);
  ($res-old, $res-new) = gener-one($key, $dg0, $dg1, $dg2, $da0, $da1, $da2, $lg-sa);
  push @old-aztec, $res-old;
  push @new-aztec, $res-new;
}

sub gener-one($key, $dg0, $dg1, $dg2, $dma0, $dma1, $dma2, $lg-sma) {
  my     $d0   = $dma0.to-date(%class{$key});
  my     $d1   = $dma1.to-date(%class{$key});
  my     $d2   = $dma2.to-date(%class{$key});
  my Str $s1   = $d1 .strftime('"%A %d %b %Y"');
  my Str $sma1 = $dma1.strftime('"%e %B %V %A ☼"');
  my Str $gr1  = $dg1.gist;
  my Str $s2;
  my Str $sma0;
  my Str $sma2;
  my Int $lg-s1  = 26;
  if $s1  .chars < $lg-s1  { $s1   ~= ' ' x ($lg-s1  - $s1  .chars); }
  if $sma1.chars < $lg-sma { $sma1 ~= ' ' x ($lg-sma - $sma1.chars); }
  my Str $month-x0 = sprintf("%2d", $dma0.month);
  my Str $day-x0   = sprintf("%2d", $dma0.day);
  my Str $month-x1 = sprintf("%2d", $dma1.month);
  my Str $day-x1   = sprintf("%2d", $dma1.day);
  my Str $idx-x1   = sprintf("%2d", $dma1.clerical-index);
  my Str $num-x1   = sprintf("%2d", $dma1.clerical-number);
  my Str $idx-x2   = sprintf("%2d", $dma2.clerical-index);
  my Str $num-x2   = sprintf("%2d", $dma2.clerical-number);
  my Str $res1 = qq:to<EOF>;
       , ($month-x0, $day-x0, $idx-x1, $num-x1, before-sunrise, '$key', $s1, $sma1, "$gr1 shift civil date")
       , ($month-x1, $day-x1, $idx-x1, $num-x1, daylight,       '$key', $s1, $sma1, "$gr1 no problem")
       , ($month-x1, $day-x1, $idx-x2, $num-x2, after-sunset,   '$key', $s1, $sma1, "$gr1 shift clerical date")
  EOF

  $s1   = $d1  .strftime("%A %d %b %Y");
  $s2   = $d2  .strftime("%A %d %b %Y");
  $sma1 = $dma1.strftime('"%e %B %V %A ☼"');
  $sma0 = $dma0.strftime('"%e %B ') ~ $dma1.strftime('%V %A ☾"');
  $sma2 = $dma1.strftime('"%e %B ') ~ $dma2.strftime('%V %A ☽"');
  if $sma0.chars < $lg-sma { $sma0 ~= ' ' x ($lg-sma - $sma0.chars); }
  if $sma1.chars < $lg-sma { $sma1 ~= ' ' x ($lg-sma - $sma1.chars); }
  if $sma2.chars < $lg-sma { $sma2 ~= ' ' x ($lg-sma - $sma2.chars); }
  my Int $lg = 24;
  my Str $w1 = ''; if $s1.chars < $lg { $w1 = ' ' x ($lg - $s1.chars); }
  my Str $w2 = ''; if $s2.chars < $lg { $w2 = ' ' x ($lg - $s2.chars); }
  my Str $res2;
  if %midnight{$key} {
    $res2 = qq:to<EOF>;
         , ($month-x0, $day-x0, $idx-x1, $num-x1, before-sunrise, '$key', "$s1 ☾"$w1, $sma0, "Gregorian: $gr1")
         , ($month-x1, $day-x1, $idx-x1, $num-x1, daylight,       '$key', "$s1 ☼"$w1, $sma1, "Gregorian: $gr1")
         , ($month-x1, $day-x1, $idx-x2, $num-x2, after-sunset,   '$key', "$s1 ☽"$w1, $sma2, "Gregorian: $gr1")
    EOF
  }
  else {
    $res2 = qq:to<EOF>;
         , ($month-x0, $day-x0, $idx-x1, $num-x1, before-sunrise, '$key', "$s1 ☾"$w1, $sma0, "Gregorian: $gr1")
         , ($month-x1, $day-x1, $idx-x1, $num-x1, daylight,       '$key', "$s1 ☼"$w1, $sma1, "Gregorian: $gr1")
         , ($month-x1, $day-x1, $idx-x2, $num-x2, after-sunset,   '$key', "$s2 ☽"$w2, $sma2, "Gregorian: $gr1")
    EOF
  }
  return $res1, $res2;
}


=begin pod

=head1 NAME

gener-test-0.1.0.raku -- Generation of test data

=head1 SYNOPSIS

  raku gener-test-0.1.0.raku > /tmp/test-data

copy-paste from /tmp/test-data to the tests scripts.

=head1 DESCRIPTION

This  program  uses  the  various  C<Date::Calendar::>R<xxx>  classes,
version 0.0.x and  API 0, to generate test data  for version 0.1.0 and
API 1.  After the  test data  are generated,  check them  with another
source (the calendar  functions in Emacs, some  websites, some Android
apps). Please remember that the other sources do not care about sunset
(and sunrise for the civil Maya and Aztec calendars) and that you will
have to mentally shift the results before the comparison.

And after  the data are  checked, copy-paste  the lines into  the test
scripts     C<xt/10-conv-old.rakutest>,    C<xt/11-conv-new.rakutest>,
C<12-conv-aztec-old.rakutest> and C<13-conv-aztec-new.rakutest>.

In  the  C<rakutest> files  for  old  conversions, copy-and-paste  the
proper lines  into the C<@data-other> variable.  Then cut-and-past the
lines for the Gregorian dates  from this variable to the C<@data-greg>
variable  and add  the Gregorian date with the  'YYYY-MM-AA' format at
the end of each array line. There is no C<@data-maya> variable for the
Maya  and Aztec  dates,  because you  cannot  test simultaneously  C<<
D::C::Maya:ver<0.0.3>>> and C<<  D::C::Maya:ver<0.1.0>>>, or even test
C<< D::C::Maya:ver<0.0.3>>> with C<< D::C::Aztec:ver<0.1.0>>>.

In the C<rakutest>  files for new conversions fill  the C<@data> array
with the proper generated lines.

Remember  that you  need to  erase the  first comma  in each  chunk of
copied-pasted code.

Test data are generated only for the GMT and Caso conversions, not for
the Spinden, astronomical and Cortes variants.

All computed  dates are daylight  dates. So  it does not  matter which
version  and API  are  such  and such  classes.  Daylight dates  gives
exactly the  same results with version  0.1.0 / API 1  as with version
0.0.x / API 0.

=head1 AUTHOR

Jean Forget <J2N-FORGET at orange dot fr>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2024, 2025 Jean Forget, all rights reserved

This program is  free software; you can redistribute  it and/or modify
it under the Artistic License 2.0.

=end pod
