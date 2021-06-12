extends KinematicBody2D

class_name Character

export (int) var speed = 500
export (int) var jump_speed = -600
export (int) var gravity = 2500

export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

var velocity = Vector2.ZERO

#func move(direction):
#	velocity.x = lerp(velocity.x, direction * speed, acceleration)

func jump():
	if is_on_floor():
		velocity.y = jump_speed
