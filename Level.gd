extends Node2D

var linkable_characters 

func _process(delta):
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
	print ("You Win!")
	
func lose():
	print ("You Lose!")
