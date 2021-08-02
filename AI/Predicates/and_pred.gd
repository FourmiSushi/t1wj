extends AIPred
class_name AndPred

var preds: Array

func _init(ai, preds: Array).(ai) -> void:
	self.preds = preds

func process(delta: float, ai) -> bool:
	var r = true
	for p in preds:
		r = p.process(delta, ai) and r
	return r
