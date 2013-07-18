Field = require "./field"
TD = require "./td"

field = new Field()
td = new TD()

for episode in [0..5] # repeat episode
	field.move 0, 9 # initilize state
	reward = 0 # initialize reward
	while true # repeat until inside cliff
		action = td.decide field # decide action on current state
		nextState = field.next action # calc next state on axis
		field.move nextState.x, nextState.y # move next state
		reward = field.reward() # watch reward
		td.update reward, # update Q
			x: field.prev.x
			y: field.prev.y
		,
			x: field.current.x
			y: field.current.y
		break if reward is 100 # end episode if agent goaled

console.log td.e
