@tool
class_name SelectionWheel
extends Control
const SPRITE_SIZE = Vector2(12,12)

enum Option {
	NONE,
	REMOVE_MAGAZINE,
	INSERT_MAGAZINE,
	CYCLE_CHAMBER,
	DROP
}

signal drop
signal cycle
signal remove_mag
signal insert_mag

@onready var label = $Label

@export var line_width:int = 4
@export var bkg_color:Color
@export var line_color:Color
@export var highlight_color:Color
@export var outer_radius:int = 128
@export var inner_radius:int = outer_radius/2
@export var options:Array[WheelOption] = []

var selection = 0
@export var draw_menu = false

func select(_selection):
	emit_signal(options[_selection]._signal)

func _draw() -> void:
	if !draw_menu:
		if label:
			label.text = ""
		return
	var offset = SPRITE_SIZE/-2
	draw_circle(Vector2.ZERO, outer_radius,bkg_color)
	draw_arc(Vector2.ZERO, inner_radius, 0, TAU, outer_radius/2, line_color, line_width)
	if len(options) >= 3:
		for i in range(len(options) - 1):
			var rads = TAU * i / ((len(options) - 1))
			var point = Vector2.from_angle(rads)
			draw_line(
				point*inner_radius,
				point*outer_radius,
				line_color,
				line_width
			)
		
		if selection == 0:
			draw_circle(Vector2.ZERO, inner_radius, highlight_color)
			label.text = ""
		else:
			if !options[selection].available:
				label.text = ""
			if options[selection].available:
				draw_texture_rect_region(
					options[selection].atlas,
					Rect2(offset,SPRITE_SIZE),
					options[selection].region
				)
				label.text = options[selection].name
		
		for i in range(1, len(options)):
			var start_rads = (TAU * (i-1)) / (len(options) - 1)
			var end_rads = (TAU * i) / (len(options) - 1)
			var mid_rads = (start_rads + end_rads)/2.0 * -1
			var radius_mid = (inner_radius + outer_radius) / 2
			if selection == i: 
				if options[selection].available:
					var points_per_arc = 32
					var points_inner = PackedVector2Array()
					var points_outer = PackedVector2Array()
					for j in range(points_per_arc + 1):
						var angle = start_rads + j * (end_rads - start_rads) / points_per_arc
						points_inner.append(inner_radius * Vector2.from_angle(TAU-angle))
						points_outer.append(outer_radius * Vector2.from_angle(TAU-angle))
					points_outer.reverse()
					draw_polygon(points_inner + points_outer, PackedColorArray([highlight_color]))
			var draw_pos = radius_mid * Vector2.from_angle(mid_rads) + offset
			
			draw_texture_rect_region(
				options[i].atlas,
				Rect2(draw_pos,SPRITE_SIZE),
				options[i].region
			)

func _process(delta: float) -> void:
	if draw_menu:
		var mouse_pos = get_local_mouse_position()
		var mouse_radius = mouse_pos.length()
		if mouse_radius < inner_radius:
			selection = 0
		else:
			var mouse_rads = fposmod(mouse_pos.angle() * -1, TAU)
			selection = ceil((mouse_rads / TAU )*(len(options) - 1))
	if !draw_menu:
		if selection != 0:
			select(selection)
			selection = 0
	queue_redraw()
