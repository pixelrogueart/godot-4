class_name PlayerStateMove
extends PlayerBaseState

@export var move_speed = 30.0

func enter() -> void:
	super.enter()
	pass

func exit() -> void:
	super.exit()
	pass

func input(_event: InputEvent) -> void:
	if _event.is_action_pressed("run"):
		if player.state_manager.current_state.name != "Run":
			player.change_state("Run")
	if _event.is_action_released("run"):
		if player.state_manager.current_state.name != "Move":
			player.change_state("Move")

func process(_delta:float) -> void:
	# Se o input que estamos lendo do player a cada frame, for igual a Vector2.ZERO vamos trocar para o estado Idle.
	var input_dir = player.get_input_strength()
	if input_dir == Vector2.ZERO:
		return player.change_state("Idle")
	# Movimentação básica de player baseado no input.
	player.velocity = input_dir * move_speed
	player.move_and_slide()

func physics_process(_delta:float) -> void:
	pass
