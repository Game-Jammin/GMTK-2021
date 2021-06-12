extends Node2D

func _ready():
	Global.shake_screen(0.2, 15, 16, 0)
	$Particles2D.emitting = true

func _process(_event):
	if not $Particles2D.emitting:
		queue_free()
