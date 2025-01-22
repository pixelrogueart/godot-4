class_name Pawn
extends CharacterBody2D

@onready var state_manager = $StateManager
@onready var animation_player = $AnimationPlayer
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

func _physics_process(delta: float) -> void:
	state_manager.physics_process(delta)

func get_input_strength() -> Vector2:
	var input_dir:Vector2 = Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),0).normalized()
	return input_dir
