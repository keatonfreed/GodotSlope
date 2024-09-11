extends RigidBody3D

@export var rolling_force = 75
@export var jump_force = 1000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CameraRig.top_level = true
	$FloorCheck.top_level = true
	#linear_velocity = Vector3.ZERO

var last_jumped = 0

var can_move = false
var is_dead = false

var deathAnimElapsed = 0.0

func _process(delta):
	if(is_dead):
		var min_angle = deg_to_rad(0.0)
		var max_angle = deg_to_rad(13.0)
		
		$CameraRig.rotation.x = lerp_angle(min_angle, max_angle, deathAnimElapsed)
		deathAnimElapsed += delta

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	$CameraRig.global_rotation = Vector3.ZERO
	var last_cam_pos = $CameraRig.global_transform.origin
	var ball_pos = global_transform.origin
	var new_cam_pos = lerp(last_cam_pos,ball_pos,0.1)
	if(is_dead):
		new_cam_pos = lerp(last_cam_pos,ball_pos+Vector3(0,4,-2),0.03)
		
	$CameraRig.global_transform.origin = new_cam_pos
	
	$FloorCheck.global_transform.origin = ball_pos
	
	if Input.is_action_pressed("LeftMove") and can_move:
		apply_central_impulse(Vector3(rolling_force,0,0))
	if Input.is_action_pressed("RightMove") and can_move:
		apply_central_impulse(Vector3(-rolling_force,0,0))
		
	var is_on_floor = $FloorCheck.is_colliding()
	if is_on_floor:
		can_move = true
		apply_central_impulse(Vector3(0,-1,5))
		var now_time = Time.get_ticks_msec()
		if Input.is_action_pressed("Jump") and now_time - last_jumped > 100:
			last_jumped = now_time
			apply_central_impulse((Vector3.UP-Vector3.FORWARD/4)*jump_force)
	else:
		apply_central_impulse(Vector3(0,-13,5))
		
	for node in get_colliding_bodies():
		#print(node.get_groups())
		if not is_dead and (node.is_in_group("DeathBlock") or Input.is_key_pressed(KEY_R)):
			#print("DIEE")
			is_dead = true
			$Particles.global_rotation = Vector3(-50,0,0)
			$Particles.emitting = true
			$Model.visible = false
			freeze = true
			$DeathTimer.start()
			#get_tree().reload_current_scene()



func _on_death_timer_timeout() -> void:
	get_tree().reload_current_scene()
