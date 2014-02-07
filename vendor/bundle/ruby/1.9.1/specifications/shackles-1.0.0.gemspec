# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "shackles"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Cody Cutrer"]
  s.date = "2013-04-09"
  s.description = "Allows multiple environments in database.yml, and dynamically switching them."
  s.email = "cody@instructure.com"
  s.homepage = "http://github.com/instructure/shackles"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "ActiveRecord database environment switching for slaves and least-privilege"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 2.3"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<rspec-core>, ["~> 2.13"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
    else
      s.add_dependency(%q<activerecord>, [">= 2.3"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<rspec-core>, ["~> 2.13"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 2.3"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<rspec-core>, ["~> 2.13"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
  end
end
