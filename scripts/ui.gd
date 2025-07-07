extends Control

func _ready() -> void:
	call_deferred("contract_all_docks")

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
