define ->

	class Map

		constructor: (@ctx, @cw, type) ->
			@width = @ctx.width / @cw
			@height = @ctx.height / @cw
			@type = type ? 'square'

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