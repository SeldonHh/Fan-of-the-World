extends TextureButton
@onready var auto_size_label: AutoSizeLabel = $AutoSizeLabel

@onready var upgrade_menu: Control = %Upgrade_Menu

func _on_pressed() -> void:
	upgrade_menu.show()
	auto_size_label.hide()
	
