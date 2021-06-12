extends Control

func _on_Resume_pressed():
	toogle_pause()

func _on_Menu_pressed():
	SceneManager.goto_scene('res://ui/Main Menu.tscn')

func _on_Quit_pressed():
	get_tree().quit()

func _input(event):
	if event.is_action_pressed("pause"):
		toogle_pause()

func toogle_pause():
	get_tree().paused = not get_tree().paused
	visible = get_tree().paused
