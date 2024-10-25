# Define a classe `Player` que herda de `CharacterBody2D`
class_name Player
extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var state_manager = $StateManager
@onready var sprite = $Sprite2D

# Função chamada quando o node entra na cena
func _ready():
	# Inicializa o state manager com a instância do jogador como contexto
	state_manager.init(self)

# Função para lidar com eventos de input
func _unhandled_input(event: InputEvent) -> void:
	# Passa o evento de entrada para o state manager
	state_manager.input(event)

# Função chamada a cada frame para atualizar o estado do jogador
func _process(delta: float) -> void:
	# Processa o estado atual através do state manager
	state_manager.process(delta)
	# Atualiza o debug
	$Label.text = state_manager.current_state.name
	# Atualiza a direção do sprite
	update_direction()

# Função chamada a cada frame de física para atualizar o movimento e a lógica do estado do jogador
func _physics_process(delta: float) -> void:
	# Processa a lógica de física do estado atual
	state_manager.physics_process(delta)

# Função para trocar o estado do jogador para um novo estado, usando o nome do estado como string
func change_state(new_state:String) -> void:
	# Tenta obter o node do novo estado pelo nome
	var state_node = state_manager.get_node(new_state)
	if state_node:
		# Se o estado existir dentro do state manager, troca para o novo estado
		state_manager.change_state(state_node)

# Função que calcula a força da entrada do jogador com base nas teclas de movimento
func get_input_strength() -> Vector2:
	# Cria um vetor com as direções horizontais e verticais, normalizando-o para manter a velocidade constante
	var input_direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")).normalized()
	return input_direction

# Função que atualiza a direção do sprite do jogador com base no input do jogador
func update_direction() -> void:
	# Obtém a direção da entrada
	var input_direction = get_input_strength()
	var direction
	# Define a direção baseada no eixo X (esquerda ou direita)
	if input_direction.x < 0:
		direction = "w"  # Oeste (left)
	elif input_direction.x > 0:
		direction = "e"  # Leste (right)
	# Define a direção baseada no eixo Y (cima ou baixo)
	if input_direction.y > 0:
		direction = "s"  # Sul (down)
	elif input_direction.y < 0:
		direction = "n"  # Norte (up)
	# Se não houver entrada de movimento, mantém a direção anterior e retorna
	if input_direction == Vector2.ZERO:
		return
	# Carrega a nova textura do sprite baseada na direção determinada
	var new_texture = load("res://assets/player/ang-%s.png" % direction)
	sprite.texture = new_texture
