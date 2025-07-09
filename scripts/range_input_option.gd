extends Control

@export var configuration_name: String

func _on_h_slider_value_changed(value: float) -> void:
	%WarningIcon.show_icon()

func read_from_configuration() -> void:
	%HSlider.value = Configuration.get(configuration_name)
	%WarningIcon.hide_icon()

func write_to_configuration() -> void:
	Configuration.set(configuration_name, %HSlider.value)
	%WarningIcon.hide_icon()
