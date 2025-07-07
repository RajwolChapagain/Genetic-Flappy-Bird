extends Control

@export var expanded: bool

@onready var EXPANDED_POSITION: Vector2
@onready var SLIDE_VECTOR: Vector2
					
func _ready() -> void:
	# Defer the call because things like %Items.size will return 0
	# 	since control sizes are determined after _ready
	call_deferred("initialize_layout")
	
func initialize_layout() -> void:
	SLIDE_VECTOR = Vector2.LEFT * %Items/Panel.size
		
	if expanded:
		EXPANDED_POSITION = %Items.position
	else:
		EXPANDED_POSITION = %Items.position + SLIDE_VECTOR
		
func _on_button_pressed() -> void:
	if not expanded:
		%Items.position = EXPANDED_POSITION
		expanded = true
	else:
		%Items.position -= SLIDE_VECTOR
		expanded = false
