# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'ipizza/version'

Gem::Specification.new do |s|
  s.name        = 'ipizza'
  s.version     = Ipizza::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Priit Haamer', 'Tanel Jakobsoo']
  s.email       = ['priit@voog.com', 'tanel@voog.com']
  s.homepage    = 'https://github.com/Voog/ipizza'
  s.summary     = 'Implements iPizza protocol to communicate with Estonian Banks'
  s.description = 'Simplifies generating payment requests and parsing responses from banks when using iPizza protocol.'
  
  s.add_development_dependency 'rspec', '~> 2.9.0'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'rb-fsevent'
  s.add_development_dependency 'rake'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end
