extends HSlider


@export var bus_name: String

var bus_index: int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(_on_value_changed)
	
	value = db_to_linear(
		AudioServer.get_bus_volume_db(bus_index)
	)

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	if self.name == "Master":
		Global.master_volume = value
	if self.name == "Music":
		Global.music_volume = value
	if self.name == "Sound Effects":
		Global.sfx_volume = value
	Global.save_game_data()
