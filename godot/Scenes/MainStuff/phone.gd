extends TextureButton
@onready var auto_size_label: AutoSizeLabel = $AutoSizeLabel


func _on_pressed() -> void:
	auto_size_label.hide()
