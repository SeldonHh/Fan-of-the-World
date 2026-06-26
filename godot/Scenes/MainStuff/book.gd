extends TextureButton
@onready var bg: TextureRect = %BG
@onready var book_menu: Control = %Book_Menu
@onready var upgrade_menu: Control = %Upgrade_Menu

func _process(_delta: float) -> void:
	self.modulate = bg.modulate

func _on_pressed() -> void:
	if upgrade_menu.visible == false:
		book_menu.show()
		Global.stop_lowering_joules = true

func _ready() -> void:
	Global.book = self
