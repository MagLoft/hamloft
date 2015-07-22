lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hamlet/version'

Gem::Specification.new do |s|
  s.name        = "hamlet"
  s.version     = Hamlet::VERSION
  s.licenses    = ["BSD-3-Clause"]
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tobias Strebitzer"]
  s.email       = ["tobias.strebitzer@magloft.com"]
  s.homepage    = "http://www.magloft.com"
  s.summary     = "Hamlet - MagLoft Widget Parser."
  s.description = "This gem contains template built parser for creating MagLoft theme templates."
  s.required_rubygems_version = '>= 2.4.7'
  s.add_runtime_dependency "bundler", "1.10.5"
  s.add_runtime_dependency 'haml', "4.0.6"
  s.add_runtime_dependency "activesupport", "4.2.3"
  s.add_runtime_dependency "nokogiri", "1.6.3.1"
  s.add_development_dependency "rspec", "3.3.0"
  s.add_development_dependency "pry", "0.10.1"
  s.add_development_dependency "rubocop", "0.32.1"
  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_path = 'lib'
end
