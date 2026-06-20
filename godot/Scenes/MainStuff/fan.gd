extends Button
@onready var fan_texture: TextureRect = %fan_texture
@onready var motivationbar: ProgressBar = %Motivationbar

var spinning := false
var constant_spinning := false
@export var spinning_time := .25
const ANIM_IPS := 1.0/20.0
const TEXTURES: Array[Texture2D] = [
	preload("uid://diygv6ycq8rmk"),
	preload("uid://bi7uyupxnl07u"),
	preload("uid://b3tklwkvfw0mo"),
	preload("uid://b4btupw8hm2wm"),
]
@export var base_speed_scale = 1.0
var speed_scale = base_speed_scale
@export var fanning_power = 1

func spin():
	if !spinning:
		speed_scale = base_speed_scale + motivationbar.value/100
		var texture_index = 0
		spinning = true
		var timer = get_tree().create_timer(spinning_time)
		timer.timeout.connect(func(): 
			while constant_spinning :
				await get_tree().process_frame
			spinning = false)
		while spinning:
			texture_index = texture_index+1
			if texture_index >= len(TEXTURES):
				texture_index = 0
				Global.lower_joules(fanning_power)
			fan_texture.texture = TEXTURES[texture_index]
			await get_tree().create_timer(ANIM_IPS/speed_scale).timeout
			if !constant_spinning:
				speed_scale -= .1
			else:
				speed_scale = base_speed_scale + motivationbar.value/100


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Debug"):
		spin()
	if Input.is_action_just_pressed("debug2"):
		constant_spinning = !constant_spinning
		spin()


func _on_pressed() -> void:
	spin()
