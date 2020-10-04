extends KinematicBody

var linear_velocity = Vector3()

func _physics_process(delta):
	#GRAVITY
	linear_velocity.y -= 10 * delta
	
	linear_velocity = move_and_slide(linear_velocity, Vector3.UP)
