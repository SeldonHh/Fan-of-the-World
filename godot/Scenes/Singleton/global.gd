extends Node

var joules := 99999
var fan : Button
var motivation : ProgressBar
var phone : TextureButton
var upgrade_menu : Control
var wheel : AnimatedSprite2D
func lower_joules(amount):
	joules = max(0,joules-amount)
	if joules == 0:
		end()

func end():
	fan.stop()
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
