extends TextureButton
@onready var bg: TextureRect = $"../BG"

func _process(_delta: float) -> void:
	self.modulate = bg.modulate

var animating := false
func _on_pressed() -> void:
	if !animating:
		animating = true
		var og_position = position
		var tween = get_tree().create_tween()
		tween.tween_property(self,"position",position-Vector2(0,get_window().size.y/25.0),.2)
		tween.tween_callback(func():
			var new_tween = get_tree().create_tween()
			new_tween.tween_property(self,"position",og_position,.2)
			new_tween.tween_callback(func(): animating = false))
