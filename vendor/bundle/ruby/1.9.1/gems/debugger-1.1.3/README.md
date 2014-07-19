## Description
A fork of ruby-debug(19) that works on 1.9.2 and 1.9.3 and installs easily for rvm/rbenv rubies.

[![Build Status](https://secure.travis-ci.org/cldwalker/debugger.png?branch=master)](http://travis-ci.org/cldwalker/debugger)

## Install

    $ gem install debugger

    # If install fails, try passing headers path
    $ gem install debugger -- --with-ruby-include=PATH_TO_HEADERS

For Windows install instructions, see OLD\_README.


## Supported Rubies
On install, debugger tries to find your ruby's headers. If it's unable to find them and your ruby is a patch release,
it will use headers included with [debugger-ruby_core_source](https://github.com/cldwalker/debugger-ruby_core_source).
For the list of rubies supported by debugger [see here](https://github.com/cldwalker/debugger-ruby_core_source/tree/master/lib/debugger/ruby_core_source).
*If your ruby is not a patch release i.e. head, dev or an rc, you are responsible for having headers and setting them with --with-ruby-include.*

## Usage

Wherever you need a debugger, simply:

```ruby
require 'debugger'; debugger
```

To use with bundler, drop in your Gemfile:

    gem 'debugger'

## Reason for Fork

* ruby-debug19 maintainer isn't maintaining:
  * Despite patches from ruby core, no gem release in 2+ years! - 9/1/09.
  * Requests to release a known working 1.9.3 version have been ignored.
  * Doesn't respond to rubyforge issues and doesn't have github issues open.
* Current install is painful. Requires either [manually downloading gems from rubyforge](
  http://blog.wyeworks.com/2011/11/1/ruby-1-9-3-and-ruby-debug) and installing with compiler flags
  or [recompiling
  ruby](http://blog.sj26.com/post/12146951658/updated-using-ruby-debug-on-ruby-1-9-3-p0).
* We need a decent ruby debugger for future rubies!

## What's different from ruby-debug19

* Major
  * Works on 1.9.2 and 1.9.3
    * 1.9.2 points to ruby-debug-base19-0.11.25 headers
    * 1.9.3 points to ruby-debug-base19-0.11.26 headers
  * Install painlessly for rvm and rbenv rubies i.e. no compiler flags needed
  * No downloading ruby source during install - was behavior of old ruby_core_source dependency
  * Fix LocalJumpError caused by using proc in extconf.rb
  * Fix where command failing at top level
  * Passing tests are up on travis-ci
* Minor
  * The gem name matches the module namespace, Debugger, and main required file, debugger.
  * ruby-debug-base19 and ruby-debug19 are released as one gem
  * Rake tasks have been updated
  * No more $LOAD_PATH manipulation or runtime code outside of lib
  * man page available via gem-man

## Issues
Please report them [on github](http://github.com/cldwalker/debugger/issues).

## Contributing
[See here](http://tagaholic.me/contributing.html) for contribution policies.
Let's keep this working for the ruby community!

## Credits

* Thanks to the original authors: Kent Sibilev and Mark Moseley
* Contributors: ericpromislow, jnimety, adammck
* Fork started on awesome @relevance fridays!

## TODO

* Fix test/test-*.rb
* Work with others willing to tackle jruby, rubinius or windows support
