extends Control

func _ready() -> void:
	call_deferred("contract_all_docks")
	%TimeScaleSlider.value = Engine.time_scale

func contract_all_docks() -> void:
	get_tree().call_group("dock", "contract_dock")
	
func _on_play_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		get_tree().paused = false
	else:
		get_tree().paused = true
	
func _on_reset_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_time_scale_slider_value_changed(value: int) -> void:
	Engine.time_scale = value
	Engine.physics_ticks_per_second = 60 * value
	
func dump_to_logs(message: String) -> void:
	%LogDock.dump_to_logs(message)
