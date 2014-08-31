# coding: utf-8
require_relative './lib/sweet_logger/version'

Gem::Specification.new do |spec|
  spec.name          = "sweet-logger"
  spec.version       = SweetLogger::VERSION
  spec.authors       = ["Nikolay Nemshilov"]
  spec.email         = ["nemshilov@gmail.com"]
  spec.summary       = %q{Betterer Rails logger that handles multi-threading}
  spec.description   = %q{Betterer Rails logger that handles multi-threading well}
  spec.homepage      = "https://github.com/MadRabbit/sweet-logger"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

end
