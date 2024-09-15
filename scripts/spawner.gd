extends Node

@export var ramp_defs: Array[RampDef] = []

@export var bg_defs: Array[PackedScene] = []

@onready var player_node = $"../Player"

var star_current_z = 0
var spawned_ramps:Array[Node3D] = []

var stars_spawned = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

var ramp_spawn_dist = 1000
var ramp_current_z = 0
var ramp_current_y = 0
var ramp_ind = 0;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	while(player_node.global_position.z > ramp_current_z-ramp_spawn_dist):
		var rand_ramp_ind = randi_range(0,len(ramp_defs)-1)
		var ramp_spawn_x = randf_range(-5,5)
		if(ramp_ind == 0):
			rand_ramp_ind = 0
			ramp_spawn_x = 0
		
		var new_ramp = ramp_defs[rand_ramp_ind].ramp_scene.instantiate()
			
		$Ramps.add_child(new_ramp)
		spawned_ramps.append(new_ramp)
		#print("Made " + str(rand_ramp_ind) + " with " + str(ramp_defs[rand_ramp_ind]))
		new_ramp.transform = Transform3D.IDENTITY
		#new_ramp.position = Vector3(0,ramp_index * (-ramp_height),ramp_index * ramp_length)
		new_ramp.global_transform.origin = Vector3(ramp_spawn_x,ramp_current_y,ramp_current_z)
		
			
			
		
			
		
		
	
		ramp_current_z += ramp_defs[rand_ramp_ind].ramp_length
		ramp_current_y -= ramp_defs[rand_ramp_ind].ramp_height
		ramp_ind += 1
		
		#star_current_z += float(ramp_defs[rand_ramp_ind].ramp_length) / star_amt
		
		#$Ramp.global_position.z = player_node.global_position.z
	if(stars_spawned == true): 
		return
		
	
	stars_spawned = true
	var star_amt = 1900
	for i in range(star_amt):
		var rand_bg_ind = randi_range(0,len(bg_defs)-1)
		var new_bg = bg_defs[rand_bg_ind].instantiate()
				
		$Backgrounds.add_child(new_bg)
		move_star(new_bg)
		#print("Made " + str(rand_bg_ind) + " with " + str(bg_defs[rand_bg_ind]))
		#new_bg.transform = Transform3D.IDENTITY
		
		#new_bg.position = Vector3(0,bg_index * (-bg_height),bg_index * bg_length)
		
			
func move_star(star: Node3D):
	var this_star_y = randi_range(-230,300)
		
	var this_star_x = randf_range(15,480)
	if(this_star_y>20):
		this_star_x = randf_range(0,480)
	
	var flip = randi_range(0,-1)
	if flip == 0:
		flip = 1
	
	this_star_y+=spawned_ramps[0].global_position.y
	#print("spawn: " + str(ramp_current_y))
	star.global_position = Vector3(this_star_x * flip,this_star_y,star_current_z)
	star_current_z += 0.4
	if(len(spawned_ramps) > 1):
		if(star_current_z >= spawned_ramps[1].global_position.z):
			spawned_ramps.remove_at(0)
