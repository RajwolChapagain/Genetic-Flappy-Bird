extends Control

@export var configuration_name: String
@export var type: menu_type
@export var icon_max_width: int

enum menu_type { GRAPHICAL, TEXT_BASED }

func _ready() -> void:
	%MenuButton.get_popup().index_pressed.connect(on_item_selected)
	for i in range(%MenuButton.item_count):
		%MenuButton.get_popup().set_item_icon_max_width(i, icon_max_width)
		%MenuButton.get_popup()

func on_item_selected(index: int) -> void:
	if index != Configuration.get(configuration_name):
		%WarningIcon.show_icon()
	else:
		%WarningIcon.hide_icon()
		
	if type == menu_type.GRAPHICAL:
		%MenuButton.icon = %MenuButton.get_popup().get_item_icon(index)
	elif type == menu_type.TEXT_BASED:
		%MenuButton.text = %MenuButton.get_popup().get_item_text(index)
	
	%MenuButton.get_popup().set_item_checked(index, true)
	disable_except(index)
	
func read_from_configuration() -> void:
	if type == menu_type.GRAPHICAL:
		%MenuButton.icon = %MenuButton.get_popup().get_item_icon(Configuration.get(configuration_name))
	elif type == menu_type.TEXT_BASED:
		%MenuButton.text = %MenuButton.get_popup().get_item_text(Configuration.get(configuration_name))

	%WarningIcon.hide_icon()

func write_to_configuration() -> void:
	Configuration.set(configuration_name, get_active_item_index())
	%WarningIcon.hide_icon()

func disable_except(index: int) -> void:
	for i in range(%MenuButton.get_popup().item_count):
		if %MenuButton.get_popup().is_item_checked(i) and i != index:
			%MenuButton.get_popup().set_item_checked(i, false)
			
func get_active_item_index() -> int:
	for i in range(%MenuButton.get_popup().item_count):
		if %MenuButton.get_popup().is_item_checked(i):
			return i
	
	return -1
