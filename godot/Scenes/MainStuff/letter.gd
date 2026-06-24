extends TextureRect
@onready var sheet: TextureRect = $Sheet


func _ready() -> void:
	Global.letter = self

func tween_up():
		
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self,"anchor_top",.22,1)
	tween.parallel().tween_property(self,"anchor_bottom",.93,.7)
	tween.tween_callback(open)

func tween_down():
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"anchor_top",1.22,1)
	tween.parallel().tween_property(self,"anchor_bottom",1.93,.7)
	tween.tween_callback(func(): Global.stop_lowering_joules = false)
func close():
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(sheet,"anchor_top",.25,.4)
	tween.parallel().tween_property(sheet,"z_index",-1,.4)
	tween.parallel().tween_property(sheet,"anchor_left",.25,.4)
	tween.parallel().tween_property(sheet,"anchor_bottom",.95,.4)
	tween.parallel().tween_property(sheet,"anchor_right",.75,.4)
	tween.tween_callback(tween_down)
	for child in sheet.get_children():
		child.hide()
	
func open():
	for child in sheet.get_children():
		child.show()
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(sheet,"anchor_top",-.3,.4)
	tween.parallel().tween_property(sheet,"z_index",3,.4)
	tween.parallel().tween_property(sheet,"anchor_left",-.025,.4)
	tween.parallel().tween_property(sheet,"anchor_bottom",1.05,.4)
	tween.parallel().tween_property(sheet,"anchor_right",1.025,.4)
