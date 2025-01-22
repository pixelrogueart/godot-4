class_name GUIBaseState
extends BaseState

var gui: GUI
@export var animation_name: String

func init(_context):
	gui = _context
	call("hide")

func enter() -> void:
	super.enter()
	call("show")

func input(_event: InputEvent) -> void:
	pass

func physics_process(_delta: float) -> void:
	pass

func process(_delta: float) -> void:
	pass

func exit() -> void:
	super.exit()
	call("hide")
