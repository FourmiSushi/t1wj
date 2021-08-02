extends AITask
class_name Attack

var until: AIPred

func _init(ai, until: AIPred).(ai) -> void:
	self.until = until

func process(delta: float) -> bool:
	if not until.process(delta, ai):
		ai.get_node("Sprite").modulate = Color(0, 1, 0)
		return false
	ai.get_node("Sprite").modulate = Color(1, 1, 1)
	return true
