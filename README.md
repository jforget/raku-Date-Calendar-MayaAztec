NAME
====

Date::Calendar::MayanAztec - conversions from/to the Mayan calendar and conversions to the Aztec calendar

SYNOPSIS
========

When was the last time the end of the universe happened?

```perl6
use Date::Calendar::Mayan;
my Date::Calendar::Mayan $d-mayan .= new('13.0.0.0.0');
my Date                  $d-greg = $d-mayan.to-date('Date');
say $d-greg;
# --> 2012-12-21 for 21st December 2012
```

The  Perl and  Raku conference  in North  America will  take place  in
Houston, starting on 2020-06-20. What does the southern neigbours call
this date?

```perl6
use Date::Calendar::Mayan;
use Date::Calendar::Aztec;
my Date                  $d-greg  .= new(2020, 6, 20);
my Date::Calendar::Aztec $d-aztec .= new-from-date($d-greg);
my Date::Calendar::Mayan $d-mayan .= new-from-date($d-greg);

say "{.tonalpohualli} {.xiuhpohualli}" with $d-aztec;
# --> 12 Tecpatl 20 Teotleco
$d-aztec.locale = 'en';
say "{.tonalpohualli} {.xiuhpohualli}" with $d-aztec;
# --> 12 Flint 20 God arrives

say "{.tzolkin} {.haab"}" with $d-mayan;
# --> 12 Etznab 1 Tzec
$d-mayan.locale = 'en';
say "{.tzolkin} {.haab"}" with $d-mayan;
# --> 12 Flint 1 Skull
```


DESCRIPTION
===========

Date::Calendar::MayanAztec is  a distribution  with two  main classes,
Date::Calendar::Mayan  implementing the  Mayan calendars  (long count,
Haab  and Tzolkin)  and Date::Calendar::Aztec  implementing the  Aztec
calendars (tonalpohualli and xiuhpohualli).

AUTHOR
======

Jean Forget <JFORGET@cpan.org>

COPYRIGHT AND LICENSE
=====================

Copyright © 2020 Jean Forget

This library is  free software; you can redistribute  it and/or modify
it under the Artistic License 2.0.

