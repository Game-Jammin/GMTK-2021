extends Label

onready var fuse_timer = get_parent().get_node("FuseTimer")

func _process(_delta):
	visible = not fuse_timer.is_stopped()
	
	set_text('%d' % fuse_timer.time_left)
