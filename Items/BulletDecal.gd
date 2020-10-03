extends Spatial

func _ready():
	print("I'm alive!")

func _on_Timer_timeout():
	queue_free()
