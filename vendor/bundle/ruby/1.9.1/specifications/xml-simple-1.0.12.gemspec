# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "xml-simple"
  s.version = "1.0.12"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Maik Schmidt"]
  s.date = "2009-02-26"
  s.email = "contact@maik-schmidt.de"
  s.homepage = "http://xml-simple.rubyforge.org"
  s.require_paths = ["lib"]
  s.rubyforge_project = "xml-simple"
  s.rubygems_version = "1.8.25"
  s.summary = "A simple API for XML processing."

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end