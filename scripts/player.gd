extends RigidBody3D
#
#@export var rolling_force = 80
#@export var jump_force = 1000
#@export var down_force = 1100
#
#@onready var bg_music = get_node("/root/Main/BGMusic")
#@onready var die_sfx = get_node("/root/Main/DieSFX")
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#$CameraRig.top_level = true
	#$FloorCheck.top_level = true
	##linear_velocity = Vector3.ZERO
#
#var last_jumped = 0
#
#var can_move = false
#var is_dead = false
#
#var deathAnimElapsed = 0.0
#
#var originalBounce = physics_material_override.bounce
#
#func _process(delta):
	#if(is_dead):
		#var min_angle = deg_to_rad(0.0)
		#var max_angle = deg_to_rad(5.0)
		#
		#$CameraRig.rotation.x = lerp_angle(min_angle, max_angle, deathAnimElapsed)
		#deathAnimElapsed += delta
		#bg_music.volume_db -= 1.5*delta
		#bg_music.pitch_scale = max(bg_music.pitch_scale-0.5*delta,0.01)
		#
#
#var used_down_force = false
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta: float) -> void:
	#$CameraRig.global_rotation = Vector3.ZERO
	#var last_cam_pos = $CameraRig.global_transform.origin
	#var ball_pos = global_transform.origin
	#var new_cam_pos = lerp(last_cam_pos,ball_pos,0.13)
	#if(is_dead):
		#new_cam_pos = lerp(last_cam_pos,ball_pos+Vector3(0,12,-5),0.03)
		#
	#$CameraRig.global_transform.origin = new_cam_pos
	#
	#$FloorCheck.global_transform.origin = ball_pos
	#
	#var is_on_floor = $FloorCheck.is_colliding()
	#
	#if Input.is_action_pressed("LeftMove") and can_move:
		#apply_central_impulse(Vector3(rolling_force,0,0))
	#if Input.is_action_pressed("RightMove") and can_move:
		#apply_central_impulse(Vector3(-rolling_force,0,0))
		#
	#if Input.is_action_pressed("DownMove") and not Input.is_action_pressed("Jump") and can_move and not used_down_force and not is_on_floor:
		#apply_central_impulse(Vector3(0,-down_force,3))
		#physics_material_override.bounce = 0
		#used_down_force = true
		#
		##if Input.is_key_pressed(KEY_QUOTELEFT) and not is_dead:
			##freeze = true
		##elif not is_dead:
			##freeze = false
		#
	#if is_on_floor:
		#physics_material_override.bounce = originalBounce
		#used_down_force = false
		#can_move = true
		#apply_central_impulse(Vector3(0,-1,13))
		#var now_time = Time.get_ticks_msec()
		#if Input.is_action_pressed("Jump") and now_time - last_jumped > 100:
			#last_jumped = now_time
			#apply_central_impulse((Vector3.UP-Vector3.FORWARD/4)*jump_force)
	#else:
		#apply_central_impulse(Vector3(0,-13,5))
		#
	#for node in get_colliding_bodies():
		##print(node.get_groups())
		#if not is_dead and (node.is_in_group("DeathBlock") or Input.is_key_pressed(KEY_R)):
			##print("DIEE")
			#start_die()
			#
			##get_tree().reload_current_scene()
#
#func start_die(down = false):
	#is_dead = true
	#if down:
		#$Particles.global_rotation = Vector3(-100,0,0)
		#$Particles.speed_scale = 1.8
	#else:
		#$Particles.global_rotation = Vector3(-50,0,0)
		#
		#
	#$Particles.emitting = true
	#$Model.visible = false
	#freeze = true
	#$DeathTimer.start()
	#die_sfx.play()
#
#func _on_death_timer_timeout() -> void:
	#get_tree().reload_current_scene()
