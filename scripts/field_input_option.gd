extends Control

@export var configuration_name: String

func _on_line_edit_text_changed(new_text: String) -> void:
	%WarningIcon.show_icon()
	Configuration.set(configuration_name, int(new_text))

func sync_to_configuration() -> void:
	%LineEdit.text = str(Configuration.get(configuration_name))
	%WarningIcon.hide_icon()
