extends Node2D
class_name AI

var tasks = []

func _process(delta: float) -> void:
	if tasks.size() > 0:
		if tasks[0].process(delta):
			tasks.pop_front()
	if tasks.size() == 0:
		next_movement()

func next_movement() -> void:
	assert(false, "Please override `next_movement` in the derived script.")
