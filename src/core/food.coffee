define ->
	class Food

		constructor: (@map, @color) ->
			@spawn()

		spawn: ->
			@x = ~~(Math.random() * @map.width)
			@y = ~~(Math.random() * @map.height)
			return unless @map.pts
			for pt in @map.pts
				if pt.x is @x and pt.y is @y
					@spawn()

		draw: ->
			@map.drawCell @x, @y, @color