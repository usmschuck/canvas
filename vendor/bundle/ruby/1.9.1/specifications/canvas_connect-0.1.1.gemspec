# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "canvas_connect"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Zach Pendleton"]
  s.date = "2013-07-10"
  s.description = "Canvas Connect is an Adobe Connect plugin for the Instructure Canvas LMS. It allows teachers and administrators to create and launch Connect conferences directly from their courses."
  s.email = ["zachp@instructure.com"]
  s.homepage = "http://instructure.com"
  s.require_paths = ["app", "lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "Adobe Connect integration for Instructure Canvas (http://instructure.com)."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rake>, [">= 0.9.6"])
      s.add_runtime_dependency(%q<adobe_connect>, ["~> 1.0.0"])
    else
      s.add_dependency(%q<rake>, [">= 0.9.6"])
      s.add_dependency(%q<adobe_connect>, ["~> 1.0.0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0.9.6"])
    s.add_dependency(%q<adobe_connect>, ["~> 1.0.0"])
  end
end
