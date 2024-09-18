extends Camera3D


var g = 0 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(position)
	print(rotation)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	g+=delta
	if(g>1):
		g=0
		print(position)
		print(rotation)
	pass
