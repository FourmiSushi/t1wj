extends AIPred
class_name KeepFrame

var duration: int
var count: int
var pred

func _init(ai, duration: int, pred).(ai) -> void:
	self.duration = duration
	self.pred = pred

func process(delta: float, ai) -> bool:
	if pred.process(delta, ai):
		count += 1
	return count >= duration
