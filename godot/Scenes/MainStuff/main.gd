extends Control
@onready var bg: TextureRect = $BG

func _process(_delta: float) -> void:
	var red_modifier = Global.joules/400000.0
	bg.modulate = Color(1.0,1.0-red_modifier,1.0-red_modifier)
