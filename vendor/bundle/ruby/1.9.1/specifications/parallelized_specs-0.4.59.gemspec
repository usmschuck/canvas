# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "parallelized_specs"
  s.version = "0.4.59"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jake Sorce, Bryan Madsen, Shawn Meredith"]
  s.date = "2013-06-11"
  s.email = "jake@instructure.com"
  s.homepage = "http://github.com/jakesorce/parallelized_specs"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "Run rspec tests in parallel"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<parallel>, [">= 0"])
    else
      s.add_dependency(%q<parallel>, [">= 0"])
    end
  else
    s.add_dependency(%q<parallel>, [">= 0"])
  end
end
