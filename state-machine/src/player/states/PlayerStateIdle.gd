class_name PlayerStateIdle
extends PlayerBaseState


func enter() -> void:
	super.enter()
	player.velocity = Vector2.ZERO

func exit() -> void:
	super.exit()

func input(_event: InputEvent) -> void:
	super.input(_event)

func process(_delta:float) -> void:
	super.process(_delta)
	# Se o input que estamos lendo do player a cada frame, for diferente de Vector2.ZERO, ou seja, o jogador estiver pressionando W,A,S ou D, vamos trocar para o estado Move.
	var input_dir = player.get_input_strength()
	if input_dir != Vector2.ZERO:
		return player.change_state("Move")

func physics_process(_delta:float) -> void:
	super.physics_process(_delta)
