extends Node

signal linked_changed

func change_linked(character):
	emit_signal("linked_changed", character)
