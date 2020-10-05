extends KinematicBody

var linear_velocity = Vector3()
var state = "idle"
var Target = null

func _physics_process(delta):
	#GRAVITY
	linear_velocity.y -= 10 * delta
	linear_velocity = move_and_slide(linear_velocity, Vector3.UP)
	#FRICTION
	linear_velocity.x /= 1.1
	linear_velocity.y /= 1.1
	
	#STATE
	if has_method(state):
		call(state)

onready var direct_state = get_world().direct_space_state
func _on_Sight_body_shape_entered(body_id, body, body_shape, area_shape):
	if state == "idle":
		if body.get_name() == "Player":
			print("Sensing player. Attempting line of sight.")
			Target = body
			state = "seeking"

func seeking():
	var collision = direct_state.intersect_ray(transform.origin + Vector3(0,2,0), Target.transform.origin + Vector3(0,2,0))
	if collision:
		print("No" + str(collision.position))
	else:
		print("Can See")
