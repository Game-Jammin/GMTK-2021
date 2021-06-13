extends Area2D

func _on_Waterfall_body_entered(body):
	if "Manic" in body.name:
		get_parent().lose()
	if "Panic" in body.name:
		body.satisfied = true
		
	if body.is_in_group("Characters"):
		body.get_node("FuseTimer").paused = true

func _on_Waterfall_body_exited(body):
	if body.is_in_group("Characters"):
		body.get_node("FuseTimer").paused = false
