extends Control

@export var expanded: bool

@onready var EXPANDED_POSITION: Vector2
@onready var SLIDE_VECTOR: Vector2
					
func _ready() -> void:
	# Defer the call because things like %Items.size will return 0
	# 	since control sizes are determined after _ready
	call_deferred("initialize_layout")
	
func initialize_layout() -> void:
	SLIDE_VECTOR = Vector2.UP * %Items/Panel.size
		
	if expanded:
		EXPANDED_POSITION = %Items.position
	else:
		EXPANDED_POSITION = %Items.position + SLIDE_VECTOR
		
func _on_button_pressed() -> void:
	if not expanded:
		expand_dock()
	else:
		contract_dock()

func expand_dock() -> void:
	%Items.position = EXPANDED_POSITION
	expanded = true

func contract_dock() -> void:
	%Items.position -= SLIDE_VECTOR
	expanded = false

func dump_to_logs(message: String) -> void:
	%LogLabel.text = %LogLabel.text + '\n' + message

func _on_scroll_to_bottom_button_pressed() -> void:
	%ScrollContainer.scroll_vertical = %ScrollContainer.get_v_scroll_bar().max_value
