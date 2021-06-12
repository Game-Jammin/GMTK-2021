extends Character

export (float) var connection_distance = 300
var linked_character = null

var direction = 0
var mouse_down = false

func move():
	direction = 0
	if Input.is_action_pressed("walk_right"):
		direction += 1
	if Input.is_action_pressed("walk_left"):
		direction -= 1
	if direction != 0:
		velocity.x = lerp(velocity.x, direction * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
		
	if Input.is_action_just_pressed("jump"):
		jump()
		if linked_character:
			linked_character.jump()
			
	if linked_character:
		move_linked()

func move_linked():
	linked_character.update_direction(direction)

func _process(delta):
	if Input.is_action_pressed("left_click") or Input.is_action_pressed("right_click"):
		linked_character = null
	if Input.is_action_just_released("left_click"):
		#set linked character if mouse is over
		var linkable_characters = get_tree().get_nodes_in_group("LinkableCharacters")
		for character in linkable_characters:
			if character.mouse_over and global_position.distance_to(character.global_position) <= connection_distance:
				linked_character = character
				
	update_link()

func _physics_process(delta):
	move()
	if linked_character:
		move_linked()
		
	# Apply gravity to character
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func _input(event):
	if event.is_action_pressed("left_click"):
		mouse_down = true
	if event.is_action_released("left_click"):
		mouse_down = false

func update_link():
	if mouse_down:
		$Line2D.set_point_position(1,get_global_mouse_position()-position)
	elif linked_character:
		$Line2D.set_point_position(1,linked_character.global_position-position)
	else:
		$Line2D.set_point_position(1,Vector2.ZERO)
	
