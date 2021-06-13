extends Node2D

export (bool) var shake = false

var character = null

func _ready():
	if "Lazy" in character.name:
		$AnimationPlayer.play("Lazy Explode")
	elif "Manic" in character.name:
		$AnimationPlayer.play("Manic Explode")
	elif "Panic" in character.name:
		$AnimationPlayer.play("Panic Explode")

func _process(_delta):
	if shake:
		shake = false
		Global.shake_screen(0.2, 15, 16, 0)
		character.queue_free()

func _on_AnimationPlayer_animation_finished(_anim_name):
	print ("Finsihed")
	queue_free()
