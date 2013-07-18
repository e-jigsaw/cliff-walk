class TD
	ips: 10
	gamma: 0.9
	alpha: 1
	lambda: 0.9

	constructor: ->
		@V = []
		for i in [0..9]
			row = []
			for j in [0..9]
				state = {}
				state.val = 0
				state.dir = {}
				for dir in ["up", "right", "down", "left", "start"]
					state.dir[dir] = 1
				state.dir.up= 0 if i is 0
				state.dir.right = 0 if j is 9
				state.dir.down = 0 if i is 9
				state.dir.left = 0 if j is 0
				unless i is 9 and j > 0 and j < 9
					state.dir.start = 0
				else
					state.dir.up = state.dir.right = state.dir.down = state.dir.left = 0
				row.push state
			@V.push row

		@e = []
		for i in [0..9]
			row = []
			for j in [0..9]
				row.push 0
			@e.push row

	decide: (field)->
		list = []
		x = field.current.x
		y = field.current.y

		for dir of @V[y][x].dir
			if @V[y][x].dir[dir] is 1
				state = field.next dir
				list.push
					dir: dir
					val: @V[state.y][state.x].val
		return list[Math.floor(Math.random() * list.length)].dir if Math.floor(Math.random() * 100) < @ips # ips-greedy
		max = list[0].val
		action = list[0].dir
		for state in list
			if max < state.val
				max = state.val
				action = state.dir
		return action

	update: (reward, currentState, nextState)->
		delta = reward + (@gamma * @V[nextState.y][nextState.x].val) - @V[currentState.y][currentState.x].val
		@e[currentState.y][currentState.x] += 1
		for row, i in @V
			for state, j in row
				@V[i][j].val = state.val + (@alpha * delta * @e[i][j])
				@e[i][j] = @gamma * @lambda * @e[i][j]

module.exports = TD
