extends Node2D

export (bool) var shake = false

func _process(delta):
	if shake:
		shake = false
		Global.shake_screen(0.2, 15, 16, 0)

func _on_AnimationPlayer_animation_finished(_anim_name):
	print ("Finsihed")
	get_parent().queue_free()
