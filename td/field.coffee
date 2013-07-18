class Field
	start:
		x: 0
		y: 9

	goal:
		x: 9
		y: 9

	current:
		x: 0
		y: 0

	prev:
		x: 0
		y: 0

	constructor: ->

	move: (x, y)->
		@prev =
			x: @current.x
			y: @current.y

		@current =
			x: x
			y: y

	next: (type)->
		switch type
			when "up"
				return new Object
					x: @current.x
					y: @current.y - 1
			when "right"
				return new Object
					x: @current.x + 1
					y: @current.y
			when "down"
				return new Object
					x: @current.x
					y: @current.y + 1
			when "left"
				return new Object
					x: @current.x - 1
					y: @current.y
			when "start"
				return new Object
					x: @start.x
					y: @start.y

	reward: ->
		return -100 if @current.x > 0 and @current.x < 9 and @current.y is 9
		return 100 if @current.x is @goal.x and @current.y is @goal.y
		return -1

module.exports = Field
