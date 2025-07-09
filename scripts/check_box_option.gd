extends Control

@export var configuration_name: String

func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on != Configuration.get(configuration_name):
		%WarningIcon.show_icon()
	else:
		%WarningIcon.hide_icon()
	
func read_from_configuration() -> void:
	%CheckButton.button_pressed = Configuration.get(configuration_name)
	%WarningIcon.hide_icon()

func write_to_configuration() -> void:
	Configuration.set(configuration_name, %CheckButton.button_pressed)
	%WarningIcon.hide_icon()
