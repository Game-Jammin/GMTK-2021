extends AnimatedSprite

export (Array, int) var footstep_frames

func _ready():
	connect("frame_changed", self, "_on_frame_changed")
	
func _on_frame_changed():
	if "Run" in animation:
		if frame in footstep_frames:
			$Footsteps.play()
