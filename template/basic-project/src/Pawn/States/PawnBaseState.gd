class_name PawnBaseState
extends BaseState

var pawn: Pawn
@export var animation_name: String

func init(_context):
	pawn = _context

func enter() -> void:
	super.enter()

func input(_event: InputEvent) -> void:
	pass

func physics_process(_delta: float) -> void:
	pass

func process(_delta: float) -> void:
	pass

func exit() -> void:
	super.exit()
