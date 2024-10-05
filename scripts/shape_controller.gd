extends Node2D

#ima work on this later
var points = []
var dots = []
var overshot_lines = []
var attacking = false
const MAX_DIST = 400
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

const DOT_SCENE = preload("res://scenes/shape_drawing/dot.tscn")
const OVERSHOT_LINE_SCENE = preload("res://scenes/shape_drawing/overshot_line.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if attacking:
		$Polygon2D.color[3] += delta/2
	if Input.is_action_just_pressed("add point"):
		var size = get_viewport().size
		var point = get_global_mouse_position()
		print(point)
		if len(points):
			var overshot_point = point
			var p1 = points[len(points)-1]
			print("diastance",p1.distance_to(point))
			var v2 = point -p1
			v2 = v2.limit_length(MAX_DIST)#)
			point = p1 + v2
			var overshot_line = OVERSHOT_LINE_SCENE.instantiate()
			overshot_lines.append(overshot_line)
			overshot_line.add_point(point)
			overshot_line.add_point(overshot_point)
			add_child(overshot_line)
			#$Line2D
			#if points[len(points)-1].distance_to(point) >= MAX_DIST:
				
				#we want to create a vector from point 1 to point 2 and then set magnitude to max distance
				
		points.append(point)
		var dot = DOT_SCENE.instantiate()
		add_child(dot)
		dots.append(dot)
		dot.position = point
		$Line2D.add_point(point)
		
	if Input.is_action_pressed("finish shape"):
		finish_shape()
		
		
	
#when the mouse is down add a dot 
func finish_shape():
	attacking = true
	deleate_dots()
	deleate_line()
	deleate_overshot_lines()
	if len(points) == 1:#creates a bomb
		$bomb/CollisionShape2D.disabled = false
		$bomb.position = points[0]
	elif len(points) ==2:#slash attack
		$slash_line.add_point(points[0])# = points
		$slash_line.add_point(points[1])
	else:
		$Polygon2D.polygon = points
	
	$attack_delay.start()
	
func deleate_line():
	$Line2D.points = []
func deleate_dots():
	for dot in dots:
		dots.erase(dot)
		dot.queue_free()
func deleate_overshot_lines():
	for overshot_line in overshot_lines:
		overshot_lines.erase(overshot_line)
		overshot_line.queue_free()
#may need to have it so that colision polygon is only created when attack is finisshed


func _on_attack_delay_timeout():
	attacking = false
	$Polygon2D.polygon = []
	$slash_line.clear_points()
	
	if len(points) == 1:#bomb
		$bomb/CollisionShape2D.disabled = true
	if len(points) == 2:#2 points create a slash
		$slash/CollisionShape2D.disabled = false
		var shape = $slash/CollisionShape2D.get_shape()
		shape.a = points[0]
		shape.b = points[1]
		
	else:
		$vaporize/CollisionPolygon2D.polygon = points
		$Polygon2D.color[3] = 0
	$kill_zone_delay.start()
	points = []
	


func _on_kill_zone_delay_timeout():
	$slash/CollisionShape2D.disabled = true
	$vaporize/CollisionPolygon2D.polygon = []
	
	#print($vaporize/CollisionPolygon2D.polygon)


#func _on_collision_polygon_2d_child_entered_tree(node):
	

func _on_area_2d_area_entered(area):
	#if area.name == "vaporize":
		#do shit
	#print(area)
	
	print(area.name)
	print("colision with an enemy")
	#pass # Replace with function body.


func _on_bomb_area_entered(area):
	print(area.name)
	print("bomb")
	#pass # Replace with function body.


func _on_slash_area_entered(area):
	print("slash")
	#pass # Replace with function body.
