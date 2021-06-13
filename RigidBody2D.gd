extends RigidBody2D

onready var just_aired_timer : Timer = $JustAiredTimer
onready var _transitions: = {
	IDLE: [RUN, AIR],
	RUN: [IDLE, AIR],
	AIR: [IDLE],
}

const FLOOR_NORMAL := Vector2.UP

enum {
	IDLE,
	RUN,
	AIR,
}

export (bool) var player := false
export var move_speed := 400.0
export var air_speed := 10.0
export var jump_force := 500.0

var _state: int = IDLE

var states_strings := {
	IDLE: "idle",
	RUN: "run",
	AIR: 'air',
}

var move_direction := Vector2.ZERO
var is_jumping := false

func _integrate_forces(state):
	var is_on_ground = state.get_contact_count() > 0 and int(state.get_contact_collider_position(0).y) >= int(global_position.y)
	
	if (player):
		move_direction = get_move_direction()
	
	match _state:
		IDLE:
			if move_direction.x:
				change_state(RUN)
			elif is_on_ground and is_jumping:
				apply_central_impulse(Vector2.UP * jump_force)
				change_state(AIR)
		
		RUN:
			if not move_direction.x:
				change_state(IDLE)
			elif state.get_contact_count() == 0:
				change_state(AIR)
			elif is_on_ground and is_jumping:
				apply_central_impulse(Vector2.UP * jump_force)
				change_state(AIR)
			else:
				state.linear_velocity.x = move_direction.x * move_speed
				
		AIR:
			if move_direction.x:
				state.linear_velocity.x = move_direction.x * air_speed
			if is_on_ground and just_aired_timer.is_stopped():
				change_state(IDLE)
				
	is_jumping = false
				
func change_state(target_state):
	if not target_state in _transitions[_state]:
		return
	_state = target_state
	enter_state()
	
func enter_state():
	match _state:
		IDLE:
			linear_velocity.x = 0
		AIR:
			just_aired_timer.start()
		_:
			return

func get_move_direction():
	return Vector2(
		Input.get_action_strength("walk_right") - Input.get_action_strength("walk_left"),
		0.0
	)

func _input(event):
	if event.is_action_pressed("jump") and player:
		is_jumping = true

func set_move_direction(new_direction):
	move_direction = new_direction
	
func jump():
	is_jumping = true
