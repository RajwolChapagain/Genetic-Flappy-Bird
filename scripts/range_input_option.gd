extends Control

@export var configuration_name: String

func _on_h_slider_value_changed(value: float) -> void:
	if value != Configuration.get(configuration_name):
		%WarningIcon.show_icon()
	else:
		%WarningIcon.hide_icon()

func read_from_configuration() -> void:
	%HSlider.value = Configuration.get(configuration_name)

func write_to_configuration() -> void:
	Configuration.set(configuration_name, %HSlider.value)

func hide_requires_next_generation_icon() -> void:
	if %WarningIcon.type == %WarningIcon.types.REQUIRES_NEXT_GENERATION:
		%WarningIcon.hide_icon()
