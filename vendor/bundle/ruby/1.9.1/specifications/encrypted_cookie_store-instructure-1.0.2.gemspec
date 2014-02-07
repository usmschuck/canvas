# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "encrypted_cookie_store-instructure"
  s.version = "1.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Cody"]
  s.date = "2012-05-11"
  s.description = "A secure version of Rails' built in CookieStore"
  s.extra_rdoc_files = ["LICENSE.txt"]
  s.files = ["LICENSE.txt"]
  s.homepage = "http://github.com/ccutrer/encrypted_cookie_store"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "EncryptedCookieStore for Ruby on Rails 2.3"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
