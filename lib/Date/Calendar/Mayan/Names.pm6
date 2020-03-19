# -*- encoding: utf-8; indent-tabs-mode: nil -*-
use v6.c;

unit module Date::Calendar::Mayan::Names:ver<0.0.1>:auth<cpan:JFORGET>;

#my %day-names = 'nah' => qw/
#                           /
#              , 'en'  => qw/
#                           /
#              , 'fr'  => qw/
#                           /;
#my %month-names = 'nah' => (
#                           )
#                , 'en'  => (
#                           )
#                , 'fr'  => (
#                           );
#
#our sub allowed-locale(Str:D $locale) {
#  %month-names{$locale}:exists;
#}
#
#our sub month-name(Str:D $locale, Int:D $month --> Str) {
#  %month-names{$locale}[$month - 1];
#}
#
#our sub day-name(Str:D $locale, Int:D $index --> Str) {
#  %day-names{$locale}[$index - 1];
#}

=begin pod

=head1 NAME

Date::Calendar::Mayan::Names - Names for the Mayan calendar

=head1 DESCRIPTION

Date::Calendar::Mayan::Names    is    a     companion    module    to
Date::Calendar::Mayan. It provides the day  names and the month names
for this calendar.

=head1 SOURCES

The  Mayan names  come  from Calendrical  Calculations Third  Edition
(L<http://www.cs.tau.ac.il/~nachum/calendar-book/third-edition/>).

The  English  names  come   Calendrical  Calculations  Third  Edition
(L<http://www.cs.tau.ac.il/~nachum/calendar-book/third-edition/>).

The French names come from L<https://icalendrier.fr/calendriers-saga/calendriers/maya/>

=head1 AUTHOR

Jean Forget <JFORGET@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright © 2020 Jean Forget

This library is  free software; you can redistribute  it and/or modify
it under the Artistic License 2.0.

=end pod


