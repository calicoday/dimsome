unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

Motion::Project::App.setup do |app|
  ### how cagey nec???
  platform = (app.respond_to?(:template) ? app.template : :ios)
	platform_include = case platform.to_s
	when /\bosx\b/ 
		"motion_dimsome/dims_include_osx.rb"
# 	when /\bios\b/, /\btvos\b/ # watchos???
# 	when /\bandroid\b/
	else
		"motion_dimsome/dims_include_ios.rb"
	end
	
  ["dimsome/mod_util.rb",
		"dimsome/mod_arith.rb",
		"dimsome/mod_point.rb",
		"dimsome/mod_size.rb",
		"dimsome/mod_rect_relative.rb",
		"dimsome/mod_rect_grip.rb",
		"dimsome/mod_rect_accessors.rb",
		"dimsome/mod_rect_apply.rb",
		"dimsome/grid.rb",
		"dimsome/twig.rb",
		"motion_dimsome/mod_flipflop.rb",
		"motion_dimsome/dims_include.rb",
    platform_include, ### plat alts
		"motion_dimsome/cg_dims_plus.rb",
		### and non-CG Ruby dims...
		'ruby_dimsome/dim2d_bod.rb',
		'ruby_dimsome/point_bod.rb',
		'ruby_dimsome/size_bod.rb',
		'ruby_dimsome/rect_bod.rb',
		].each do |file|
    app.files.unshift(File.expand_path(file, File.dirname(__FILE__)))
  end
end
