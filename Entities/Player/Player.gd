extends KinematicBody

const speed = {walk = 4, run = 10, crouch = 2, air = 0.01}
const friction = {ground = 0.7, air = 1}
const sensitivity = {mouse = 0.04}
const gravity = 60
const jump = 20

var input_speed = Vector3()
var linear_velocity = Vector3()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	#LATERAL INPUT
	var direction = Vector3()
	if Input.is_action_pressed("forward"):
		direction -= transform.basis.z
	if Input.is_action_pressed("backward"):
		direction += transform.basis.z
	if Input.is_action_pressed("left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("right"):
		direction += transform.basis.x
	
	#DETERMINE SPEED
	if Input.is_action_pressed("crouch"):
		input_speed = speed.crouch
	elif Input.is_action_pressed("walk"):
		input_speed = speed.walk
	else:
		input_speed = speed.run
	
	if is_on_floor():
		linear_velocity += direction.normalized() * input_speed
	else:
		linear_velocity += direction.normalized() * speed.air
	
	#GRAVITY
	linear_velocity.y -= gravity * delta
	
	#FRICTION
	if is_on_floor():
		linear_velocity.x *= friction.ground
		linear_velocity.z *= friction.ground
	else:
		linear_velocity.x *= friction.air
		linear_velocity.z *= friction.air
	
	if is_on_floor():
		print("On floor")
		if Input.is_action_just_pressed("jump"):
			linear_velocity.y += jump
	else:
		print("Not on floor")

	linear_velocity = move_and_slide(linear_velocity, Vector3.UP)
	
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * sensitivity.mouse))
		$Head.rotate_x(deg2rad(-event.relative.y * sensitivity.mouse))
		$Head.rotation.x = clamp($Head.rotation.x, deg2rad(-90), deg2rad(90))
