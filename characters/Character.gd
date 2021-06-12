extends KinematicBody2D

class_name Character

export (int) var speed = 500
export (int) var jump_speed = -600
export (int) var gravity = 2500

export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

export (float, 0.1) var coyote_time = 0.05

var velocity = Vector2.ZERO

var can_jump = false

func jump():
	if can_jump:
		velocity.y = jump_speed

func coyoteTime():
	yield(get_tree().create_timer(coyote_time), 'timeout')
	can_jump = false
