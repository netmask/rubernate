# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rubernate}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jonathan Garay"]
  s.date = %q{2011-08-04}
  s.description = %q{Library for Mapping Ruby Classes has Hibernate classes }
  s.email = %q{jonathan@devmask.net}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".Rhistory",
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/.DS_Store",
    "lib/native/.DS_Store",
    "lib/native/lib/.DS_Store",
    "lib/native/lib/antlr-2.7.6.jar",
    "lib/native/lib/c3p0-0.9.1.jar",
    "lib/native/lib/commons-collections-3.1.jar",
    "lib/native/lib/dom4j-1.6.1.jar",
    "lib/native/lib/hibernate-jpa-2.0-api-1.0.1.Final.jar",
    "lib/native/lib/hibernate3.jar",
    "lib/native/lib/javaee.jar",
    "lib/native/lib/javassist.jar",
    "lib/native/lib/javax.persistence.jar",
    "lib/native/lib/jta-1.1.jar",
    "lib/native/lib/mysql-connector-java-5.1.15-bin.jar",
    "lib/native/lib/slf4j-api-1.6.1.jar",
    "lib/native/lib/slf4j-simple-1.6.1.jar",
    "lib/native/src/net/devmask/rubernate/ClassBuilder.java",
    "lib/rubernate.rb",
    "lib/rubernate/bytecode.rb",
    "lib/rubernate/class_parser.rb",
    "lib/rubernate/connection.rb",
    "lib/rubernate/entity.rb",
    "lib/rubernate/init.rb",
    "lib/rubernate/relations.rb",
    "out/production/Rubernate/net/devmask/rubernate/ClassBuilder.class",
    "rubernate.gemspec",
    "test/helper.rb",
    "test/test_rubernate.rb"
  ]
  s.homepage = %q{http://github.com/netmask/rubernate}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.1}
  s.summary = %q{Hibernate for Ruby}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<jruby-openssl>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<smart_colored>, [">= 0"])
    else
      s.add_dependency(%q<jruby-openssl>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<smart_colored>, [">= 0"])
    end
  else
    s.add_dependency(%q<jruby-openssl>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<yard>, ["~> 0.6.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<smart_colored>, [">= 0"])
  end
end

