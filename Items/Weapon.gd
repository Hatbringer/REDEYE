extends RigidBody

func equip(target):
	get_parent().remove_child(self)
	target.find_node("Hand").add_child(self)
