# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ipizza/version"

Gem::Specification.new do |s|
  s.name        = "ipizza"
  s.version     = Ipizza::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Priit Haamer"]
  s.email       = ["priit@fraktal.ee"]
  s.homepage    = "http://github.com/priithaamer/ipizza"
  s.summary     = %q{Implements iPizza protocol to communicate with Estonian Banks}
  s.description = %q{Simplifies generating payment requests and parsing responses from banks when using iPizza protocol.}
  
  s.add_development_dependency "rspec"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
