extends TextureButton
@onready var tooltip: Panel = $Tooltip

var placeholder = preload("uid://b5oaplmavxw6n")
@export var resource : UpgradeResource = placeholder

@onready var desc: AutoSizeRichTextLabel = $Tooltip/desc

func _ready() -> void:
	update_self()

func update_self():
	self.texture_normal = resource.texture
	desc.text = "[b]%s[/b]
	%s"%[resource.name,resource.desc]
	desc.text += "
	[font_size=18] requirement: %s Joules
	heats the atmosphere by %s Joules"%[resource.joules_requirement,resource.cost]

func _on_pressed() -> void:
	if Global.joules <= resource.joules_requirement and self.resource != placeholder:
		match resource.name:
			"Fanception": 
				Global.fan.constant_spinning = true
				Global.fan.start_constant_spin()
			"Stronger Spin":
				Global.fan.spinning_time += .3
			"Improved Blades":
				Global.fan.add_bonus_power(2)
		Global.lower_joules(-resource.cost)
		self.resource = placeholder
		tooltip.hide()
		update_self()


func _on_mouse_entered() -> void:
	if self.resource != placeholder:
		tooltip.show()


func _on_mouse_exited() -> void:
	tooltip.hide()
