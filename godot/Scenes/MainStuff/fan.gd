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
@export var crit_chance := 0.0
var actual_crit_chance := crit_chance
@export var crit_damage := 10
var motivation_on_turn := 0.0
var motivation_on_crit_chance := false
var max_crit_label := 20
func add_power(amount):
	fanning_power += fanning_power_bonus * amount

func add_bonus_power(amount):
	fanning_power *= amount
	fanning_power_bonus += amount-1

func remove_bonus_power(amount):
	fanning_power /= amount
	fanning_power_bonus -= amount+1

func _ready() -> void:
	Global.fan = self
@onready var swhoosh: AudioStreamPlayer = $swhoosh

func spin():
	if !spinning:
		if constant_spinning:
			boost_until = Time.get_ticks_msec() / 1000.0 + spinning_time
			return
		else:
			spin_generation += 1
			var my_generation = spin_generation
			spinning = true
			speed_scale = base_speed_scale * (1+motivationbar.value / 100)
			var timer = get_tree().create_timer(spinning_time)
			timer.timeout.connect(func():
				spinning = false
				if my_generation == spin_generation:
					spin_generation += 1)
			while my_generation == spin_generation:
				texture_index = texture_index+1
				if texture_index >= len(TEXTURES):
					texture_index = 0
					if randi_range(0,100) < actual_crit_chance:
						crit(fanning_power* crit_damage)
						Global.lower_joules(fanning_power* crit_damage)
					else:
						Global.lower_joules(fanning_power)
					Global.motivation.add_motivation(motivation_on_turn)
				fan_texture.texture = TEXTURES[texture_index]
				await get_tree().create_timer(ANIM_IPS/speed_scale).timeout

func _process(_delta: float) -> void:
	if "debug" in OS.get_cmdline_args():
		if Input.is_action_just_pressed("Debug"):
			var temp = fanning_power
			add_power(9998)
			Global.motivation.add_motivation(0)
			spin()
			await get_tree().create_timer(spinning_time).timeout
			fanning_power = temp 
		if Input.is_action_just_pressed("debug2"):
			constant_spinning = !constant_spinning
			start_constant_spin()
	
	if motivation_on_crit_chance:
		actual_crit_chance = crit_chance*(1+Global.motivation.value/100)
	else:
		actual_crit_chance = crit_chance
	if (spinning or constant_spinning) and swhoosh.playing == false:
		swhoosh.pitch_scale = randf_range(.8,1.2)
		swhoosh.play()

func stop():
	self.disabled = true
	spinning = false
	constant_spinning = false

func _on_pressed() -> void:
	spin()
	
func crit(amount):
	if get_child_count() < max_crit_label:
		var label = AutoSizeRichTextLabel.new()
		label.bbcode_enabled = true
		label.mouse_filter = Control.MOUSE_FILTER_IGNORE
		label.text = '[b][color=yellow]CRIT!
-%s Joules'%amount
		label.position = Vector2(randf_range(position.x,position.x-size.x),randf_range(position.y,position.y-size.y))
		var screen_size = get_window().size
		label.custom_minimum_size = Vector2(screen_size.x/12.0,screen_size.y/10.0)
		label.scroll_active = false
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		self.add_child(label)
		await get_tree().create_timer(5).timeout
		label.queue_free()

func start_constant_spin():
	swhoosh.stream = preload("uid://ctawwtlmnojtb")
	swhoosh.minus_db = 0
	if constant_spin_running:
		return
	constant_spin_running = true
	while constant_spinning:
		var current_time = Time.get_ticks_msec() / 1000.0
		if current_time < boost_until:
			speed_scale = base_speed_scale * (1+motivationbar.value / 100)
		else:
			speed_scale = constant_spinning_base_speed_scale * (1+motivationbar.value / 300)
		texture_index = texture_index+1
		if texture_index >= len(TEXTURES):
			texture_index = 0
			if randi_range(0,100) < actual_crit_chance:
				crit(fanning_power* crit_damage)
				Global.lower_joules(fanning_power* crit_damage)
			else:
				Global.lower_joules(fanning_power)
			Global.motivation.add_motivation(motivation_on_turn)
		fan_texture.texture = TEXTURES[texture_index]
		await get_tree().create_timer(ANIM_IPS/speed_scale).timeout
	constant_spin_running = false
