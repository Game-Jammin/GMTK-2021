extends Node

signal linked_changed
signal shake_camera

func change_linked(character):
	emit_signal("linked_changed", character)

func shake_screen(duration, frequency, amplitude, priority):
	emit_signal("shake_camera", duration, frequency, amplitude, priority)
