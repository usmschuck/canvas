# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "instructure-marginalia"
  s.version = "1.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Noah Lorang", "Nick Quaranto", "Taylor Weibley"]
  s.date = "2013-04-08"
  s.email = ["noah@37signals.com"]
  s.homepage = "https://github.com/37signals/marginalia"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "Attach comments to your ActiveRecord queries."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>, ["< 3.3", ">= 2.3"])
      s.add_runtime_dependency(%q<activerecord>, ["< 3.3", ">= 2.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<mysql>, [">= 0"])
      s.add_development_dependency(%q<mysql2>, [">= 0"])
      s.add_development_dependency(%q<pg>, [">= 0"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
    else
      s.add_dependency(%q<actionpack>, ["< 3.3", ">= 2.3"])
      s.add_dependency(%q<activerecord>, ["< 3.3", ">= 2.3"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<mysql>, [">= 0"])
      s.add_dependency(%q<mysql2>, [">= 0"])
      s.add_dependency(%q<pg>, [">= 0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
    end
  else
    s.add_dependency(%q<actionpack>, ["< 3.3", ">= 2.3"])
    s.add_dependency(%q<activerecord>, ["< 3.3", ">= 2.3"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<mysql>, [">= 0"])
    s.add_dependency(%q<mysql2>, [">= 0"])
    s.add_dependency(%q<pg>, [">= 0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
  end
end
