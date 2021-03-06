extends Node

var current_scene = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	Transition.get_node("AnimationPlayer").play("Show")
	
func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)

func reload_scene():
	call_deferred("_deferred_goto_scene", current_scene.get_filename())

func _deferred_goto_scene(path):
	Transition.get_node("AnimationPlayer").play_backwards("Show")
	yield(Transition.get_node("AnimationPlayer"), "animation_finished")
	# It is now safe to remove the current scene
	current_scene.free()
	
	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instance()

	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)
	
	get_tree().paused = false
	Transition.get_node("AnimationPlayer").play("Show")
