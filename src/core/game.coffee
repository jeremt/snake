define [
	"utils/createcontext"
	"core/map"
	"core/snake"
	"core/food"
	"jquery"
], (createContext, Map, Snake, Food, $) ->

	color = ["cyan", "red", "orange", "purple", "green"][~~(Math.random() * 5)]

	$('h1').css color: color

	ctx = createContext '#snake-view', 500, 500
	ctx.fillRect 0, 0, ctx.width, ctx.height

	map = new Map ctx, 10, 'circle', "maps/square.map"
	snake = new Snake map, color, map.width >> 1, map.height >> 1
	food = new Food map, color

	over = ->
		clearInterval ts
		console.log "GAME OVER"

	ts = null
	t = 0
	score = 0
	gameLoop = ->
		snake.update()
		if t is 10
			if snake.eat(x: food.x, y: food.y)
				food.spawn()
				++score
			snake.move snake.direction
			if snake.hit map.pts
				over()
			food.draw()
			t = 0
			map.draw color
			ctx.fillText "Score: " + score, 10, 15
		++t

	ts = setInterval gameLoop, 6