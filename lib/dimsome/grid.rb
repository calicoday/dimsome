module Dimsome

	class Grid
		attr_accessor :cols, :rows, :cell_rect

		def self.make(cell_rect, cols, rows)
			self.new(cell_rect, cols, rows)
		end
		def initialize(cell_rect, cols, rows)
			self.cell_rect = cell_rect
			self.cols = cols
			self.rows = rows
		end
	
		def cell_size() cell_rect.size end
		def grid_size() @grid_size ||= cell_size * [cols, rows] end
	
		def random_colrow
			[rand(0...cols), rand(0...rows)]
		end
	
		def colrow_to_rect(col, row)
			cell_rect.class.make(*(cell_size * [col, row]), *cell_size)
		end

		def point_to_colrow(p)
			# dims don't have floor yet!!! FIXME!!!
			got = p / cell_size
			[got.x.floor, got.y.floor]
		end
	
		def point_to_rect(p)
			colrow_to_rect(*point_to_colrow(p))
		end
	
	end

end