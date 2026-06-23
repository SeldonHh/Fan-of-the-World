extends Control
@onready var grid_container: GridContainer = %GridContainer
@onready var texture_rect: TextureRect = $TextureRect

var normal_phone : Texture = preload("uid://chfrf4a4w12c0")
var phone_important : Texture = preload('uid://dborrbm0c8xd2')

func _on_exit_pressed() -> void:
	for upgrade in grid_container.get_children():
		if Global.joules <= upgrade.resource.joules_requirement and upgrade.resource!=upgrade.placeholder:
			upgrade.seen = true
	Global.phone.texture_normal = normal_phone
	hide()

func _process(_delta: float) -> void:
	for upgrade in grid_container.get_children():
		if Global.joules <= upgrade.resource.joules_requirement and upgrade.resource!=upgrade.placeholder:
			if upgrade.seen == false:
				Global.phone.texture_normal = phone_important
