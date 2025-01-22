class_name GUI
extends Control

@onready var state_manager = $StateManager
var current_state:String

func change_state(new_state:String):
	var node = state_manager.get_node(new_state)
	if node:
		state_manager.change_state(node)
		current_state = new_state
		return node
	else:
		printerr("%s state not found."%new_state)

func _unhandled_input(event: InputEvent) -> void:
	state_manager.input(event)

func _process(delta: float) -> void:
	state_manager.process(delta)
