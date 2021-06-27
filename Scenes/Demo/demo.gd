extends Control

onready var function_option = $function
onready var arg1_option = $arg1
onready var arg2_option = $arg2
onready var stack_view = $stack_view

var f: int
var a1: int
var a2: int

var demo_paths = ["res://Scenes/Demo/1.tscn", "res://Scenes/Demo/2.tscn", "res://Scenes/Demo/3.tscn"]

func init_scene(f: int, a1: int, a2: int) -> void:
	self.f = f
	self.a1 = a1
	self.a2 = a2

func _ready() -> void:
	function_option.selected = f
	arg1_option.selected = a1
	arg2_option.selected = a2
	update_view(function_option.selected)
	for s in SceneManager.scene_stack:
		stack_view.text += s[0] + "\n"

func update_view(func_num: int) -> void:
	if func_num == 0:
		arg1_option.disabled = false
		arg2_option.disabled = true
	elif func_num == 1:
		arg1_option.disabled = false
		arg2_option.disabled = true
	elif func_num == 2:
		arg1_option.disabled = false
		arg2_option.disabled = false
	elif func_num == 3:
		arg1_option.disabled = true
		arg2_option.disabled = true
	elif func_num == 4:
		arg1_option.disabled = false
		arg2_option.disabled = true


func _on_execute_pressed() -> void:
	if function_option.selected == 0:
		SceneManager.start_root(demo_paths[arg1_option.selected], [function_option.selected, arg1_option.selected, arg2_option.selected])
	elif function_option.selected == 1:
		SceneManager.to(demo_paths[arg1_option.selected], [function_option.selected, arg1_option.selected, arg2_option.selected])
	elif function_option.selected == 2:
		SceneManager.replace(demo_paths[arg1_option.selected], demo_paths[arg2_option.selected], [function_option.selected, arg1_option.selected, arg2_option.selected])
	elif function_option.selected == 3:
		SceneManager.back()
	elif function_option.selected == 4:
		SceneManager.back_until(demo_paths[arg1_option.selected])


func _on_function_item_selected(index: int) -> void:
	update_view(index)


func _on_arg1_item_selected(index: int) -> void:
	update_view(function_option.selected)


func _on_arg2_item_selected(index: int) -> void:
	update_view(function_option.selected)
