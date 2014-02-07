# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "yard-appendix"
  s.version = "0.1.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ahmad Amireh"]
  s.date = "2013-02-06"
  s.description = "    yard-appendix is a plugin for YARD, the Ruby documentation generation tool,\n    that defines a special directive @!appendix for writing appendixes for your\n    code documentation, similar to appendixes you find in books.\n\n    Appendix entries can be referenced to by methods and classes in your docs\n    using the @see tag and inline-references, just like any other object.\n"
  s.email = "ahmad@instructure.com"
  s.homepage = "https://github.com/amireh/yard-appendix"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "A YARD plugin that adds support for Appendix sections."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<yard>, [">= 0.8.0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<yard>, [">= 0.8.0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<yard>, [">= 0.8.0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
