extends TextureButton
@onready var tooltip: Panel = $Tooltip
@onready var cash_sfx: AudioStreamPlayer = $cash_sfx

var placeholder = preload("uid://b5oaplmavxw6n")
@export var resource : UpgradeResource = placeholder
@onready var attention: TextureRect = $ATTENTION

@onready var desc: AutoSizeRichTextLabel = $Tooltip/desc
@export var seen := false
@export var desc_only := false
func _ready() -> void:
	update_self()

func update_self():
	self.texture_normal = resource.texture
	desc.text = "[b]%s[/b]
	%s"%[resource.name,resource.desc]
	if !desc_only:
		desc.text += "
[i]requirement: %s Joules
heats the atmosphere by %s Joules"%[resource.joules_requirement,resource.cost]

func _on_pressed() -> void:
	if Global.joules <= resource.joules_requirement and self.resource != placeholder:
		cash_sfx.play(.4)
		match resource.name:
			"Autospin":
				Global.fan.constant_spinning_base_speed_scale += .6
			"Fanception": 
				Global.fan.constant_spinning = true
				Global.fan.start_constant_spin()
			"Stronger Spin":
				Global.fan.spinning_time += .3
			"Improved Blades":
				Global.fan.add_bonus_power(2)
			"Getting More Fans":
				Global.motivation.motivation_button.disabled = false
			"Titanium Blades":
				Global.fan.add_bonus_power(2)
			"Marketing Campaign":
				Global.motivation.add_motivation(50)
			"Atom Splitting":
				Global.fan.crit_chance += 10
			"Fans of Fan":
				Global.fan.motivation_on_turn += 1
			"Precision Spin":
				Global.fan.crit_damage += 20
			"Healthy Community":
				Global.fan.motivation_on_crit_chance = true
			"Child Labor":
				Global.fan.motivation_on_turn -= 6
				Global.fan.add_bonus_power(3)
			"Stop Child Labor":
				Global.fan.motivation_on_turn += 6
				Global.fan.remove_bonus_power(3)
			"Fast Boi":
				Global.fan.base_speed_scale *= 2
				Global.fan.constant_spinning_base_speed_scale *= 2
				Global.fan.spinning_time *= 2
		Global.lower_joules(-resource.cost)
		Global.upgrade_menu.is_bought(resource)
		if resource.override_replacement == null:
			self.resource = placeholder
		else:
			self.resource = resource.override_replacement
		tooltip.hide()
		seen = false
		update_self()

func _process(_delta: float) -> void:
	if Global.joules <= resource.joules_requirement and resource != placeholder and seen == false:
		attention.show()
	else:
		attention.hide()

func _on_mouse_entered() -> void:
	if self.resource != placeholder:
		tooltip.show()


func _on_mouse_exited() -> void:
	tooltip.hide()
