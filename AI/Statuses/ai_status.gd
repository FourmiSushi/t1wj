extends Reference
class_name AIStatus

var ai

func _init(ai) -> void:
	self.ai = ai

func get_value():
	assert(false, "Please override `get_value` in the derived script.")
