extends Control

@export var configuration_name: String

func _on_line_edit_text_changed(new_text: String) -> void:
	%WarningIcon.show_icon()

func sync_to_configuration() -> void:
	%WarningIcon.hide_icon()
	%LineEdit.text = str(Configuration.get(configuration_name))
