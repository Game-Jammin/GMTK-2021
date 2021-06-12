extends Position2D

var characters = []

func _ready():
	characters = get_tree().get_nodes_in_group("Characters")

func _process(delta):
	var total_postion = Vector2.ZERO
	for character in characters:
		total_postion += character.global_position
	global_position = total_postion / 3
