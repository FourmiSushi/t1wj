extends AIPred
class_name Keep

var duration: float
var count: float
var pred

func _init(ai, duration: float, pred).(ai) -> void:
	self.duration = duration
	self.pred = pred

func process(delta: float, ai) -> bool:
	if pred.process(delta, ai):
		count += delta
	return count >= duration
