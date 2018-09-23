# Warner

[![Gem Version](https://badge.fury.io/rb/warner.svg)](https://badge.fury.io/rb/warner) [![Codeship Status for LeipeLeon/warner](https://app.codeship.com/projects/951314e0-806a-0135-5d58-6a64ad6118ad/status?branch=master)](https://app.codeship.com/projects/246699)

Annotate your code w/ custom deprecation warnings to the `$stderr` when a newer version of a gem or rails is installed.


Especially useful for a controlled (rails) monkeypatching workflow:

Say you found a bug in a gem and waiting for a new release wil ltake to long.
Add a monkeypatch in `app/monkeypatches/` (e.g. `app/monkeypatches/bootstrap_form.rb` and maybe write a spec for it.)
When you update the flawed gem, `Warner` will check the supplied version against the installed version and will put out a deprecation warning (w/ `ActiveSupport::Deprecation`) so you can act upon it.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'warner'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install warner

## Usage

```ruby
# app/monkeypatches/bootstrap_form.rb
Warner.gem_version_warning('bootstrap_form', "1.2", "upgrade to latest version")
Warner.rails_version_warning("5.0", "Remove this monkeypatch b/c it's fixed in 5.1 (see issue #99999)")
Warner.colored_warning("Somebody look at this piece of code please!")
```

will output:

```log
DEPRECATION WARNING: [gem:bootstrap_form] 2.7.0 > 1.2 : upgrade to latest version (called from <top (required)> at /Users/berl/Clients/bwh/core/app/monkeypatches/bootstrap_form.rb:1)
DEPRECATION WARNING: [RAILS] 5.1.6 > 5.0 : Remove this monkeypatch b/c it's fixed in 5.1 (see issue #99999) (called from <top (required)> at /Users/berl/Clients/bwh/core/app/monkeypatches/bootstrap_form.rb:2)
DEPRECATION WARNING: Somebody look at this piece of code please! (called from <top (required)> at /Users/berl/Clients/bwh/core/app/monkeypatches/bootstrap_form.rb:3)
```

## Bonus material: make deprecations stand out in the logfile

```ruby
# config/environments/development.rb
config.active_support.deprecation = -> (message, callstack) {
  $stderr.puts "\e[41;37;1m#{message}\e[0m"
}
```

## Development

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/LeipeLeon/warner. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Warner project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/LeipeLeon/warner/blob/master/CODE_OF_CONDUCT.md).
