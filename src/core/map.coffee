define ["loadfile"], (loadFile) ->

	class Map

		pts: []

		constructor: (@ctx, @cw, type, path) ->
			@width = @ctx.width / @cw
			@height = @ctx.height / @cw
			@type = type ? 'square'

			buff = if path then loadFile(path).split "\n" else []
			array = []
			for row in buff
				array.push row.split ""

			for y, row of array
				for x of row
					unless row[x] is " "
						@pts.push x: ~~x, y: ~~y

			@draw()

		draw: (color) ->
			for pt in @pts
				@drawCell pt.x, pt.y, color, 0.5, "square"

		drawCell: (x, y, color, alpha, type) ->
			@ctx.fillStyle = color ? 'white'
			@ctx.globalAlpha = alpha
			type ?= @type

			switch type
				when 'square'
					@ctx.fillRect x * @cw, y * @cw, @cw, @cw
					@ctx.fillStyle = 'white' # reset
				when 'circle'
					r = @cw >> 1
					@ctx.beginPath()
					@ctx.arc x * @cw + r, y * @cw + r, r, 0, Math.PI*2, true
					@ctx.closePath()
					@ctx.fill()
			@ctx.globalAlpha = 1

		clear: ->
			@ctx.fillStyle = 'black'
			@ctx.fillRect 0, 0, @ctx.width, @ctx.height
			@ctx.fillStyle = 'white'