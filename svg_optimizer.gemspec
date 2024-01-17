# frozen_string_literal: true

require "./lib/svg_optimizer/version"

Gem::Specification.new do |spec|
  spec.name          = "svg_optimizer"
  spec.version       = SvgOptimizer::VERSION
  spec.authors       = ["Nando Vieira"]
  spec.email         = ["fnando.vieira@gmail.com"]
  spec.description   = "SVG optimization based on Node's SVGO"
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/fnando/svg_optimizer"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 3.1"
  spec.metadata = {"rubygems_mfa_required" => "true"}

  spec.files         = Dir["LICENSE.md", "README.md", "lib/**/*"]
  spec.test_files    = Dir["spec/**/*"]
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "minitest-utils"
  spec.add_development_dependency "pry-meta"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-fnando"
  spec.add_development_dependency "simplecov"
end
