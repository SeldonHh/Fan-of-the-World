extends TextureButton
@onready var cat_sfx: AudioStreamPlayer = $cat_sfx
const MEOW_1_SFX = preload("uid://7csh3xv5k72o")
const MEOW_2_SFX = preload("uid://dicg8vjyul34d")
const CAT = preload("uid://c0o0scc6d73n8")
const CAT_HAPPY = preload("uid://byk5634nwso25")

var pet_cat := true
func _on_pressed() -> void:
	if pet_cat:
		self.texture_normal = CAT_HAPPY
		Global.motivation.add_motivation(1)
		cat_sfx.pitch_scale = randf_range(0.9,1.1)
		cat_sfx.stream = [MEOW_1_SFX,MEOW_2_SFX].pick_random()
		cat_sfx.play()
		var tween = get_tree().create_tween()
		tween.tween_property(self,"position",Vector2(position.x,position.y-5),.2)
		tween.tween_callback(func(): 
			var new_tween = get_tree().create_tween()
			new_tween.tween_property(self,"position",Vector2(position.x,position.y+5),.2)
			new_tween.tween_callback(func(): 
				pet_cat = true))
	


func _on_timer_timeout() -> void:
	if pet_cat:
		self.texture_normal=CAT
