# Fake Rails 3 Routes

This gem adapts the Rails 3 routing code to generate Rails 2.3 routes on
the back-end, so that you can upgrade your Rails 2 routes to Rails 3
format before your app is completely on Rails 3.

Why? If you have a Rails 2 application of significant size, and a whole
group of programmers actively developing it, then "stopping the world"
to upgrade to Rails 3 isn't really an option. Doing it on a dedicated
branch isn't really any better, you run into the same issues with
diverging codebases. This gem is one component of the infrastructure
necessary to upgrade your app "live" one piece at a time.

## Not supported

This has only been tested with fairly basic routes. Don't try anything
too fancy, its behavior will diverge from Rails 3 routing behavior in
some more advanced cases. Some known unsupported functionality:

* Mounting Rack apps at a path with #mount

## Installation

Add this line to your application's Gemfile:

    gem 'fake_rails3_routes'

If your Rails 2.3 application doesn't yet use a Gemfile, do that upgrade
first.

Then use the rails_upgrade gem (https://github.com/rails/rails_upgrade)
to upgrade your routes file to Rails 3 format. Replace the first line
with:

```ruby
FakeRails3Routes.draw do
```

### Concerns

This gem includes a backport of the `concerns` routing concept from
Rails 4. If you want to use concerns in Rails 3, just include the
`routing_concerns` (https://github.com/rails/routing_concerns) gem in your Gemfile.

## Copyright

The vast majority of this gem is extracted directly from Rails 3,
licensed under the MIT license. The modifications are released under
this same license.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
