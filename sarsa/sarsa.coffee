class Sarsa
	ips: 10
	gamma: 0.9
	alpha: 1

	constructor: ->
		@data = []
		for i in [0..9]
			row = []
			for j in [0..9]
				action = {}
				for dir in ["up", "right", "down", "left", "start"]
					action[dir] = 
						val: 1
						ava: 1
				action.up.ava = 0 if i is 0
				action.right.ava = 0 if j is 9
				action.down.ava = 0 if i is 9
				action.left.ava = 0 if j is 0
				unless i is 9 and j > 0 and j < 9
					action.start.ava = 0
				else
					action.up.ava = action.right.ava = action.down.ava = action.left.ava = 0
				row.push action
			@data.push row

	decide: (x, y, ips)->
		ips = true if ips is undefined
		list = {}
		for dir of @data[y][x]
			list[dir] = @data[y][x][dir] if @data[y][x][dir].ava is 1
		return Object.keys(list)[Math.floor(Math.random() * (Object.keys(list).length-1))] if Math.floor(Math.random() * 100) < @ips and ips is true # ips-greedy
		max = list[Object.keys(list)[0]].val
		action = Object.keys(list)[0]
		for dir in Object.keys list
			if max < list[dir].val
				max = list[dir].val
				action = dir
		return action

	update: (reward, currentState, nextState, action)->
		maxAction = @decide nextState.x, nextState.y, true # calc max action
		@data[currentState.y][currentState.x][action].val += @alpha * (reward + @gamma * @data[nextState.y][nextState.x][maxAction].val - @data[currentState.y][currentState.x][action].val) # Sarsa-learning update formura

module.exports = Sarsa
