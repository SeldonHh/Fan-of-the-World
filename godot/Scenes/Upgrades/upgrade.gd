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
	[font_size=20] requirement: %s Joules"%resource.joules_requirement

func _on_pressed() -> void:
	if Global.joules <= resource.joules_requirement and self.resource != placeholder:
		match resource.name:
			"Fanception": 
				Global.fan.constant_spinning = true
				Global.fan.spin()
			"Stronger Spin":
				Global.fan.spinning_time += .3
		self.resource = placeholder
		tooltip.hide()
		update_self()


func _on_mouse_entered() -> void:
	if self.resource != placeholder:
		tooltip.show()


func _on_mouse_exited() -> void:
	tooltip.hide()
