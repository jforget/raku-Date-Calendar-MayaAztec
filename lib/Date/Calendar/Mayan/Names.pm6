# -*- encoding: utf-8; indent-tabs-mode: nil -*-
use v6.c;

unit module Date::Calendar::Mayan::Names:ver<0.0.1>:auth<cpan:JFORGET>;

my %day-names = 'yua' => qw/ Imix      Ik    Akbal  Kan    Chicchan
                             Cimi      Manik Lamat  Muluc  Oc     
                             Chuen     Eb    Ben    Ix     Men    
                             Cib       Caban Etznab Cauac  Ahau   
                            /
               , 'en' => qw/ Alligator Wind  Night  Iguana Serpent  
                             Death     Deer  Rabbit Rain   Foot     
                             Monkey    Tooth Cane   Jaguar Eagle    
                             Owl       Quake Flint  Storm  Lord     
                            /
               , 'fr'  => ( "Crocodile"
                          , "Vent"                    
                          , "Maison"
                          , "Lézard"
                          , "Serpent"
                          , "Mort"
                          , "Chevreuil"
                          , "Lapin"
                          , "Eau"
                          , "Chien"
                          , "Singe"
                          , "Herbe"
                          , "Roseau"
                          , "Jaguar"
                          , "Aigle"
                          , "Vautour"
                          , "Mouvement"
                          , "Couteau de silex"
                          , "Pluie"
                          , "Fleur"
                          );
my %month-names = 'yua' => qw/ Pop    Uo     Zip  Zotz Tzec  Xul    
                               Yaskin Mol    Chen Yax  Zac   Ceh    
                               Mac    Kankin Muan Pax  Kayab Cumku  
                               Uayeb  
                            /
                 , 'en'  => ( "Mat"                      
                            , "Frog"
                            , "Stag"
                            , "Bat"
                            , "Skull"
                            , "End"
                            , "Green time"
                            , "Gather"
                            , "Well"
                            , "Green"
                            , "White"
                            , "Deer"
                            , "Cover"
                            , "Yellow time"
                            , "Owl"
                            , "Drum"
                            , "Turtle"
                            , "Dark god"
                            , "void"
                           )
                 , 'fr' => qw/ Pop    Uo     Zip  Zotz Tzec  Xul    
                               Yaskin Mol    Chen Yax  Zac   Ceh    
                               Mac    Kankin Muan Pax  Kayab Cumku  
                               Uayeb  
                            /;

our sub allowed-locale(Str:D $locale) {
  %month-names{$locale}:exists;
}

our sub month-name(Str:D $locale, Int:D $month --> Str) {
  %month-names{$locale}[$month - 1];
}

our sub day-name(Str:D $locale, Int:D $index --> Str) {
  %day-names{$locale}[$index - 1];
}

=begin pod

=head1 NAME

Date::Calendar::Mayan::Names - Names for the Mayan calendar

=head1 DESCRIPTION

Date::Calendar::Mayan::Names    is    a     companion    module    to
Date::Calendar::Mayan. It provides the day  names and the month names
for this calendar.

=head1 ISSUES

Most sources about the Mayan calendar give  a list of Haab names and a
list of Tzolkin names, usually  without specifying which precise Mayan
language  they use.  A footnote  in Calendrical  Calculations mentions
that names are translitterated from  the Yucatec language. This is why
I have adopted these names (and their English translations).

On the other hand, for the  French language, I have found translations
only for Tzolkin names. So the Haab names are left untranslated.

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


