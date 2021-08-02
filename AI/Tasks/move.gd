extends AITask
class_name Move

var to: Vector2
var speed: int
var until: AIPred

func _init(ai, to: Vector2, speed: int, until: AIPred).(ai) -> void:
	self.to = to
	self.speed = speed
	self.until = until

func process(delta: float) -> bool:
	if not until.process(delta, ai):
		ai.position += (to - ai.position).normalized() * speed * delta
		return false
	return true
