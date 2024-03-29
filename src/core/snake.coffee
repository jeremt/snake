define ["kevent"], (KEvent) ->
	class Snake

		_len = 5
		_body = new Array _len

		direction: 'right'

		constructor: (@map, @color, x, y) ->
			@key = new KEvent

			@create(x, y)
			@draw()

		create: (x, y) ->
			i = 0
			while i < _len
				_body[i++] = x: x - i, y: y

		draw: ->
			@map.clear()
			alpha = 1
			for node in _body
				@map.drawCell node.x, node.y, @color, alpha
				if alpha > 0.4
					alpha -= 0.1

		move: (dir) ->
			switch dir
				when 'up'
					y = _body[0].y - 1
					y = if y < 0 then @map.height - 1 else y
					tail = x: _body[0].x, y: y
				when 'down'
					y = _body[0].y + 1
					y = if y >= @map.height then 0 else y
					tail = x: _body[0].x, y: y
				when 'right'
					x = _body[0].x + 1
					x = if x >= @map.width then 0 else x
					tail = x: x, y: _body[0].y
				when 'left'
					x = _body[0].x - 1
					x = if x < 0 then @map.width - 1 else x
					tail = x: x, y: _body[0].y

			_body.unshift tail
			@draw()

		eat: (food) ->
			unless _body[0].x is food.x and _body[0].y is food.y
				_body.pop()
				return false
			return true

		hit: (pts) ->
			head = true
			for node in _body
				if not head and node.x is _body[0].x and node.y is _body[0].y
					return true
				head = false
			return false unless pts
			for pt in pts
				if pt.x is _body[0].x and pt.y is _body[0].y
					return true
			return false

		update: ->
			if @key.pressed("up") and @direction != "down"
				@direction = "up"
			else if @key.pressed("down") and @direction != "up"
				@direction = 'down'
			else if @key.pressed("left")  and @direction != "right"
				@direction = 'left'
			else if @key.pressed("right") and @direction != "left"
				@direction = 'right'