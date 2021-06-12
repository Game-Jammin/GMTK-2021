extends KinematicBody2D

class_name Character

export (bool) var is_escort = false

export (int) var speed = 500
export (int) var jump_speed = -600
export (int) var gravity = 2500

export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

export (float) var coyote_time = 0.05

export (float) var fuse_length = 10

var can_jump = false

var direction = 0
var velocity = Vector2.ZERO

func _ready():
	Global.connect("linked_changed", self, '_on_linked_changed')

func jump():
	if can_jump:
		velocity.y = jump_speed

func coyoteTime():
	yield(get_tree().create_timer(coyote_time), 'timeout')
	can_jump = false

func _on_linked_changed(character):
	print (character)
	if character == null:
		if $FuseTimer.is_stopped():
			$FuseTimer.start(fuse_length)
	elif is_escort:
		$FuseTimer.stop()
	elif not is_escort:
		if character.name == name:
			if $FuseTimer.is_stopped():
				$FuseTimer.start(fuse_length)
		else:
			$FuseTimer.stop()
