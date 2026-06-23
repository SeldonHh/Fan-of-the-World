extends AudioStreamPlayer

var og_volume := -10.0
func _ready() -> void:
	if "debug" in OS.get_cmdline_args():
		playing = false
	og_volume = volume_db
func _process(_delta: float) -> void:
	
	volume_db = og_volume * (Global.volume/100.0)
