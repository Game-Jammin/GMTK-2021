extends Character
class_name LinkableCharacter

var mouse_over = false

func update_direction(new_direction):
	direction = new_direction

func move():
	if direction != 0:
		velocity.x = lerp(velocity.x, direction * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)

func _process(_delta):
	animation_handler()

func _physics_process(delta):
	if is_on_floor():
		can_jump = true
		
	move()
	direction = 0
	# Apply gravity to character
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
