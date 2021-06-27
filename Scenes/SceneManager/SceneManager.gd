extends Node2D

# シーン管理用スタック
var scene_stack: Array = []

# 現在再生中のシーンの実体
var current_scene: Node

# シーン変更時に渡された値を一時的に置く変数
var next_scene: String
var next_args: Array

onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	# 現在再生中のシーンをscene_stackに追加、current_sceneとする
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	scene_stack.push_front([current_scene.filename, []])
	animation_player.play("transition")

# 新しくシーンのスタックを入れ替える
func start_root(path: String, args: Array = []) -> void:
	next_scene = path
	next_args = args
	scene_stack = []
	
	animation_player.play_backwards()

# シーンを変更してシーンのスタックにプッシュ
func to(path: String, args: Array = []) -> void:
	next_scene = path
	next_args = args
	animation_player.play_backwards()

# シーンのスタックのuntilより上をpopしてシーンを変更、プッシュ
func replace(to: String, until: String, args: Array = []) -> void:
	while scene_stack.front()[0] != until:
		scene_stack.pop_front()
	
	next_scene = to
	next_args = args
	animation_player.play_backwards()

# シーン戻る
func back() -> void:
	scene_stack.pop_front()
	
	var s = scene_stack.pop_front()
	next_scene = s[0]
	next_args = s[1]
	animation_player.play_backwards()

# 指定したシーンまで戻る
func back_until(until: String) -> void:
	while scene_stack.front()[0] != until:
		scene_stack.pop_front()
	
	var s = scene_stack.pop_front()
	next_scene = s[0]
	next_args = s[1]
	animation_player.play_backwards()

# シーン変更、引数の適用、スタックにプッシュ（シーン変更の実際の処理部分）
func _deferred_goto_scene(path: String) -> void:
	current_scene.free()
	var scene: PackedScene = ResourceLoader.load(path)
	
	print_debug(path)
	
	current_scene = scene.instance()
	if len(next_args) > 0:
		current_scene.callv("init_scene", next_args)
	scene_stack.push_front([path, next_args])
	
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)
	
	animation_player.play()

# アニメーション再生後にシーン変更の処理を行う
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if next_scene != "":
		call_deferred("_deferred_goto_scene", next_scene)
	next_scene = ""
