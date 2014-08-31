# SweetLogger

This little gem fixes the messed up log entries issue in Rails when it's run
in a multi-threaded environment (for example without the `Rack::Lock` middleware)

Basically it doesn't let the log entries to overlap when you have several parallel
requests handled by rails in different threads.

Also it solves the problem of filtering particular log entries out (for example
`/assets/*`) when rails runs in multiple threads without the requests lock.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sweet-logger'
```

Enjoy!

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
