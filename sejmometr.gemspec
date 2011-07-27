# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "sejmometr"
  s.version = "0.0.4"
  s.platform = Gem::Platform::RUBY
  s.authors = ["Michał Ostrowski"]
  s.email = ["ostrowski.michal@gmail.com"]
  s.summary = %q{Ruby API for sejmometr.pl}
  s.description = %q{Ruby API for sejmometr.pl. Take a look at README for more information.}

  s.files = `git ls-files`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency("bundler", ["~> 1.0"])
end
