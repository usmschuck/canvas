# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "instructure-redis-store"
  s.version = "1.0.0.2.instructure1"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Luca Guidi", "Brian Palmer"]
  s.date = "2012-11-13"
  s.description = "Namespaced Rack::Session, Rack::Cache, I18n and cache Redis stores for Ruby web frameworks."
  s.email = "brianp@instructure.com"
  s.extra_rdoc_files = ["README.md"]
  s.files = ["README.md"]
  s.homepage = "http://github.com/instructure/redis-store"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "Namespaced Rack::Session, Rack::Cache, I18n and cache Redis stores for Ruby web frameworks."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<redis>, ["= 3.0.1"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<git>, [">= 0"])
      s.add_development_dependency(%q<rack-cache>, [">= 0"])
      s.add_development_dependency(%q<merb>, ["= 1.1.0"])
      s.add_development_dependency(%q<rspec>, ["= 1.3.0"])
      s.add_development_dependency(%q<i18n>, [">= 0"])
      s.add_development_dependency(%q<methopara>, [">= 0"])
      s.add_runtime_dependency(%q<redis>, ["= 3.0.1"])
    else
      s.add_dependency(%q<redis>, ["= 3.0.1"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<git>, [">= 0"])
      s.add_dependency(%q<rack-cache>, [">= 0"])
      s.add_dependency(%q<merb>, ["= 1.1.0"])
      s.add_dependency(%q<rspec>, ["= 1.3.0"])
      s.add_dependency(%q<i18n>, [">= 0"])
      s.add_dependency(%q<methopara>, [">= 0"])
      s.add_dependency(%q<redis>, ["= 3.0.1"])
    end
  else
    s.add_dependency(%q<redis>, ["= 3.0.1"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<git>, [">= 0"])
    s.add_dependency(%q<rack-cache>, [">= 0"])
    s.add_dependency(%q<merb>, ["= 1.1.0"])
    s.add_dependency(%q<rspec>, ["= 1.3.0"])
    s.add_dependency(%q<i18n>, [">= 0"])
    s.add_dependency(%q<methopara>, [">= 0"])
    s.add_dependency(%q<redis>, ["= 3.0.1"])
  end
end
