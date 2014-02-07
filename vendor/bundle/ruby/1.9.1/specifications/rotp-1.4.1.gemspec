# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rotp"
  s.version = "1.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mark Percival"]
  s.date = "2012-05-21"
  s.description = "Works for both HOTP and TOTP, and includes QR Code provisioning"
  s.email = ["mark@markpercival.us"]
  s.homepage = "http://github.com/mdp/rotp"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "rotp"
  s.rubygems_version = "1.8.25"
  s.summary = "A Ruby library for generating and verifying one time passwords"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<timecop>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<timecop>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<timecop>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
