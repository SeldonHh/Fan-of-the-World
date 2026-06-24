extends TextureRect
@onready var auto_size_label: AutoSizeRichTextLabel = $AutoSizeLabel

@onready var rich_text_label: AutoSizeRichTextLabel = $RichTextLabel

func _on_close_pressed() -> void:
	Global.letter.close()
	
func _ready() -> void:
	for child in get_children():
		child.hide()

func new_message(message):
	auto_size_label.text = message[0]
	rich_text_label.text = message[1]
	Global.letter.tween_up()
