extends Position2D

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT

export (bool) var follow = false
onready var camera = $Camera2D

var characters = []

export (int) var vertical_offset = 400

var priority = 0
var amplitude = 0

func _ready():
	Global.connect('shake_camera', self, '_on_shake_camera')
	global_position.y = vertical_offset

func _process(_delta):
	if follow:
		characters = get_tree().get_nodes_in_group("Characters")
		if (characters.size() > 0):
			var total_postion = Vector2.ZERO
			for character in characters:
				total_postion += character.global_position
			var midpoint = total_postion/characters.size() 
			midpoint.y = midpoint.y - vertical_offset
			global_position = midpoint

func _on_shake_camera(duration = 0.2, frequency = 15, amplitude = 16, priority = 0):
	if priority >= self.priority:
		
		self.priority = priority
		self.amplitude = amplitude
		
		$Duration.wait_time = duration
		$Frequency.wait_time = 1 / float(frequency)
		
		$Duration.start()
		$Frequency.start()
		
		_new_shake()

func _new_shake():
	var rand = Vector2()
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)
	
	$ShakeTween.interpolate_property(camera, "offset", camera.offset, rand, $Frequency.wait_time, TRANS, EASE)
	$ShakeTween.start()

func _reset():
	$ShakeTween.interpolate_property(camera, "offset", camera.offset, Vector2(), $Frequency.wait_time, TRANS, EASE)
	$ShakeTween.start()
	
	priority = 0

func _on_Frequency_timeout():
	_new_shake()

func _on_Duration_timeout():
	_reset()
	$Frequency.stop()
