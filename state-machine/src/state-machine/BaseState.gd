class_name BaseState
extends Node

var context

func init(_context) -> void:
	context = _context

func enter() -> void:
	pass

func exit() -> void:
	pass

func process(_delta:float) -> void:
	pass

func physics_process(_delta:float) -> void:
	pass

func input(_event: InputEvent) -> void:
	pass
