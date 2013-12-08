$:.unshift( File.expand_path( "../lib", __FILE__ ) )
require 'lab42/text/version'
version = Lab42::Text::VERSION
Gem::Specification.new do |s|
  s.name        = 'lab42_text'
  s.version     = version
  s.summary     = "Simple Text Manipulation"
  s.description = %{Boxes, Translations,...}
  s.authors     = ["Robert Dober"]
  s.email       = 'robert.dober@gmail.com'
  s.files       = Dir.glob("lib/**/*.rb")
  s.files      += %w{LICENSE README.md}
  s.homepage    = "https://github.com/RobertDober/lab42_text"
  s.licenses    = %w{MIT}

  s.required_ruby_version = '>= 2.0.0'

  s.add_dependency 'lab42_core', '~> 0.0.6'
  s.add_development_dependency 'pry', '~> 0.9.12'
  s.add_development_dependency 'rspec', '~> 2.14'
end
