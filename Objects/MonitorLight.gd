extends OmniLight

onready var brightness = omni_range

export var flicker = 0

func _process(_delta):
	omni_range = brightness + rand_range(-flicker, flicker)
