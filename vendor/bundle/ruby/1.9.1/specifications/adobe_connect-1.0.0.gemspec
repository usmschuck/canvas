# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "adobe_connect"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Zach Pendleton"]
  s.date = "2013-05-09"
  s.description = "An API wrapper for interacting with Adobe Connect services."
  s.email = ["zachpendleton@gmail.com"]
  s.executables = ["adobe_connect_console"]
  s.files = ["bin/adobe_connect_console"]
  s.homepage = "https://github.com/zachpendleton/adobe_connect"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "An API wrapper for Adobe Connect services."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.3.17"])
      s.add_runtime_dependency(%q<nokogiri>, ["~> 1.5.5"])
      s.add_runtime_dependency(%q<rake>, [">= 0.9.2"])
      s.add_development_dependency(%q<minitest>, ["~> 4.6.0"])
      s.add_development_dependency(%q<mocha>, ["~> 0.13.2"])
      s.add_development_dependency(%q<pry>, [">= 0.9.11.4"])
      s.add_development_dependency(%q<redcarpet>, [">= 0"])
      s.add_development_dependency(%q<yard>, ["~> 0.8.4.1"])
      s.add_development_dependency(%q<yard-tomdoc>, ["~> 0.6.0"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.3.17"])
      s.add_dependency(%q<nokogiri>, ["~> 1.5.5"])
      s.add_dependency(%q<rake>, [">= 0.9.2"])
      s.add_dependency(%q<minitest>, ["~> 4.6.0"])
      s.add_dependency(%q<mocha>, ["~> 0.13.2"])
      s.add_dependency(%q<pry>, [">= 0.9.11.4"])
      s.add_dependency(%q<redcarpet>, [">= 0"])
      s.add_dependency(%q<yard>, ["~> 0.8.4.1"])
      s.add_dependency(%q<yard-tomdoc>, ["~> 0.6.0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.3.17"])
    s.add_dependency(%q<nokogiri>, ["~> 1.5.5"])
    s.add_dependency(%q<rake>, [">= 0.9.2"])
    s.add_dependency(%q<minitest>, ["~> 4.6.0"])
    s.add_dependency(%q<mocha>, ["~> 0.13.2"])
    s.add_dependency(%q<pry>, [">= 0.9.11.4"])
    s.add_dependency(%q<redcarpet>, [">= 0"])
    s.add_dependency(%q<yard>, ["~> 0.8.4.1"])
    s.add_dependency(%q<yard-tomdoc>, ["~> 0.6.0"])
  end
end
