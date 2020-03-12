# -*- encoding: utf-8; indent-tabs-mode: nil -*-
use v6.c;

unit module Date::Calendar::Aztec::Names:ver<0.0.1>:auth<cpan:JFORGET>;

my @day-names = 'nah' => qw/
                           Cipactli      Ehecatl   Calli   Cuetzpalin Coatl
                           Miquizti      Mazatl    Tochtli Atl        Itzcuintli
                           Ozomahtli     Malinalli Acatl   Ocelot     Cuauhtli
                           Cozcacuauhtli Ollin     Tecpatl Quiahuitl  Xochitl
                           /
              , 'en'  => qw/
                           Crocodile     Wind      House   Lizard     Snake
                           Death         Deer      Rabbit  Water      Dog
                           Monkey        Grass     Reed    Jaguar     Eagle
                           Vulture       Movement  Flint   Rain       Flower
                           /
              , 'fr'  => qw/
                           Crocodile     Vent      Maison  Lézard     Serpent   
                           Mort          Cerf      Lapin   Eau        Chien     
                           Singe         Herbe     Roseau  Jaguar     Aigle     
                           Vautour       Mouvement Silex   Pluie      Fleur     
                           /;
my @month-names = 'nah' => (  "Izcalli"             
                           ,  "Atlcahualo"          
                           ,  "Tlacaxipehualiztli"  
                           ,  "Tozoztontli"         
                           ,  "Huei Tozoztli"       
                           ,  "Toxcatl"             
                           ,  "Etzalcualiztli"      
                           ,  "Tecuilhuitontli"     
                           ,  "Huei Tecuilhuitl"    
                           ,  "Tlaxochimaco"        
                           ,  "Xocotlhuetzi"        
                           ,  "Ochpaniztli"         
                           ,  "Teotleco"            
                           ,  "Tepeilhuitl"         
                           ,  "Quecholli"           
                           ,  "Panquetzaliztli"     
                           ,  "Atemoztli"           
                           ,  "Tititl"              
                           ,  "Nemontemi"           
                           )
                , 'en'  => (  "Sprout"          
                           ,  "Water left"      
                           ,  "Man flaying"     
                           ,  "1-vigil"         
                           ,  "2-vigil"         
                           ,  "Drought"         
                           ,  "Eating bean soup"
                           ,  "1-lords feast"   
                           ,  "2-lords feast"   
                           ,  "Give flowers"    
                           ,  "Fruit falls"     
                           ,  "Road sweeping"   
                           ,  "God arrives"     
                           ,  "Mountain feast"  
                           ,  "Macaw"           
                           ,  "Flag raising"    
                           ,  "Falling water"   
                           ,  "Storm"           
                           ,  "Full in vain"    
                           )
                , 'fr'  => (  "Croissance"
                           ,  "Arrêt de l'eau"              
                           ,  "Écorchement des hommes"      
                           ,  "Petite veille"               
                           ,  "Grande veille"               
                           ,  "Sécheresse"                  
                           ,  "Repas de maïs et haricots"   
                           ,  "Petite fête des dignitaires" 
                           ,  "Grande fête des dignitaires" 
                           ,  "Offrande de fleurs"          
                           ,  "Chute des fruits"              
                           ,  "Balayage des chemins"          
                           ,  "Retour des dieux"              
                           ,  "Fête des montagnes"            
                           ,  "Plume précieuse"               
                           ,  "Élévation des drapeaux"      
                           ,  "Descente de l'eau"             
                           ,  "Resserrement"                  
                           ,  "jour néfaste"
                           );

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

Date::Calendar::Aztec::Names - Names for the Aztec calendar

=head1 DESCRIPTION

Date::Calendar::Aztec::Names    is    a     companion    module    to
Date::Calendar::Aztec. It provides the day  names and the month names
for this calendar.

=head1 SOURCES

The nahuatl names come from L<https://www.azteccalendar.com/> and and
from   the  errata   of   Calendrical   Calculations  Third   Edition
(L<http://www.cs.tau.ac.il/~nachum/calendar-book/third-edition/>).

The English names come from L<https://en.wikipedia.org/wiki/Aztec_calendar>
and from the errata of Calendrical Calculations Third Edition
(L<http://www.cs.tau.ac.il/~nachum/calendar-book/third-edition/>).

The French names come from L<https://icalendrier.fr/calendriers-saga/calendriers/azteque/>
and L<https://fr.m.wikipedia.org/wiki/Calendrier_azt%C3%A8que>.

=head1 AUTHOR

Jean Forget <JFORGET@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright © 2020 Jean Forget

This library is  free software; you can redistribute  it and/or modify
it under the Artistic License 2.0.

=end pod


