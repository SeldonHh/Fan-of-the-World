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
	fan.stop()
