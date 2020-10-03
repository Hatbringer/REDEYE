extends KinematicBody

const speed = {walk = 4, run = 8, crouch = 2, air = 0.01}
const friction = {ground = 0.7, air = 1}
const sensitivity = {mouse = 0.04}
const gravity = {up = 30, down = 50}
const jump = 10

onready var Interact = $Head/Camera/Interact

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
	
	#Crouching
	if Input.is_action_pressed("crouch"):
		$Hitbox.shape.height -= 100 * delta
	elif !$Roof.is_colliding():
		$Hitbox.shape.height += 16 * delta
	$Hitbox.shape.height = clamp($Hitbox.shape.height, 1, 4)
	
	if is_on_floor():
		linear_velocity += direction.normalized() * input_speed
	else:
		linear_velocity += direction.normalized() * speed.air
	
	#GRAVITY
	if Input.is_action_pressed("jump") and linear_velocity.y > 0:
		linear_velocity.y -= gravity.up * delta
	else:
		linear_velocity.y -= gravity.down * delta
	
	#FRICTION
	if is_on_floor():
		linear_velocity.x *= friction.ground
		linear_velocity.z *= friction.ground
	else:
		linear_velocity.x *= friction.air
		linear_velocity.z *= friction.air
	
	if is_on_floor():
		#print("On floor")
		if Input.is_action_just_pressed("jump"):
			linear_velocity.y += jump
	else:
		#print("Not on floor")
		pass

	linear_velocity = move_and_slide(linear_velocity, Vector3.UP)
	
	#QUIT GAME
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

	#PICKUP WEAPON
	if Interact.is_colliding():
		var Body = Interact.get_collider()
		print(Body.get_name())
		if Body.is_in_group("weapon"):
			Body.equip(self)
			print("Sucess!")
		
#Camera rotation
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * sensitivity.mouse))
		$Head.rotate_x(deg2rad(-event.relative.y * sensitivity.mouse))
		$Head.rotation.x = clamp($Head.rotation.x, deg2rad(-90), deg2rad(90))
