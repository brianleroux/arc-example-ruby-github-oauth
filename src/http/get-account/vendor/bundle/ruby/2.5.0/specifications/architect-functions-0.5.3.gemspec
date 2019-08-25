# -*- encoding: utf-8 -*-
# stub: architect-functions 0.5.3 ruby lib

Gem::Specification.new do |s|
  s.name = "architect-functions".freeze
  s.version = "0.5.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Brian LeRoux".freeze]
  s.date = "2019-01-26"
  s.description = "Runtime helpers for AWS Lambda functions provisioned with Architect".freeze
  s.email = "b@brian.io".freeze
  s.homepage = "http://rubygems.org/gems/architect-functions".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.rubygems_version = "3.0.4".freeze
  s.summary = "Helper functions for AWS Lambda".freeze

  s.installed_by_version = "3.0.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<aws-sdk-dynamodb>.freeze, [">= 1.33.0", "~> 1.33"])
      s.add_runtime_dependency(%q<aws-sdk-sqs>.freeze, [">= 1.18.0", "~> 1.18"])
      s.add_runtime_dependency(%q<aws-sdk-sns>.freeze, [">= 1.18.0", "~> 1.18"])
      s.add_runtime_dependency(%q<aws-sdk-s3>.freeze, [">= 1.45.0", "~> 1.45"])
      s.add_runtime_dependency(%q<aws-sdk-ssm>.freeze, [">= 1.52.0", "~> 1.52"])
      s.add_runtime_dependency(%q<aws-sdk-apigateway>.freeze, [">= 1.33.0", "~> 1.33"])
      s.add_runtime_dependency(%q<jwe>.freeze, [">= 0.4.0", "~> 0.4"])
    else
      s.add_dependency(%q<aws-sdk-dynamodb>.freeze, [">= 1.33.0", "~> 1.33"])
      s.add_dependency(%q<aws-sdk-sqs>.freeze, [">= 1.18.0", "~> 1.18"])
      s.add_dependency(%q<aws-sdk-sns>.freeze, [">= 1.18.0", "~> 1.18"])
      s.add_dependency(%q<aws-sdk-s3>.freeze, [">= 1.45.0", "~> 1.45"])
      s.add_dependency(%q<aws-sdk-ssm>.freeze, [">= 1.52.0", "~> 1.52"])
      s.add_dependency(%q<aws-sdk-apigateway>.freeze, [">= 1.33.0", "~> 1.33"])
      s.add_dependency(%q<jwe>.freeze, [">= 0.4.0", "~> 0.4"])
    end
  else
    s.add_dependency(%q<aws-sdk-dynamodb>.freeze, [">= 1.33.0", "~> 1.33"])
    s.add_dependency(%q<aws-sdk-sqs>.freeze, [">= 1.18.0", "~> 1.18"])
    s.add_dependency(%q<aws-sdk-sns>.freeze, [">= 1.18.0", "~> 1.18"])
    s.add_dependency(%q<aws-sdk-s3>.freeze, [">= 1.45.0", "~> 1.45"])
    s.add_dependency(%q<aws-sdk-ssm>.freeze, [">= 1.52.0", "~> 1.52"])
    s.add_dependency(%q<aws-sdk-apigateway>.freeze, [">= 1.33.0", "~> 1.33"])
    s.add_dependency(%q<jwe>.freeze, [">= 0.4.0", "~> 0.4"])
  end
end
