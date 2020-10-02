extends KinematicBody

const speed = {walk = 8, run = 20, air = 0.2}
const friction = {ground = 0.7, air = 0.99}
const sensitivity = {mouse = 0.03}
const gravity = 100
const jump = 20

var linear_velocity = Vector3()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	var direction = Vector3()
	if Input.is_action_pressed("forward"):
		direction -= transform.basis.z
	if Input.is_action_pressed("backward"):
		direction += transform.basis.z
	if Input.is_action_pressed("left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("right"):
		direction += transform.basis.x
	
	if is_on_floor():
		linear_velocity += direction.normalized() * speed.walk
	else:
		linear_velocity += direction.normalized() * speed.air
	
	#GRAVITY
	if is_on_floor():
		linear_velocity += -get_floor_normal() * gravity * delta
		linear_velocity.x *= friction.ground
		linear_velocity.z *= friction.ground
		if Input.is_action_just_pressed("jump"):
			linear_velocity.y = jump 
		print("Yes")
	else:
		linear_velocity += Vector3.DOWN * gravity * delta
		linear_velocity.x *= friction.air
		linear_velocity.z *= friction.air
		print("No")
	
	#INT CONVERSION
	var x = int(linear_velocity.x)
	var y = int(linear_velocity.y)
	var z = int(linear_velocity.z)
	linear_velocity = Vector3(x,y,z)
	
	linear_velocity = move_and_slide(linear_velocity, Vector3.UP)
	print(linear_velocity)
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * sensitivity.mouse))
		$Head.rotate_x(deg2rad(-event.relative.y * sensitivity.mouse))
		$Head.rotation.x = clamp($Head.rotation.x, deg2rad(-90), deg2rad(90))
