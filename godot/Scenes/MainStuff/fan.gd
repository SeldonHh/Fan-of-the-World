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
@export var constant_spinning_base_speed_scale = .2
var speed_scale = base_speed_scale
@export var fanning_power = 1
var fanning_power_bonus := 1
var spin_generation := 0
var boost_until: float = 0.0
var constant_spin_running := false
var texture_index := 0

func add_power(amount):
	fanning_power += fanning_power_bonus * amount

func add_bonus_power(amount):
	fanning_power *= amount
	fanning_power_bonus += amount-1

func _ready() -> void:
	Global.fan = self

func spin():
	if !spinning:
		if constant_spinning:
			boost_until = Time.get_ticks_msec() / 1000.0 + spinning_time
			return
		else:
			spin_generation += 1
			var my_generation = spin_generation
			spinning = true
			speed_scale = base_speed_scale + motivationbar.value/100
			var timer = get_tree().create_timer(spinning_time)
			timer.timeout.connect(func():
				spinning = false
				if my_generation == spin_generation:
					spin_generation += 1)
			while my_generation == spin_generation:
				texture_index = texture_index+1
				if texture_index >= len(TEXTURES):
					texture_index = 0
					Global.lower_joules(fanning_power)
				fan_texture.texture = TEXTURES[texture_index]
				await get_tree().create_timer(ANIM_IPS/speed_scale).timeout


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Debug"):
		var temp = fanning_power
		add_power(1000)
		spin()
		await get_tree().create_timer(spinning_time).timeout
		fanning_power = temp 
	if Input.is_action_just_pressed("debug2"):
		constant_spinning = !constant_spinning
		start_constant_spin()

func _on_pressed() -> void:
	spin()

func start_constant_spin():
	if constant_spin_running:
		return
	constant_spin_running = true
	while constant_spinning:
		var current_time = Time.get_ticks_msec() / 1000.0
		if current_time < boost_until:
			speed_scale = base_speed_scale + motivationbar.value / 100
		else:
			speed_scale = constant_spinning_base_speed_scale + motivationbar.value / 100
		texture_index = texture_index+1
		if texture_index >= len(TEXTURES):
			texture_index = 0
			Global.lower_joules(fanning_power)
		fan_texture.texture = TEXTURES[texture_index]
		await get_tree().create_timer(ANIM_IPS/speed_scale).timeout
	constant_spin_running = false
