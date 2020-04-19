# -*- coding: utf-8 -*-

$:.unshift("/Library/RubyMotion/lib")
$:.unshift("~/.rubymotion/rubymotion-templates")
if !ENV['ios'] #osx by default
  require 'motion/project/template/osx'
else
  require 'motion/project/template/ios'
end

puts "=+=+=+=+= #{`date`}"

begin
  require 'bundler'
  require 'motion/project/template/gem/gem_tasks'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  app.name = 'dimsome'

# 	app.frameworks += [
# 		'SpriteKit',
# 	### TMP!!! for daffsk !!!
# 		'GameplayKit',
# # 		'AVFoundation',
# # 		'GameplayKit',
# # 		'QuartzCore',
# # 		'CoreData',
# 		]

	# platform-specific
	if app.template == :osx
		app.deployment_target = '10.13'
		#app.version = '2.7.94'
		app.files += Dir.glob('./app-mac/*.rb')
		app.resources_dirs << ['resources-mac']		
	else
		#app.target "./app-wos", :watchapp

		#app.version = '2.9.12'
		app.files += Dir.glob('./app-ios/*.rb')
		app.resources_dirs << ['resources-ios']
	end

	# local app- directories
#   app.files += Dir.glob('./app-app/*.rb')
#   app.files += Dir.glob('./app-game/*.rb')

  #app.resources_dirs << ['resources/whatever']

  app.info_plist['CFBundleIconName'] = 'AppIcon'
end
