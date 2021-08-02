extends AITask
class_name CompTask

var tasks: Array

func _init(ai, tasks: Array).(ai) -> void:
	self.tasks = tasks

func process(delta: float) -> bool:
	var remained_tasks = []
	for t in tasks:
		if not t.process(delta):
			remained_tasks.push_back(t)
	tasks = remained_tasks
	return tasks.size() == 0

