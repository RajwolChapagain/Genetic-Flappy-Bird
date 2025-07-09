extends Control

@export var configuration_name: String

func _on_line_edit_text_changed(new_text: String) -> void:
	%WarningIcon.show_icon()

func read_from_configuration() -> void:
	%LineEdit.text = str(Configuration.get(configuration_name))
	%WarningIcon.hide_icon()

func write_to_configuration() -> void:
	Configuration.set(configuration_name, int(%LineEdit.text))
	%WarningIcon.hide_icon()
