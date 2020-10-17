extends "res://Items/Weapon.gd"

var spin = Vector3()

onready var Model = $Mesh

func shoot(Attacker):
	$Anim.play("Shoot")
	var s = shell.instance()
	add_child(s)
	s.set_as_toplevel(true)
	var current_spread = Vector2(rand_range(-spread.x,spread.x),rand_range(-spread.y,spread.y))

	if $RayCast.is_colliding():
		var Target = $RayCast.get_collider()
		print("magnum hit" + Target.get_name())
		if Target.is_in_group("crit"):
			Target.get_parent().health -= crit
			print("Hit! Enemy health: " + str(Target.get_parent().health))
		elif Target.is_in_group("normal"):
			Target.get_parent().health -= damage
			print("Hit! Enemy health: " + str(Target.get_parent().health))
		else:
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
