extends Control
@onready var bg: TextureRect = $BG

func _process(_delta: float) -> void:
	var red_modifier = Global.joules/400000.0
	bg.modulate = Color(1.0,1.0-red_modifier,1.0-red_modifier)

const bg_textures := [
	preload("uid://bnmbwcjhgbpmx"),
	preload("uid://dwrw876kydkcp"),
	preload("uid://dglbluotapda0"),
	preload("uid://dwwxss5ie7ulk")
]
var texture_index := 0
var awakening := false
func _on_timer_timeout() -> void:
	if awakening:
		texture_index -= 1
	else:
		texture_index += 1
	if texture_index+1 >= len(bg_textures):
		awakening = true
	elif texture_index <= 0:
		awakening = false
	bg.texture = bg_textures[texture_index]
