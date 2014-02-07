# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "cssmin"
  s.version = "1.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Grove"]
  s.date = "2013-03-14"
  s.description = "Ruby library for minifying CSS. Inspired by cssmin.js and YUI Compressor."
  s.email = "ryan@wonko.com"
  s.homepage = "https://github.com/rgrove/cssmin/"
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.6")
  s.rubygems_version = "1.8.25"
  s.summary = "Ruby library for minifying CSS."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
