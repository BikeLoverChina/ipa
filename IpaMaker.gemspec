# frozen_string_literal: true

require_relative "lib/IpaMaker/version"

Gem::Specification.new do |spec|
  spec.name          = "IpaMaker"
  spec.version       = IpaMaker::VERSION
  spec.authors       = ["yangwenjun01"]
  spec.email         = ["18244688848@163.com"]

  spec.summary       = "命令行自助打包工具"
  spec.description   = "类似pod命令实现一键打包, 需要使用者安装fastlane"
  spec.homepage      = "https://www.empty.com"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["allowed_push_host"] = "http://www.empty.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://www.empty.com"
  spec.metadata["changelog_uri"] = "http://www.empty.com"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = "ipa"
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'claide',         '>= 1.0.2', '< 2.0'
  spec.add_runtime_dependency 'colored2',       '~> 3.1'

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
