# gemspec for hybrid_dimsome (rubymotion, ruby)
# not filled in yet!!! FIXME!!!


Gem::Specification.new do |s|
  s.name               = "dimsome"
  s.version            = "0.2.0"
#   s.default_executable = "do_a_thing"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Calicoday"]
  s.date = %q{2020-04-19}
  s.description = %q{2d dimensions}
  #s.email = %q{cal@twigsoftware.com}
  s.files = [ #"GemRakefile", 
  	"lib/dimsome.rb", 
		### common
		"lib/dimsome/version.rb",
		"lib/dimsome/mod_util.rb",
		"lib/dimsome/mod_size.rb",
		"lib/dimsome/mod_rect_relative.rb",
		"lib/dimsome/mod_rect_apply.rb",
		"lib/dimsome/mod_rect_grip.rb",
		"lib/dimsome/mod_rect_accessors.rb",
		"lib/dimsome/mod_point.rb",
		"lib/dimsome/mod_arith.rb",
		"lib/dimsome/grid.rb",
		"lib/dimsome/twig.rb",
		### rubymotion
		"lib/motion_dimsome.rb",
		"lib/motion_dimsome/mod_flipflop.rb",
		"lib/motion_dimsome/dims_include.rb",
		"lib/motion_dimsome/dims_include_ios.rb", ### plat alts
		"lib/motion_dimsome/dims_include_osx.rb",
		"lib/motion_dimsome/cg_dims_plus.rb",
		### ruby
  	"lib/ruby_dimsome.rb", 
		"lib/ruby_dimsome/size.rb",
		"lib/ruby_dimsome/rect.rb",
		"lib/ruby_dimsome/point.rb",
		"lib/ruby_dimsome/dim2d.rb",
		"lib/ruby_dimsome/dims_include.rb",
		'lib/ruby_dimsome/dim2d_bod.rb',
		'lib/ruby_dimsome/point_bod.rb',
		'lib/ruby_dimsome/size_bod.rb',
		'lib/ruby_dimsome/rect_bod.rb',
		]
  #s.test_files = ["test/test_hola.rb"]
  #s.homepage = %q{http://rubygems.org/gems/hola}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{2.6.5}
  s.summary = %q{Dimsome}
  # Short decription of this gem for finding it in a list of gems
  # Longer description of this gem and its possible usefulness to a project

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end


# from motion_print:
#   files = []
#   files << 'README.md'
#   files << 'LICENSE'
#   files.concat(Dir.glob('lib/**/*.rb'))
#   files.concat(Dir.glob('motion/**/*.rb'))
#...
#   s.require_paths = ["lib"]
