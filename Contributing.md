-*- encoding: utf-8; indent-tabs-mode: nil -*-

Simple Contributions
====================

Please report any problem, bug, typo, feature request or remark to the
Github repository at
[https://github.com/jforget/raku-Date-Calendar-MayaAztec]  and  create
an issue.

Or you can send me an e-mail  at `J2N-FORGET at orange dot fr`, with a
subject  containing  the  name  of  the module  or  the  name  of  the
repository, so my spam filter will accept this mail.

Advanced Documentation
======================

If you  want to make advanced  contributions, may be you  should first
read the "Designer's notes" in
[https://github.com/jforget/raku-Date-Calendar-FrenchRevolutionary/doc/notes-en.md|https://github.com/jforget/raku-Date-Calendar-FrenchRevolutionary/blob/master/doc/notes-en.md]
(or its French translation in
[https://github.com/jforget/raku-Date-Calendar-FrenchRevolutionary/doc/notes-fr.md|https://github.com/jforget/raku-Date-Calendar-FrenchRevolutionary/blob/master/doc/notes-fr.md]),
to  better grasp  the architecture  of the  modules. These  designer's
notes apply  to all  `Date::Calendar::xxx` modules,  not only  for the
French Revolutionary one.

Advanced Contributions
======================

If you want to  send me a real pull request,  including some code, you
should  test  your  modifications  with  both the  `t`  and  the  `xt`
repositories. This requires a  special development environment, beyond
this Git repository.

First, you need to install with `zef` the prerequisites for all
`Date::Calendar::xxx` modules and not only for
`Date::Calendar::MayaAztec`:

* `Date::Calendar::Strftime` version 0.1.0 or later
* `Date::Names`
* `List::MoreUtils`

Then you must clone all `Date::Calendar::xxx` repositories in the same
directory as `Date::Calendar::MayaAztec`:

* raku-Date-Calendar-Gregorian
* raku-Date-Calendar-Julian
* raku-Date-Calendar-Hebrew
* raku-Date-Calendar-CopticEthiopic
* raku-Date-Calendar-Persian
* raku-Date-Calendar-Bahai
* raku-Date-Calendar-MayaAztec
* raku-Date-Calendar-FrenchRevolutionary

Then you must pseudo-install all these modules in two utility directories.
For this, from the `raku-Date-Calendar-MayaAztec` directory, run:

```
  util/mk-cal-tests
```

This creates two directories:

`version-old` which contains all `Date::Calendar::xxx` modules with the latest `0.0.x` version and api 0,

`version-new` which contains all `Date::Calendar::xxx` modules with api 1 and with the latest `0.1.x` version, possibly an unreleased version under development.

And now, you can run

```
  prove6 -I. t xt
```

If you  work on two  `Date::Calendar::xxx` modules in parallel,  or if
you pull a newer version of a `raku-Date-Calendar-xxx` repository, you
should refresh the `version-new` directory by running again:

```
  util/mk-cal-tests
```

Even if you are not sure how such or such calendar module should work,
you need  to clone _all_  repositories and you need  to pseudo-install
_all_ calendar modules, in order to run the `xt` test scripts.
