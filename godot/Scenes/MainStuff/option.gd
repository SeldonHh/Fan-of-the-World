extends Panel
@onready var h_slider: HSlider = $HSlider

func _process(_delta: float) -> void:
	Global.volume = h_slider.value
	if Input.is_action_just_pressed("menu"):
		visible = !visible
