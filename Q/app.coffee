Field = require "./field"
Q = require "./Q"

field = new Field()
q = new Q()

for episode in [0..100] # repeat episode
	field.move 0, 9 # initilize state
	reward = 0 # initialize reward
	while true # repeat until inside cliff
		action = q.decide field.current.x, field.current.y, true # decide action on current state
		nextState = field.next action # calc next state on axis
		field.move nextState.x, nextState.y # move next state
		reward = field.reward() # watch reward
		q.update reward, # update Q
			x: field.prev.x
			y: field.prev.y
		,
			x: field.current.x
			y: field.current.y
		, action
		break if reward is 100 # end episode if agent goaled
