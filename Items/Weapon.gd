extends RigidBody

func equip(target):
	get_parent().remove_child(self)
	target.find_node("Hand").add_child(self)
	mode = RigidBody.MODE_STATIC
	translation = Vector3(0,0,0)
	rotation = Vector3(0,0,0)
