extends Node

#ima work on this later
var points = []
var dots = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var dot_scene = preload("res://scenes/shape_drawing/dot.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("add point"):
		var size = get_viewport().size
		var point = get_viewport().get_mouse_position()
		point.x -= size.x/2
		point.y -= size.y/2
		points.append(point)
		var dot = dot_scene.instantiate()
		add_child(dot)
		dots.append(dot)
		dot.position = point
		$Line2D.add_point(point)
		
	if Input.is_action_pressed("finish shape"):
		finish_shape()
		
		
	
#when the mouse is down add a dot 
func finish_shape():
	deleate_dots()
	deleate_line()
	$Polygon2D.polygon = points
	#points = []
	$attack_delay.start()
	#points = []
func deleate_line():
	$Line2D.points = []
func deleate_dots():
	for dot in dots:
		dots.erase(dot)
		dot.queue_free()
	
#may need to have it so that colision polygon is only created when attack is finisshed


func _on_attack_delay_timeout():
	$Polygon2D.polygon = []
	$Area2D/CollisionPolygon2D.polygon = points
	$kill_zone_delay.start()

	points = []
	#pass # Replace with function body.


func _on_kill_zone_delay_timeout():
	$Area2D/CollisionPolygon2D.polygon = []
	print($Area2D/CollisionPolygon2D.polygon)


#func _on_collision_polygon_2d_child_entered_tree(node):
	

func _on_area_2d_area_entered(area):
	print("colision with an enemy")
	#pass # Replace with function body.
