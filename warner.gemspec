lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "warner/version"

Gem::Specification.new do |spec|
  spec.name = "warner"
  spec.version = Warner::VERSION
  spec.authors = ["Leon Berenschot"]
  spec.email = ["leon@wendbaar.nl"]

  spec.summary = "Annotate your code w/ custom deprecation warnings"
  spec.description = "Annotate your code w/ custom deprecation warnings. For example when a newer version of a gem or rails is installed. Especially useful for monkeypatching."
  spec.homepage = "https://github.com/LeipeLeon/warner"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["rubygems_mfa_required"] = "true"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/LeipeLeon/warner"
  spec.metadata["changelog_uri"] = "https://github.com/LeipeLeon/warner/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
