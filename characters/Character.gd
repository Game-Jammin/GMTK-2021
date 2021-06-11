extends KinematicBody2D

export (int) var speed = 1200
export (int) var jump_speed = -1800
export (int) var gravity = 4000

export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

export (int) var character_number = 0

var velocity = Vector2.ZERO
var direction = 0

func _ready():
	get_parent().connect("selected_changed", self, "_on_selected_changed")

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func move(direction):
	velocity.x = lerp(velocity.x, direction * speed, acceleration)

func jump():
	if is_on_floor():
		velocity.y = jump_speed

func _on_selected_changed(selected):
	if character_number == selected:
		$Selected.visible = true
	else:
		$Selected.visible = false
