module Dimsome

	class Twig
		attr_accessor :name, :children, :data
	
		def initialize(*args)
			@name, @data, @children, _ = args
			@name ||= "new item"
			@children ||= []
		end

		def new_kid(name, data=nil)
			new_kid_at_index(name, -1, data)
		end
		def new_kid_at_index(name, index, data=nil)
			twig = Twig.new(name)
			@children.insert(index, twig)
			twig.data = data
			twig
		end
		### nec??? works???? FIXME!!!
		def new_kid_at_end(name, data=nil)
			Twig.new(name).tap{|o| children << o}
		end
	# 	def to_s
	# 		"[#{name}, #{children.map{|e| e.inspect}}]"
	# 	end
		def four11
			[name, children.map {|e| e.name }].inspect
		end
	end

end