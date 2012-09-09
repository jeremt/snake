define ->
	
	createContext = (parent, width, height) ->

		canvas = document.createElement 'canvas'
		ctx = canvas.getContext '2d'

		canvas.width = width ? window.innerWidth
		canvas.height = height ? window.innerHeight

		document.querySelector(parent ? 'body').appendChild canvas

		ctx.width = canvas.width
		ctx.height = canvas.height

		return ctx