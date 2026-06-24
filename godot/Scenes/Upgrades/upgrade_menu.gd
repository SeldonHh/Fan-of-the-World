extends Control
@onready var grid_container: GridContainer = %Boughtable
@onready var texture_rect: TextureRect = $TextureRect
@onready var bought: GridContainer = $TextureRect/Bought
@onready var check_text: AutoSizeLabel = $CheckButton/check_text
@onready var notif_sfx: AudioStreamPlayer = $notif_sfx

var normal_phone : Texture = preload("uid://chfrf4a4w12c0")
var phone_important : Texture = preload('uid://dborrbm0c8xd2')
var bought_index = 0
var notif_played := false

func _ready() -> void:
	Global.upgrade_menu = self

func is_bought(resource:UpgradeResource):
	bought.get_child(bought_index).resource = resource
	bought.get_child(bought_index).update_self()
	bought_index +=1

func _on_exit_pressed() -> void:
	notif_played = false
	for upgrade in grid_container.get_children():
		if Global.joules <= upgrade.resource.joules_requirement and upgrade.resource!=upgrade.placeholder:
			upgrade.seen = true
	Global.phone.texture_normal = normal_phone
	hide()

func _process(_delta: float) -> void:
	bought.visible = !grid_container.visible
	if bought.visible:
		check_text.text = "Bought"
	else:
		check_text.text = "Buyable"
	for upgrade in grid_container.get_children():
		if Global.joules <= upgrade.resource.joules_requirement and upgrade.resource!=upgrade.placeholder:
			if upgrade.seen == false:
				Global.phone.texture_normal = phone_important
				if !notif_played:
					notif_played = true
					notif_sfx.play()


func _on_check_button_toggled(toggled_on: bool) -> void:
	grid_container.visible = !toggled_on
