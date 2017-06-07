lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hamloft/version'

Gem::Specification.new do |s|
  s.name        = "hamloft"
  s.version     = Hamloft::VERSION
  s.licenses    = ["BSD-3-Clause"]
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tobias Strebitzer"]
  s.email       = ["tobias.strebitzer@magloft.com"]
  s.homepage    = "http://www.magloft.com"
  s.summary     = "Hamloft - MagLoft Widget Parser."
  s.description = "This gem contains template built parser for creating MagLoft theme templates."
  s.add_runtime_dependency 'haml', "~> 5.0"
  s.add_runtime_dependency "nokogiri", "~> 1.8"
  s.add_development_dependency "rspec", "~> 3.6"
  s.add_development_dependency "pry", "~> 0.10"
  s.add_development_dependency "rubocop", "~> 0.49"
  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_path = 'lib'
end
