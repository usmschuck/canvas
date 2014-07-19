# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rspec-rails"
  s.version = "1.3.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["RSpec Development Team"]
  s.date = "2011-04-10"
  s.description = "Behaviour Driven Development for Ruby on Rails."
  s.email = ["rspec-devel@rubyforge.org"]
  s.homepage = "http://github.com/dchelimsky/rspec-rails"
  s.require_paths = ["lib"]
  s.rubyforge_project = "rspec"
  s.rubygems_version = "1.8.25"
  s.summary = "rspec-rails 1.3.4"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rspec>, ["~> 1.3.1"])
      s.add_runtime_dependency(%q<rack>, [">= 1.0.0"])
      s.add_development_dependency(%q<cucumber>, [">= 0.3.99"])
    else
      s.add_dependency(%q<rspec>, ["~> 1.3.1"])
      s.add_dependency(%q<rack>, [">= 1.0.0"])
      s.add_dependency(%q<cucumber>, [">= 0.3.99"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 1.3.1"])
    s.add_dependency(%q<rack>, [">= 1.0.0"])
    s.add_dependency(%q<cucumber>, [">= 0.3.99"])
  end
end
