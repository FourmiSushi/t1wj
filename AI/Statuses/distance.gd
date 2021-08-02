extends AIStatus
class_name Distance

var target

func _init(ai, target).(ai) -> void:
	self.target = target

func get_value():
	if target.position != null:
		return (target.position - ai.position).length()
	elif target is Vector2:
		return (target - ai.position).length()
