# Define uma classe `StateManager` que herda de `Node`
class_name StateManager
extends Node

# Exporta uma variável para definir o estado inicial no editor, esperado ser um `NodePath`
@export var starting_state:NodePath

# Variável que guarda o estado atual ativo, que deve ser do tipo `BaseState`
var current_state:BaseState

# Variável para armazenar o contexto, que pode ser qualquer objeto ao qual os estados precisam ter acesso
var context

# Função para trocar o estado atual por um novo estado
func change_state(new_state:BaseState) -> void:
	# Se houver um estado atual existente, chama seu método `exit`
	if current_state:
		current_state.exit()
	# Define o estado atual como o novo estado
	current_state = new_state
	# Chama o método `enter` no novo estado para inicializá-lo
	current_state.enter()

# Função de inicialização que configura o gerenciador de estados
func init(_context) -> void:
	# Inicializa todos os filhos com o contexto fornecido
	for child in get_children():
		child.init(_context)
	# Armazena o contexto para uso posterior
	context = _context
	# Se houver um estado inicial definido, muda para esse estado
	if starting_state:
		change_state(get_node(starting_state))
	else:
		# Exibe um erro se não encontrar um estado inicial definidso
		printerr("Não é possível inicializar o gerenciador de estados, estado inicial não encontrado.")

# Função chamada pelo contexto a cada frame de física para atualizar o estado atual
func physics_process(delta:float) -> void:
	current_state.physics_process(delta)

# Função para tratar eventos de entrada do contexto e passá-los para o estado atual
func input(event:InputEvent) -> void:
	current_state.input(event)

# Função chamada pelo contexto a cada frame para processar o estado atual
func process(delta:float) -> void:
	current_state.process(delta)
