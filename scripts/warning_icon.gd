extends Control

enum types { REQUIRES_NEXT_GENERATION, REQUIRES_RESTART }
@export var type: types

@export var requires_next_gen_sprite: Texture2D
@export var requires_restart_sprite: Texture2D

func _ready() -> void:
	if type == types.REQUIRES_NEXT_GENERATION:
		tooltip_text = "Requires next generation"
	elif type == types.REQUIRES_RESTART:
		tooltip_text = "Requires restart"
		
func show_icon() -> void:
	if type == types.REQUIRES_NEXT_GENERATION:
		%TextureRect.texture = requires_next_gen_sprite
	elif type == types.REQUIRES_RESTART:
		%TextureRect.texture = requires_restart_sprite
	
	%TextureRect.visible = true

func hide_icon() -> void:
	%TextureRect.visible = false
