#
# Checking the checks
#
use v6.c;
use Test;
use Date::Calendar::Maya;
use Date::Calendar::Aztec;

plan 36;

my  Date::Calendar::Maya  $dt-m;
my  Date::Calendar::Aztec $dt-a;
my  Date  $dt-ref .= new('2020-07-01');

dies-ok(  { $dt-m .= new(long-count => '13.0.0.0'    ); }, "Incomplete long count");
dies-ok(  { $dt-m .= new(long-count => '13.0.0.0.0.0'); }, "Long count is too long");
dies-ok(  { $dt-m .= new(long-count => '23.0.0.0.0',  locale => 'en'); }, "Wrong baktun");
dies-ok(  { $dt-m .= new(long-count => '13.0.0.19.0', locale => 'en'); }, "Wrong uinal");
dies-ok(  { $dt-m .= new(long-count => '13.0.0.1.20', locale => 'en'); }, "Wrong tun");
dies-ok(  { $dt-m .= new(long-count => '13.0.0.1.1a', locale => 'en'); }, "Wrong tun");
dies-ok(  { $dt-m .= new(long-count => '13.0.0.0.0',  locale => 'xx'); }, "Bad locale");
lives-ok( { $dt-m .= new(long-count => '13.0.0.0.0',  locale => 'en'); }, "Good locale");
dies-ok(  { $dt-m .= new(month => 20, day => 18, clerical-number =>  7, clerical-index => 15); }, "Maya calendar round: Wrong month");
dies-ok(  { $dt-m .= new(month =>  0, day => 18, clerical-number =>  7, clerical-index => 15); }, "Maya calendar round: Wrong month");
dies-ok(  { $dt-m .= new(month =>  9, day => -1, clerical-number =>  7, clerical-index => 15); }, "Maya calendar round: Wrong day");
dies-ok(  { $dt-m .= new(month =>  9, day => 20, clerical-number =>  7, clerical-index => 15); }, "Maya calendar round: Wrong day");
dies-ok(  { $dt-m .= new(month =>  9, day => 18, clerical-number =>  0, clerical-index => 15); }, "Maya calendar round: Wrong clerical number");
dies-ok(  { $dt-m .= new(month =>  9, day => 18, clerical-number => 14, clerical-index => 15); }, "Maya calendar round: Wrong clerical number");
dies-ok(  { $dt-m .= new(month =>  9, day => 18, clerical-number =>  7, clerical-index =>  0); }, "Maya calendar round: Wrong clerical index");
dies-ok(  { $dt-m .= new(month =>  9, day => 18, clerical-number =>  7, clerical-index => 21); }, "Maya calendar round: Wrong clerical index");
dies-ok(  { $dt-m .= new(month =>  9, day => 18, clerical-number =>  7, clerical-index => 16); }, "Maya calendar round: clerical index incompatible with day number");
lives-ok( { $dt-m .= new(month =>  9, day => 18, clerical-number =>  7, clerical-index => 15); }, "Maya calendar round: fine");

dies-ok(  { $dt-a .= new(month => 20, day => 17, clerical-number =>  7, clerical-index => 15); }, "Aztec: Wrong month");
dies-ok(  { $dt-a .= new(month =>  0, day => 17, clerical-number =>  7, clerical-index => 15); }, "Aztec: Wrong month");
dies-ok(  { $dt-a .= new(month =>  9, day =>  0, clerical-number =>  7, clerical-index => 15); }, "Aztec: Wrong day");
dies-ok(  { $dt-a .= new(month =>  9, day => 21, clerical-number =>  7, clerical-index => 15); }, "Aztec: Wrong day");
dies-ok(  { $dt-a .= new(month =>  9, day => 17, clerical-number =>  0, clerical-index => 15); }, "Aztec: Wrong clerical number");
dies-ok(  { $dt-a .= new(month =>  9, day => 17, clerical-number => 14, clerical-index => 15); }, "Aztec: Wrong clerical number");
dies-ok(  { $dt-a .= new(month =>  9, day => 17, clerical-number =>  7, clerical-index =>  0); }, "Aztec: Wrong clerical index");
dies-ok(  { $dt-a .= new(month =>  9, day => 17, clerical-number =>  7, clerical-index => 21); }, "Aztec: Wrong clerical index");
dies-ok(  { $dt-a .= new(month =>  9, day => 17, clerical-number =>  7, clerical-index => 16); }, "Aztec: clerical index incompatible with day number");
lives-ok( { $dt-a .= new(month =>  9, day => 17, clerical-number =>  7, clerical-index => 15); }, "Aztec: fine");
lives-ok( { $dt-a .= new(month =>  9, day => 17, clerical-number =>  7, clerical-index => 15,
                                                                      on-or-after => $dt-ref); }, "Aztec: one reference date, fine");
lives-ok( { $dt-a .= new(month =>  9, day => 17, clerical-number =>  7, clerical-index => 15,
                                                                     on-or-before => $dt-ref); }, "Aztec: one reference date, fine");
lives-ok( { $dt-a .= new(month =>  9, day => 17, clerical-number =>  7, clerical-index => 15,
                                                                      after       => $dt-ref); }, "Aztec: one reference date, fine");
lives-ok( { $dt-a .= new(month =>  9, day => 17, clerical-number =>  7, clerical-index => 15,
                                                                     before       => $dt-ref); }, "Aztec: one reference date, fine");
lives-ok( { $dt-a .= new(month =>  9, day => 17, clerical-number =>  7, clerical-index => 15,
                                                                     nearset      => $dt-ref); }, "Aztec: one reference date, fine");
dies-ok(  { $dt-a .= new(month =>  9, day => 17, clerical-number =>  7, clerical-index => 15,
                                             on-or-after => $dt-ref, on-or-before => $dt-ref); }, "Aztec: several reference dates, wrong");
dies-ok(  { $dt-a .= new(month =>  9, day => 17, clerical-number =>  7, clerical-index => 15,
                                after => $dt-ref, before => $dt-ref, nearset      => $dt-ref); }, "Aztec: several reference dates, wrong");
dies-ok(  { $dt-a .= new(month =>  9, day => 17, clerical-number =>  7, clerical-index => 15,
                                                                 on-or-after => '2001-01-01'); }, "Aztec: improper reference date");
