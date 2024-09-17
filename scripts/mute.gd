extends Button

@onready var bg_music = get_node("/root/Main/BGMusic")
@onready var die_sfx = get_node("/root/Main/DieSFX")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_muted()

func _pressed() -> void:
	GlobalSettings.muted = !GlobalSettings.muted 
	update_muted()
	
func update_muted():
	bg_music.volume_db = -100 if GlobalSettings.muted else 0
	die_sfx.volume_db = -100 if GlobalSettings.muted else 0
	modulate.a = 1 if GlobalSettings.muted else 0.8
