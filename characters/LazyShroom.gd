extends Character

export (float) var link_radius = 500
var linked_character = null

var mouse_down = false

var line_target = Vector2.ZERO

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
	
	if direction != 0:
		facing_right = direction > 0

func move_linked():
	linked_character.update_direction(direction)

func _process(_delta):
	$Radius.visible = Input.is_action_pressed("left_click")
	update_link()
	
	animation_handler()
	
	if Input.is_action_just_pressed("left_click") or Input.is_action_just_pressed("right_click"):
		if linked_character:
			linked_character.get_node("Unlink").play()
		linked_character = null
		Global.change_linked(linked_character)
	if Input.is_action_just_released("left_click"):
		#set linked character if mouse is over
		var linkable_characters = get_tree().get_nodes_in_group("LinkableCharacters")
		for character in linkable_characters:
			if character.mouse_over and global_position.distance_to(character.global_position) <= link_radius:
				linked_character = character
				linked_character.get_node("Link").play()
		Global.change_linked(linked_character)

func _physics_process(delta):
	if is_on_floor():
		can_jump = true
	
	# disconnect if characters move to far from each other
	if linked_character:
		if global_position.distance_to(linked_character.global_position) > link_radius:
			linked_character.get_node("Unlink").play()
			linked_character = null
			Global.change_linked(linked_character)
	
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
		line_target = get_global_mouse_position()-position
	elif linked_character:
		line_target = linked_character.global_position-position
	else:
		line_target = Vector2.ZERO
	
	# restrict the line_target to no go outside the radius
	if line_target.length() > link_radius:
		line_target = line_target.normalized() * link_radius
	
	if (linked_character):
		$Line2D.points[1] = line_target
	else:
		$Tween.interpolate_method(self, "update_line_point", $Line2D.points[1], line_target, 0.05)
		$Tween.start()

func update_line_point(new_pos):
	$Line2D.set_point_position(1, new_pos)
