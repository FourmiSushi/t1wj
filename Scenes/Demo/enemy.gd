extends AI

func next_movement() -> void:
	var player = get_node("../Player")
	tasks = [
		Approach.new(self, player, 240, Below.new(self, 120, Distance.new(self, player))),
		Attack.new(self, Once.new(self))
	]
