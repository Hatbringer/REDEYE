extends "res://Items/Weapon.gd"

func _ready():
	pass # Replace with function body.
	
func shoot():
	var current_spread = Vector2(rand_range(-spread.x,spread.x),rand_range(-spread.y,spread.y))
	print(current_spread)

	if $RayCast.is_colliding():
		var Target = $RayCast.get_collider()
		if not Target.get("health") == null:
			Target.health -= damage.normal
		bullet_hole()
	#SPREAD
	$RayCast.rotation += Vector3(deg2rad(current_spread.x),deg2rad(current_spread.y),0)

func _physics_process(delta):
	$RayCast.rotation /= stability
