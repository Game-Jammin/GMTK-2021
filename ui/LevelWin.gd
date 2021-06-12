extends Panel

func _on_Menu_pressed():
	SceneManager.goto_scene('res://ui/Main Menu.tscn')

func _on_Next_pressed():
	var current_level_number = get_parent().get_parent().level_number
	var level_path = 'res://levels/Level'+str(current_level_number+1)+'.tscn'
	var file = File.new()
	if file.file_exists(level_path):
		SceneManager.goto_scene(level_path)
	else:
		SceneManager.goto_scene('res://ui/Main Menu.tscn')
