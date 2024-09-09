extends RigidBody3D

@export var rolling_force = 40
@export var jump_force = 1000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CameraRig.top_level = true
	$FloorCheck.top_level = true
	pass

var last_jumped = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	$CameraRig.global_rotation = Vector3.ZERO
	var last_cam_pos = $CameraRig.global_transform.origin
	var ball_pos = global_transform.origin
	var new_cam_pos = lerp(last_cam_pos,ball_pos,0.1)
	$CameraRig.global_transform.origin = new_cam_pos
	
	$FloorCheck.global_transform.origin = ball_pos
	
	#if Input.is_action_pressed("ForwardMove"):
		#angular_velocity.x -= rolling_force*delta
	#if Input.is_action_pressed("BackMove"):
		#angular_velocity.x += rolling_force*delta
	if Input.is_action_pressed("LeftMove"):
		#angular_velocity.z = 200000*delta
		apply_central_impulse(Vector3(-rolling_force,0,0))
		#apply_torque_impulse(Vector3(0,0,50000))
		#angular_velocity.z += rolling_force*delta
	if Input.is_action_pressed("RightMove"):
		apply_central_impulse(Vector3(rolling_force,0,0))
		#apply_torque_impulse(Vector3(0,0,-50000))
		#rotate_z(-20*delta)
		#angular_velocity.z = -200000*delta
	#angular_velocity.z = sign(angular_velocity.z) * min(abs(angular_velocity.z),max_speed)
		
	#apply_central_force(Vector3(0,-20,0))
	apply_central_impulse(Vector3(0,0,-8))
	#angular_velocity.x += -1
	var is_on_floor = $FloorCheck.is_colliding()
	var now_time = Time.get_ticks_msec()
	if Input.is_action_just_pressed("Jump") and is_on_floor and now_time - last_jumped > 1000:
		last_jumped = now_time
		apply_central_impulse((Vector3.UP+Vector3.FORWARD/2)*jump_force)
