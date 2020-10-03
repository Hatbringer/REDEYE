extends RigidBody

func equip(target):
	get_parent().remove_child(self)
	target.find_node("Hand").add_child(self)
	mode = RigidBody.MODE_STATIC
	translation = Vector3(0,0,0)
	rotation = Vector3(0,0,0)

func drop():
	set_as_toplevel(true) #Needed to maintain global position
	var current_scene = get_tree().get_current_scene()
	get_parent().remove_child(self)
	current_scene.add_child(self)
	mode = RigidBody.MODE_RIGID
	visible = true
	set_as_toplevel(false)
	apply_central_impulse(-transform.basis.z * 5) #Needed to wake up node
