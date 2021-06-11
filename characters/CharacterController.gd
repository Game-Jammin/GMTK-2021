extends Node2D

signal selected_changed

onready var characters = [get_node("Character1"), get_node("Character2")]
onready var link = get_node("Link")

export (bool) var linked = true
export (int) var selected = 0

func _ready():
	emit_signal('selected_changed', selected)

func _process(delta):
	update_link()
	
	var direction = 0
	
	if Input.is_action_pressed("walk_right"):
		direction += 1
	if Input.is_action_pressed("walk_left"):
		direction -= 1
	
	if linked:
		for chracter in characters:
			chracter.move(direction)
	if not linked:
		characters[selected].move(direction)

func update_link():
	link.visible = linked
	link.set_point_position(0, characters[0].global_position)
	link.set_point_position(1, characters[1].global_position)

func _input(event):
	if event.is_action_pressed("jump"):
		if linked:
			for chracter in characters:
				chracter.jump()
		if not linked:
			characters[selected].jump()
			
	if event.is_action_pressed("toggle_selected"):
		selected += 1
		if selected > characters.size()-1:
			selected = 0
		emit_signal('selected_changed', selected)
	if event.is_action_pressed("toggle_linked"):
		linked = not linked
