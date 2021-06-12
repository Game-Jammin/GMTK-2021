extends Control

func _on_Quit_pressed():
	get_tree().quit()

func _on_Play_pressed():
	SceneManager.goto_scene("res://levels/Level1.tscn")
