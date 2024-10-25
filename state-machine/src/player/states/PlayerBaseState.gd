class_name PlayerBaseState
extends BaseState

var player:Player
var animation_player
@export var animation_name = ""

# Ao inicializar, referenciamos o animation player dentro do node do player.
func init(_context:Player) -> void:
	player = _context
	animation_player = player.animation_player
	super.init(_context)

# Ao entrar no estado, tocamos a animação que previamentes declaramos no editor.
func enter() -> void:
	if animation_name:
		animation_player.play(animation_name)
	super.enter()

func exit() -> void:
	super.enter()
