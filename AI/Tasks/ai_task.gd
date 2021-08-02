extends Reference
class_name AITask

var ai

func _init(ai) -> void:
	self.ai = ai

func process(delta: float) -> bool:
	assert(false, "Please override `process` in the derived script.")
	return true
