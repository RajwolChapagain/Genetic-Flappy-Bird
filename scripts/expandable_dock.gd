extends Control

@onready var INIT_POSITION = %Items.position
@onready var SLIDE_DISTANCE = %Items/Panel.size.x
var expanded = false:
	get:
		return expanded
	set(value):
		if value:
			%Items.position = Vector2(INIT_POSITION.x - SLIDE_DISTANCE, INIT_POSITION.y)
			expanded = value
		else:
			%Items.position = INIT_POSITION
			expanded = value

func _on_button_pressed() -> void:
	if not expanded:
		expanded = true
	else:
		expanded = false
