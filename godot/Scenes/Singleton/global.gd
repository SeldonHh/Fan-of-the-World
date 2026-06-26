extends Node

var joules := 99999
var fan : Button
var motivation : ProgressBar
var phone : TextureButton
var upgrade_menu : Control
var wheel : AnimatedSprite2D
var letter : TextureRect
var stop_lowering_joules := false
var book : TextureButton
var messages ={
	"Tuto": ["[b]Welcome Sylvia","Welcome to your [b]new job[/b], as you know climate change has devastated our world and the temperature has risen to [b]+52[/b]°C (or [b]+96[/b]°F), the equivalent of [b]99999 joules[/b] only antartica is suitable for life now. Unfortunately due tu the latest budget cuts in the ecology sector you're the only remaining operator we have, we sent you our latest invention the [b]Cosmic Cooling Fan 3000[/b], don't ask how we made it, it's [b]your job[/b] to use, please Sylvia, help us, [b]or we are cooked."],
	"Agriculture": ["[b]Return of agriculture","Only now is [b]agriculture[/b] viable again in most of the planet, however the number of species that [b]died[/b] during the heat age is [b]incommensurable[/b], let's hope we'll find some new species"],
	"New Horizon":["[b]New Horizon Available","The temperature is down to [b]10-50[/b]°C only in canada, northern europe and russia, [b]recolonization[/b] is on it's way, and the pionners don't fear the [b]heat[/b] :)"],
	"The End":["[b]The End","You've done it ! Thanks to your good work the earth has been saved from climate change. Unfortunately, due to yet another budget cut you were fired 5 minutes ago and the fan isn't powered anymore. The president said 'well now there are no problems with climate are there?'.
Thanks for playing the game !
Game,Music and Art by Hadrien HEURTEAUX
Original background art by Aki Aoki (has been modified)"]
	}

# Load the custom images for the mouse cursor.
var arrow = load("uid://7gbwt8nswn84")
var beam = load("uid://fuacdy74u573")

func _ready() -> void:
	# Changes a specific shape of the cursor (here, the I-beam shape).
	Input.set_custom_mouse_cursor(beam, Input.CURSOR_POINTING_HAND)
	await get_tree().create_timer(.1).timeout
	if "debug" in OS.get_cmdline_args():
		return
	send_message("Tuto")

func lower_joules(amount):
	if !stop_lowering_joules:
		joules = max(0,joules-amount)
		if joules <= 0:
			end()
		elif joules <= 8000:
			send_message("Agriculture")
		elif joules <= 49376:
			send_message("New Horizon")

func send_message(key):
	if messages[key] != []:
		stop_lowering_joules = true
		letter.sheet.new_message(messages[key])
		messages[key] = []

func end():
	phone.stop()
	motivation.stop()
	fan.stop()
	send_message("The End")
	var window_size = get_window().size
	wheel.position = Vector2(window_size.x-window_size.x/20,window_size.y+50.0)
	wheel.play('default')
	var tween = get_tree().create_tween()
	tween.tween_property(wheel,"position",Vector2(wheel.position.x,wheel.position.y-150),1)
	tween.parallel().tween_property(wheel,"modulate",Color(1,1,1,1),1.2)
	tween.tween_callback(func():
		var new_tween = get_tree().create_tween()
		new_tween.tween_property(wheel,"modulate",Color(1,1,1,0),.8))
	meta_game_complete("Seldon/FanOfTheWorld")

func meta_game_complete(gameId: String) -> void:
	if OS.has_feature("web"):
		JavaScriptBridge.eval("localStorage.setItem(\"%s\", new Date().toJSON());" % gameId)

var volume := 100
var sfx_volume := 100
