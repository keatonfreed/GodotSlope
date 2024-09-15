extends Node3D

@onready var player_node = get_node("/root/Main/Player")
@onready var score_text = get_node("/root/Main/Canvas/ScoreLabel")

var given_score = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if(player_node.global_position.z > global_position.z + 200):
		queue_free()
	
	if(player_node.global_position.z > global_position.z - 5 and not given_score):
		score_text.add_score()
		given_score = true
		#print("Delete")


func _on_body_entered(body: Node3D) -> void:
	pass # Replace with function body.
