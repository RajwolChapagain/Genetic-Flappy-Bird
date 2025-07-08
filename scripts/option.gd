extends Control

enum types { REQUIRES_NEXT_GENERATION, REQUIRES_RESTART }
@export var type: types

@export var requires_next_gen_sprite: Texture2D
@export var requires_restart_sprite: Texture2D

func on_value_changed() -> void:
	if type == types.REQUIRES_NEXT_GENERATION:
		%WarningIcon.texture = requires_next_gen_sprite
	elif type == types.REQUIRES_RESTART:
		%WarningIcon.texture = requires_restart_sprite

func _on_h_slider_value_changed(value: float) -> void:
	on_value_changed()
