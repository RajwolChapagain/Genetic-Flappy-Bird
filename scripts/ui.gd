extends Control

func _ready() -> void:
	call_deferred("contract_all_docks")

func contract_all_docks() -> void:
	get_tree().call_group("dock", "contract_dock")
