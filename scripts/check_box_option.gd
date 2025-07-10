extends Control

@export var configuration_name: String

func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on != Configuration.get(configuration_name):
		%WarningIcon.show_icon()
	else:
		%WarningIcon.hide_icon()
	
func read_from_configuration() -> void:
	%CheckButton.button_pressed = Configuration.get(configuration_name)

func write_to_configuration() -> void:
	Configuration.set(configuration_name, %CheckButton.button_pressed)

func hide_requires_next_generation_icon() -> void:
	if %WarningIcon.type == %WarningIcon.types.REQUIRES_NEXT_GENERATION:
		%WarningIcon.hide_icon()
