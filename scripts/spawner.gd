extends Node

@export var ramp_defs: Array[RampDef] = []
@export var bg_scenes: Array[PackedScene] = []
@onready var player_node = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var ramp_spawn_dist = 400
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
		
		var new_object = ramp_defs[rand_ramp_ind].ramp_scene.instantiate()
		
		#var new_bg = bg_scenes[0].instantiate()
		
		add_child(new_object)
		#print("Made " + str(rand_ramp_ind) + " with " + str(ramp_defs[rand_ramp_ind]))
		new_object.transform = Transform3D.IDENTITY
		#new_object.position = Vector3(0,ramp_index * (-ramp_height),ramp_index * ramp_length)
		new_object.global_transform.origin = Vector3(ramp_spawn_x,ramp_current_y,ramp_current_z)
		ramp_current_z += ramp_defs[rand_ramp_ind].ramp_length
		ramp_current_y -= ramp_defs[rand_ramp_ind].ramp_height
		ramp_ind += 1
		#$Ramp.global_position.z = player_node.global_position.z
