extends Node2D

export (int) var level_number = 1
var linkable_characters

func _process(delta):
	if not ($UI/LevelWin.visible or $UI/LevelLose.visible):
		linkable_characters = get_tree().get_nodes_in_group("LinkableCharacters")
		if linkable_characters.size() > 0:
			if check_win():
				win()

func check_win():
	for character in linkable_characters:
		if not character.satisfied:
			return false
	return true

func win():
	$UI/LevelWin.show()
	
func lose():
	$UI/LevelLose.show()
