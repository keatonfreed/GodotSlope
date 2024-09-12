extends Node

@export var bg_defs: Array[PackedScene] = []
@onready var player_node = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var bg_spawn_dist = 700
var bg_current_z = 0
var bg_current_y = 0
var bg_ind = 0;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	while(player_node.global_position.z > bg_current_z-bg_spawn_dist):
		var rand_bg_ind = randi_range(0,len(bg_defs)-1)
		var bg_spawn_x = randf_range(-30,30)
		#if(bg_ind == 0):
			#rand_bg_ind = 0
			#bg_spawn_x = 0
		
		var new_bg = bg_defs[rand_bg_ind].instantiate()
				
		add_child(new_bg)
		#print("Made " + str(rand_bg_ind) + " with " + str(bg_defs[rand_bg_ind]))
		new_bg.transform = Transform3D.IDENTITY
		#new_bg.position = Vector3(0,bg_index * (-bg_height),bg_index * bg_length)
		new_bg.global_transform.origin = Vector3(bg_spawn_x,bg_current_y,bg_current_z)
		bg_current_z += 100
		bg_current_y -= 100
		bg_ind += 1
		#$Ramp.global_position.z = player_node.global_position.z
