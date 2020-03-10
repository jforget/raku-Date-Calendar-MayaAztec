#!perl6
#
# checking the META6.json file
#

use v6;
use lib 'lib';

use Test;
use Test::META;

plan 1;

# That's it
meta-ok();


done-testing;
