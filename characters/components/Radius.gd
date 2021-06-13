extends Sprite

var scale_factor = 500
var target_scale = Vector2.ZERO

func _ready():
	var link_radius = get_parent().link_radius
	
	var new_scale = 1/float(scale_factor) * float(link_radius)
	
	target_scale = Vector2(new_scale, new_scale)
	
func show():
	$AnimationPlayer.play("Radius Rotate")
	visible = true
	$Tween.interpolate_property(self, "scale", scale, target_scale, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	
func hide():
	$Tween.interpolate_property(self, "scale", scale, Vector2.ZERO, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	visible = false
	$AnimationPlayer.stop()
