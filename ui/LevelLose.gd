extends Panel

func _on_Restart_pressed():
	SceneManager.reload_scene()
	$AudioStreamPlayer.play()

func _on_Menu_pressed():
	SceneManager.goto_scene('res://ui/Main Menu.tscn')
