extends "res://Items/Weapon.gd"

var spin = Vector3()

func shoot(Attacker):
	var current_spread = Vector2(rand_range(-spread.x,spread.x),rand_range(-spread.y,spread.y))
	print(current_spread)

	if $RayCast.is_colliding():
		var Target = $RayCast.get_collider()
		if not Target.get("health") == null:
			Target.health -= damage.normal
		bullet_hole()
	#SPREAD
	$RayCast.rotation += Vector3(deg2rad(current_spread.x),deg2rad(current_spread.y),0)
	#KICK
	if Attacker.get_name() == "Player":
		Attacker.angular_velocity.x += spin.x
		Attacker.angular_velocity.y += spin.y
		spin.x += rand_range(deg2rad(-kick.x),deg2rad(kick.x))
		spin.y += deg2rad(kick.y)
		spin /= stability

func _physics_process(_delta):
	$RayCast.rotation /= stability
