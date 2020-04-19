unless defined?(Motion::Project::Config)
#   raise "This file must be required within a RubyMotion project Rakefile."
	require 'ruby_dimsome.rb'
else
	require_relative 'motion_dimsome.rb'
end
