extends ProgressBar

var tweening := false
@onready var speed_modifier_indicator: AutoSizeLabel = $speed_modifier_indicator
@onready var motivation_button: Button = $MotivationButton

func _on_button_pressed() -> void:
	add_motivation(1)

func add_motivation(amount):
	if !tweening:
		tweening = true
		var tween = get_tree().create_tween()
		tween.tween_property(self,"value",value+amount,.1)
		tween.tween_callback(func():
			tweening=false
			speed_modifier_indicator.text = str(1+value/100)+"x")

func _ready() -> void:
	Global.motivation= self
