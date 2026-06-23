extends AudioStreamPlayer

func _ready() -> void:
	volume_db = (log((Global.volume)/100.0)*20)-15
	play()
	if "debug" in OS.get_cmdline_args():
		playing = false

func _process(_delta: float) -> void:
	volume_db = (log((Global.volume)/100.0)*20)-15
