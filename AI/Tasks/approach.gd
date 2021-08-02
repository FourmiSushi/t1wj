extends AITask
class_name Approach

var target: Node2D
var speed: int
var until: AIPred

func _init(ai, target: Node2D, speed: int, until: AIPred).(ai) -> void:
	self.target = target
	self.speed = speed
	self.until = until

func process(delta: float) -> bool:
	if not until.process(delta, ai):
		ai.position += (target.position - ai.position).normalized() * speed * delta
		return false
	return true
