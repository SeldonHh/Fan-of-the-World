extends TextureButton
@onready var auto_size_label: AutoSizeLabel = $AutoSizeLabel

@onready var upgrade_menu: Control = %Upgrade_Menu

func _ready() -> void:
	Global.phone = self

func _on_pressed() -> void:
	upgrade_menu.show()
	auto_size_label.hide()

func stop():
	self.disabled = true
	self.texture_normal = preload("uid://chfrf4a4w12c0")
