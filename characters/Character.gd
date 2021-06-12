extends KinematicBody2D
class_name Character

onready var explosion = 'res://characters/components/Explosion.tscn'
onready var animate_sprite = $AnimatedSprite

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
	$FuseTimer.connect('timeout', self, '_on_FuseTimer_timeout')

func jump():
	if can_jump:
		can_jump = false
		velocity.y = jump_speed

func coyoteTime():
	yield(get_tree().create_timer(coyote_time), 'timeout')
	can_jump = false

func animation_handler():
	if is_on_floor():
		if direction == 0:
			#Idle
			animate_sprite.animation = "Idle"
		else:
			#Walking
			if direction > 0:
				animate_sprite.animation = "RunRight"
			else:
				animate_sprite.animation = "RunLeft"
	else:
		#Jump
		if direction > 0:
			animate_sprite.animation = "JumpRight"
		else:
			animate_sprite.animation = "Jumpleft"

func _on_linked_changed(character):
	if character == null:
		if $FuseTimer.is_stopped():
			$FuseTimer.start(fuse_length)
	elif is_escort:
		$FuseTimer.stop()
	elif not is_escort:
		if character.name != name:
			if $FuseTimer.is_stopped():
				$FuseTimer.start(fuse_length)
		else:
			$FuseTimer.stop()

func _on_FuseTimer_timeout():
	var new_explosion = load(explosion).instance()
	new_explosion.global_position = global_position
	get_parent().add_child(new_explosion)
	queue_free()
