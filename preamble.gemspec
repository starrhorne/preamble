# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "preamble/version"

Gem::Specification.new do |s|
  s.name        = "preamble"
  s.version     = Preamble::VERSION
  s.authors     = ["Starr Horne"]
  s.email       = ["starr@chromahq.com"]
  s.homepage    = "https://github.com/starrhorne/preamble"
  s.summary     = %q{Use yaml preambles in your documents & templates}
  s.description = %q{Allows you to add YAML front matter to your templates. Useful for adding metadata to static pages}

  s.rubyforge_project = "preamble"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
