extends KinematicBody

var linear_velocity = Vector3()
var state = "idle"
var Target = null

var health = 4

func _physics_process(delta):
	#GRAVITY
	linear_velocity.y -= 10 * delta
	linear_velocity = move_and_slide(linear_velocity, Vector3.UP)
	#FRICTION
	linear_velocity.x /= 1.1
	linear_velocity.z /= 1.1
	
	#STATE
	if has_method(state):
		call(state)
	
	#HEALTH
	if health < 1:
		queue_free()

onready var direct_state = get_world().direct_space_state
func _on_Sight_body_shape_entered(body_id, body, body_shape, area_shape):
	if state == "idle":
		if body.get_name() == "Player":
			print("Sensing player. Attempting line of sight.")
			Target = body
			state = "seeking"

func can_see(Target):
	var collision = direct_state.intersect_ray(transform.origin + Vector3(0,2,0), Target.transform.origin + Vector3(0,2,0))
	if collision:
		return false
	else:
		return true

func seeking():
	if can_see(Target):
		if $Reaction.is_stopped():
			$Reaction.start()
			print("Noticed player...")


func _on_Reaction_timeout():
	#$Hand.look_at(Target.transform.origin)
	$Hand/OmniLight.show()
	if can_see(Target):
		Target.health -= 1
	state = "idle"
