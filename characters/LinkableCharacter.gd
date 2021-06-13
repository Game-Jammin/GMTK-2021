extends Character
class_name LinkableCharacter

var mouse_over = false

export (bool) var satisfied = false

func update_direction(new_direction):
	direction = new_direction

func move():
	if direction != 0:
		velocity.x = lerp(velocity.x, direction * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
		
	if direction != 0:
		facing_right = direction > 0

func _process(_delta):
	animation_handler()
	
func _physics_process(delta):
	if is_on_floor():
		can_jump = true
	animation_handler()
	move()
	# Apply gravity to character
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func link():
	$Link.play()
	
func unlink():
	direction = 0
	$Unlink.play()
