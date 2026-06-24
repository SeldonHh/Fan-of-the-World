extends Panel
@onready var h_slider: HSlider = $HSlider
@onready var h_slider_2: HSlider = $HSlider2

func _process(_delta: float) -> void:
	@warning_ignore("narrowing_conversion")
	Global.volume = h_slider.value
	@warning_ignore("narrowing_conversion")
	Global.sfx_volume = h_slider_2.value
	if Input.is_action_just_pressed("menu"):
		visible = !visible
	
