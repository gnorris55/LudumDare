extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _draw():
	#draw_line(Vector2(0, 0), Vector2(1, 1), Color(1.0, 0.0, 0.0))
	draw_arc(Vector2(0.0,0.0), 500, 0, 2 * PI, 100, Color(1.0, 0.0, 0.0))
	for i in range(10):
		draw_arc(Vector2(0.0,0.0), 450 - i*50, 0, 2 * PI, 100, Color(0.0, 1.0, 0.0, 0.1))
	
	#draw_arc(center, radius, start_angle, end_ang
