extends Control

@export var configuration_name: String

func _on_line_edit_text_changed(new_text: String) -> void:
	if int(new_text) != Configuration.get(configuration_name):
		%WarningIcon.show_icon()
	else:
		hide_requires_next_generation_icon()
		
func read_from_configuration() -> void:
	%LineEdit.text = str(Configuration.get(configuration_name))
	%LineEdit.placeholder_text = str(Configuration.get(configuration_name))

func write_to_configuration() -> void:
	Configuration.set(configuration_name, int(%LineEdit.text))

func hide_requires_next_generation_icon() -> void:
	if %WarningIcon.type == %WarningIcon.types.REQUIRES_NEXT_GENERATION:
		%WarningIcon.hide_icon()
