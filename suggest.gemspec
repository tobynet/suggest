Gem::Specification.new do |s|
  s.name        = 'suggest'
  s.version     = '0.1.0'
  s.platform    = Gem::Platform::RUBY
  s.authors       = ["toooooooby"]
  s.email         = ["toby.net.info.mail+git@gmail.com"]
  s.summary     = 'suggest text'
  s.description = 'Suggest with GoogleSuggest'

  s.files         = ['suggest.rb']
  s.require_path  = '.'

  s.add_development_dependency('rspec', ["~> 2.0"])
end
