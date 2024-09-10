extends Node3D

@onready var player_node = get_node("../../Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#print(str(player_node.global_position.z) + " " + str(global_position.z))
	if(player_node.global_position.z > global_position.z + 200):
		queue_free()
		print("Delete")
