extends Area2D

var held_character = null

func _on_HeldLock_body_entered(body):
	if body != get_parent():
		print ("On")

func _on_HeldLock_body_exited(body):
	if body != get_parent():
		print ("Off")
