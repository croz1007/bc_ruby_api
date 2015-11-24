Gem::Specification.new do |s|
 s.platform    = Gem::Platform::RUBY
 s.name        = 'bc_ruby_api'
 s.version     = '1.0.0'
 s.summary     = 'BC Ruby API Library'
 s.description = '1.0.0'
 s.summary     = 'BC Ruby API Library'
 s.author        = "Ben Bloom", "Brian Crosby"
 s.homepage      = 'https://github.com/croz1007/'
 s.files         = `git ls-files`.split("\n")
 s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
 s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
 s.add_dependency('rest-client', '~> 1.4')
 s.require_paths = %w{lib}
 s.requirements << 'none'
 s.license = 'MIT'
end
