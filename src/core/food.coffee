define ->
	class Food

		constructor: (@map, @color) ->
			@spawn()

		spawn: ->
			@x = ~~(Math.random() * @map.width)
			@y = ~~(Math.random() * @map.height)

		draw: ->
			@map.drawCell @x, @y, @color