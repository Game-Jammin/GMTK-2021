extends Area2D

func _on_PanicsHouse_body_entered(body):
	if "Manic" in body.name:
		get_parent().lose()
	if "Panic" in body.name:
		body.satisfied = true
