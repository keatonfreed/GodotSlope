extends Node3D

@onready var player_node = get_node("/root/Main/Player")
@onready var obs_spawner = get_node("/root/Main/Objects")

func _ready() -> void:
	#global_rotation = rand
	pass

var rot_x = randf_range(0,1)
var rot_y = randf_range(0,1)
var rot_z = randf_range(0,1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#print(str(player_node.global_position.z) + " " + str(global_position.z))
	if(player_node.global_position.z > global_position.z ):
		#print(global_position.y)
		#print("at: " + str(global_transform.origin.y))
		obs_spawner.move_star(self)
		#print("Delete")
	global_rotate((Vector3(rot_x,rot_y,rot_z)*delta).normalized(),0.05)


func _on_body_entered(body: Node3D) -> void:
	pass # Replace with function body.
