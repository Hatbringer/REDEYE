extends RigidBody

onready var b_decal = preload("res://Items/BulletDecal.tscn")

export(float) var damage = 0
export(float) var crit = 0
export var spread = Vector2(0,0)
export(float) var stability = 2
export var kick = Vector2(0,0)
export(float) var drift = 1
export(int) var ammo = 6

func equip(target):
	print("equiped")
	get_parent().remove_child(self)
	target.find_node("Hand").add_child(self)
	mode = RigidBody.MODE_STATIC
	translation = Vector3(0,0,0)
	rotation = Vector3(0,0,0)
	if has_node("EquipSFX"):
		find_node("EquipSFX").play()

func drop():
	set_as_toplevel(true) #Needed to maintain global position
	var current_scene = get_tree().get_current_scene()
	get_parent().remove_child(self)
	current_scene.add_child(self)
	mode = RigidBody.MODE_RIGID
	visible = true
	set_as_toplevel(false)
	apply_central_impulse(-transform.basis.z * 5) #Needed to wake up node

func bullet_hole():
	var BulletHole = b_decal.instance()
	$RayCast.get_collider().add_child(BulletHole)
	#BulletHole.set_as_toplevel(true)
	BulletHole.global_transform.origin = $RayCast.get_collision_point()
	BulletHole.look_at($RayCast.get_collision_point() + $RayCast.get_collision_normal(), Vector3.UP)
