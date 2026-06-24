extends AudioStreamPlayer

@export var minus_db := 0
@export var pitch := false
func _ready() -> void:
	volume_db = (log((Global.sfx_volume)/100.0)*20)-minus_db

func _process(_delta: float) -> void:
	volume_db = (log((Global.sfx_volume)/100.0)*20)-minus_db
	if pitch:
		self.pitch_scale = randf_range(0.9,1.1)
