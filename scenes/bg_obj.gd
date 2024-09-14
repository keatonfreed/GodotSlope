extends Node3D

@onready var player_node = get_node("/root/Main/Player")

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#print(str(player_node.global_position.z) + " " + str(global_position.z))
	if(player_node.global_position.z > global_position.z + 130):
		#print(global_position.y)
		#print("at: " + str(global_transform.origin.y))
		queue_free()
		#print("Delete")


func _on_body_entered(body: Node3D) -> void:
	pass # Replace with function body.
