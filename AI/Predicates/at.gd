extends AIPred
class_name At

var value
var status: AIStatus

func _init(ai, value, status: AIStatus).(ai) -> void:
	self.value = value
	self.status = status

func process(delta: float, ai) -> bool:
	var s = status.get_value()
	return typeof(s) == typeof(self.value) and self.value == s
