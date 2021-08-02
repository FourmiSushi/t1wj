extends Reference
class_name AIPred

var ai

func _init(ai) -> void:
	self.ai = ai

func process(delta: float, ai) -> bool:
	assert(false, "Please override `_process` in the derived script.")
	return true
