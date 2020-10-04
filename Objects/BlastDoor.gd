extends Spatial

onready var Sensors = $Area
onready var Player = get_tree().current_scene.find_node("Player")

func _physics_process(delta):
	if Sensors.overlaps_body(Player):
		$KinematicBody.translation.y -= ($KinematicBody.translation.y + 3.9) / 10
	else:
		$KinematicBody.translation.y /= 1.1

func _on_Area_body_shape_entered(body_id, body, body_shape, area_shape):
	if body == Player:
		$AudioStreamPlayer3D.play()


func _on_Area_body_exited(body):
	if body == Player:
		$AudioStreamPlayer3D.play()
