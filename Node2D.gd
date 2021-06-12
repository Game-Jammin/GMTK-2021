extends Node2D

func _input(event):
	if event.is_action_pressed("left_click"):
		Global.shake_screen(0.4, 15, 16, 0)
