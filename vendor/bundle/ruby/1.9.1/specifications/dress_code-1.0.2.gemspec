# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "dress_code"
  s.version = "1.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Florence", "Cameron Matheson"]
  s.date = "2013-03-20"
  s.description = "Dress Code extracts comment blocks from your stylesheets and creates a styleguide using your CSS."
  s.executables = ["dress_code"]
  s.files = ["bin/dress_code"]
  s.homepage = "http://github.com/instructure/dress_code"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "CSS Documentation and Styleguide Generator"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<redcarpet>, [">= 0"])
      s.add_runtime_dependency(%q<pygments.rb>, [">= 0"])
      s.add_runtime_dependency(%q<mustache>, [">= 0"])
      s.add_runtime_dependency(%q<colored>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<redcarpet>, [">= 0"])
      s.add_dependency(%q<pygments.rb>, [">= 0"])
      s.add_dependency(%q<mustache>, [">= 0"])
      s.add_dependency(%q<colored>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<redcarpet>, [">= 0"])
    s.add_dependency(%q<pygments.rb>, [">= 0"])
    s.add_dependency(%q<mustache>, [">= 0"])
    s.add_dependency(%q<colored>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
