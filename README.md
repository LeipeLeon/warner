# Warner

[![Gem Version](https://badge.fury.io/rb/warner.svg)](https://badge.fury.io/rb/warner) [![Codeship Status for LeipeLeon/warner](https://app.codeship.com/projects/951314e0-806a-0135-5d58-6a64ad6118ad/status?branch=master)](https://app.codeship.com/projects/246699)
Display warnings w/ a red color to the `$stderr` when a newer version of rails or a gem is installed

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

### `Warner.gem_version_warning`

Display a message when specified is updated and needs a change
e.g. when monkeypatching a gem: put the code into the monkey patch

```ruby
# app/monkeypatches/bootstrap_form.rb
Warner.gem_version_warning('bootstrap_form', "1.2", "REMOVE monkeypatches/bootstrap_form: upgrade to latest version")

module BootstrapForm
  ...
end
```

will output

```shell
\e[41;37;1mDEPRECATION WARNING: [gem:bootstrap_form] 2.7.0 > 1.2 : REMOVE monkeypatches/bootstrap_form: upgrade to latest version (called from <class:HTTP> at /Users/berl/Clients/bwh/core/config/initializers/fix_ssl.rb:11\e[0m
```


### `Warner.rails_version_warning`

Display a message when rails is updated and needs a change
e.g. when monkeypatching a gem put the code into the monkey patch

```ruby
# app/monkeypatches/bootstrap_form.rb
Warner.rails_version_warning("3.2", "REMOVE monkeypatches/bootstrap_form: upgrade to latest version")

module BootstrapForm
  ...
end
```

will output

```shell
\e[41;37;1mDEPRECATION WARNING: [RAILS] 5.1.6 > 3.2 : REMOVE monkeypatches/bootstrap_form: upgrade to latest version (called from <class:HTTP> at /Users/berl/Clients/bwh/core/config/initializers/fix_ssl.rb:10)\e[0m
```

```ruby
# app/mailers/my_mailer.rb
class MyMailer < ActionMailer::Base

  Warner.rails_version_warning("3.2", "REMOVE: MyMailer#default_i18n_subject is a copy of 4.0 implementations")

  def default_i18n_subject(interpolations = {})
    ...
  end

end
```

will output

```shell
\e[41;37;1m[RAILS] 4.0.0 > 3.2 : REMOVE: MyMailer#default_i18n_subject is a copy of 4.0 implementations\e[0m
```


## Development

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/LeipeLeon/warner. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Warner project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/LeipeLeon/warner/blob/master/CODE_OF_CONDUCT.md).
