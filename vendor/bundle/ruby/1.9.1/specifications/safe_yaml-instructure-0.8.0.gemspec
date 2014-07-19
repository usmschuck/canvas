# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "safe_yaml-instructure"
  s.version = "0.8.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dan Tao", "Brian Palmer"]
  s.date = "2013-02-15"
  s.description = "Parse YAML safely, without that pesky arbitrary object deserialization vulnerability"
  s.email = "brianp@instructure.com"
  s.homepage = "http://github.com/instructure/safe_yaml/"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubygems_version = "1.8.25"
  s.summary = "SameYAML provides an alternative implementation of YAML.load suitable for accepting user input in Ruby applications."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hashie>, [">= 0"])
      s.add_development_dependency(%q<heredoc_unindent>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<travis-lint>, [">= 0"])
    else
      s.add_dependency(%q<hashie>, [">= 0"])
      s.add_dependency(%q<heredoc_unindent>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<travis-lint>, [">= 0"])
    end
  else
    s.add_dependency(%q<hashie>, [">= 0"])
    s.add_dependency(%q<heredoc_unindent>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<travis-lint>, [">= 0"])
  end
end
