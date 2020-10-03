extends "res://Items/Weapon.gd"
onready var b_decal = preload("res://Items/BulletDecal.tscn")

func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	if Input.is_action_just_pressed("primary"):
		print("Hello")
		if $RayCast.is_colliding():
			#$Particles.emitting = true
			var b = b_decal.instance()
			$RayCast.get_collider().add_child(b)
			b.set_as_toplevel(true)
			b.global_transform.origin = $RayCast.get_collision_point()
			b.look_at($RayCast.get_collision_point() + $RayCast.get_collision_normal(), Vector3.UP)
		else:
			#$Particles.emitting = true
			pass
