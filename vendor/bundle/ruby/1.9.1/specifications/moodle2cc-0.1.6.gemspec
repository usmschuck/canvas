# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "moodle2cc"
  s.version = "0.1.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Christopher Durtschi", "Kevin Carter", "Instructure"]
  s.date = "2012-12-07"
  s.description = "Migrates Moodle backup ZIP to IMS Common Cartridge package"
  s.email = ["christopher.durtschi@gmail.com", "cartkev@gmail.com", "eng@instructure.com"]
  s.executables = ["moodle2cc"]
  s.files = ["bin/moodle2cc"]
  s.homepage = "https://github.com/instructure/moodle2cc"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "Migrates Moodle backup ZIP to IMS Common Cartridge package"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rubyzip>, [">= 0"])
      s.add_runtime_dependency(%q<happymapper>, [">= 0"])
      s.add_runtime_dependency(%q<builder>, [">= 0"])
      s.add_runtime_dependency(%q<thor>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_runtime_dependency(%q<rdiscount>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
      s.add_development_dependency(%q<guard>, [">= 0"])
      s.add_development_dependency(%q<guard-bundler>, [">= 0"])
      s.add_development_dependency(%q<guard-minitest>, [">= 0"])
    else
      s.add_dependency(%q<rubyzip>, [">= 0"])
      s.add_dependency(%q<happymapper>, [">= 0"])
      s.add_dependency(%q<builder>, [">= 0"])
      s.add_dependency(%q<thor>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<rdiscount>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 0"])
      s.add_dependency(%q<guard>, [">= 0"])
      s.add_dependency(%q<guard-bundler>, [">= 0"])
      s.add_dependency(%q<guard-minitest>, [">= 0"])
    end
  else
    s.add_dependency(%q<rubyzip>, [">= 0"])
    s.add_dependency(%q<happymapper>, [">= 0"])
    s.add_dependency(%q<builder>, [">= 0"])
    s.add_dependency(%q<thor>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<rdiscount>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 0"])
    s.add_dependency(%q<guard>, [">= 0"])
    s.add_dependency(%q<guard-bundler>, [">= 0"])
    s.add_dependency(%q<guard-minitest>, [">= 0"])
  end
end
