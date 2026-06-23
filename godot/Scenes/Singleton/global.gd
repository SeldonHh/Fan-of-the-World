extends Node

var joules := 99999
var fan : Button
var motivation : ProgressBar
var phone : TextureButton
var upgrade_menu : Control
func lower_joules(amount):
	joules = max(0,joules-amount)
	if joules == 0:
		end()

func end():
	meta_game_complete("Seldon/FanOfTheWorld")
	fan.stop()

func meta_game_complete(gameId: String) -> void:
	if OS.has_feature("web"):
		JavaScriptBridge.eval("localStorage.setItem(\"%s\", new Date().toJSON());" % gameId)
