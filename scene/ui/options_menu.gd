extends CanvasLayer


@onready var window_mode_button: Button = %WindowModeButton
@onready var sfx_slider: HSlider = %SFXSlider
@onready var music_slider: HSlider = %MusicSlider


func _ready() -> void:
	update_options()


func update_options():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		window_mode_button.text = "Fullscreen"
	else:
		window_mode_button.text = "Windowed"
		
	sfx_slider.value = get_volume_percent(2)
	music_slider.value = get_volume_percent(1)
		
		
func get_volume_percent(bus_index: int):
	var volume_db = AudioServer.get_bus_volume_db(bus_index)
	return db_to_linear(volume_db)


func _on_window_mode_button_pressed() -> void:
	var mode = DisplayServer.window_get_mode()
	if mode != DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
	update_options()
	

func _on_sfx_slider_value_changed(value: float) -> void:
	var volume_db = linear_to_db(value)
	AudioServer.set_bus_volume_db(2, volume_db)


func _on_music_slider_value_changed(value: float) -> void:
	var volume_db = linear_to_db(value)
	AudioServer.set_bus_volume_db(1, volume_db)


func _on_back_button_pressed() -> void:
	queue_free()
