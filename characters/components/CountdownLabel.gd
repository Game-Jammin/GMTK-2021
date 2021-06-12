extends Label

onready var fuse_timer = get_parent().get_node("FuseTimer")

func _process(delta):
	visible = not fuse_timer.is_stopped()
	
	set_text('%0.2f' % fuse_timer.time_left)