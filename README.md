# SweetLogger

This little gem solves two issues with rails `ActiveSuppot::Logger` when it's
running in a multi-threaded environment.

1. It doesn't let log entries for concurrent requests overlap
2. Adds a log silencer (for `/assets/`) that works correctly with multiple threads

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sweet-logger'
```

Enjoy!

## Rack::Lock

By default in the `development` environment, Rails adds the `Rack::Lock` middleware
so that the rack server will process only one request at a time.

If you need to enable the real multi-threaded processing in the development
environment, add this to your `config/application.rb`

```ruby
  config.middleware.delete Rack::Lock
```


## Silencer

Our sweet logger comes with a silencer in case you need to remove some of the
entries from leaking into the logs. By default it silences the `/assets/` entries.
But if you need to silence anything else, add this to one of your rails initializers

```ruby
SweetLogger.silence %w[
  favicon.io
  livereload.js
  /something/else
]
```

__NOTE__: logger will check if the route _included_ in the current request's path.


## Contributing

1. Fork it ( https://github.com/MadRabbit/sweet-logger/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
