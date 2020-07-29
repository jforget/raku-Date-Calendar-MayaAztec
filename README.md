NAME
====

Date::Calendar::MayaAztec - conversions from / to the Maya calendar and from / to the Aztec calendar

SYNOPSIS
========

When was the last time the end of the universe happened?

```perl6
use Date::Calendar::Maya;
my Date::Calendar::Maya
        $d-maya  .= new(long-count => '13.0.0.0.0');
my Date $d-greg   = $d-maya.to-date('Date');
say $d-greg;
# --> 2012-12-21 (for 21st December 2012)
```

The Perl  and Raku conference in  North America was scheduled  to take
place  in Houston,  starting  on 2020-06-20.  What  does the  southern
neighbours call this date?

```perl6
use Date::Calendar::Maya;
use Date::Calendar::Aztec;
my Date                  $d-greg  .= new(2020, 6, 20);
my Date::Calendar::Aztec $d-aztec .= new-from-date($d-greg);
my Date::Calendar::Maya  $d-maya  .= new-from-date($d-greg);

say "{.tzolkin} {.haab} {.long-count}" with $d-maya;
# --> 12 Etznab 1 Tzec 13.0.7.10.18
$d-maya.locale = 'en';
say "{.tzolkin} {.haab}" with $d-maya;
# --> 12 Flint 1 Skull

say "{.tonalpohualli} {.xiuhpohualli}" with $d-aztec;
# --> 12 Tecpatl 20 Teotleco
$d-aztec.locale = 'en';
say "{.tonalpohualli} {.xiuhpohualli}" with $d-aztec;
# --> 12 Flint 20 God arrives
```

DESCRIPTION
===========

Date::Calendar::MayaAztec  is a  distribution with  two main  classes,
Date::Calendar::Maya implementing the Maya calendars (long count, Haab
and   Tzolkin)  and   Date::Calendar::Aztec  implementing   the  Aztec
calendars (tonalpohualli and xiuhpohualli).

INSTALLATION
============

```shell
zef install Date::Calendar::MayaAztec
```

or

```shell
git clone https://github.com/jforget/raku-Date-Calendar-MayaAztec.git
cd raku-Date-Calendar-MayaAztec
zef install .
```

AUTHOR
======

Jean Forget <JFORGET@cpan.org>

COPYRIGHT AND LICENSE
=====================

Copyright © 2020 Jean Forget

This library is  free software; you can redistribute  it and/or modify
it under the Artistic License 2.0.

