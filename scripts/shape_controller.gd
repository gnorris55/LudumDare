extends Node2D

#ima work on this later
var points = []
var dots = []
var overshot_lines = []
var attacking = false
const MAX_DIST = 400
var theta = 0
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	#$Line2D.texture = load("res://assets/sprites/dot.png")
	pass # Replace with function body.

const DOT_SCENE = preload("res://scenes/shape_drawing/dot.tscn")
const OVERSHOT_LINE_SCENE = preload("res://scenes/shape_drawing/overshot_line.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if rng.randi_range(0,10) == 0:
		$Polygon2D.visible = true
	if rng.randi_range(0,10) == 0:
		$Polygon2D.visible = false
	if attacking:
		$Polygon2D.color[3] += delta*3
	else:
		theta += delta
		$Line2D.set_wobble(points,theta)
	if Input.is_action_just_pressed("add point"):
		var point = get_global_mouse_position()
		if len(points):
			var overshot_point = point
			var p1 = points[len(points)-1]
			var v2 = point -p1
			v2 = v2.limit_length(MAX_DIST)#
			point = p1 + v2
#			var overshot_line = OVERSHOT_LINE_SCENE.instantiate()
#			overshot_lines.append(overshot_line)
#			overshot_line.add_point(point)
#			overshot_line.add_point(overshot_point)
#			add_child(overshot_line)
		
		$drawing_line.visible = true
		$drawing_line.set_point_position(0,point)# = point
		points.append(point)
#		if len(points):
#			$Line2D.set_intermitant_points(points)
		#if len(points) < 2:
		var dot = DOT_SCENE.instantiate()
		add_child(dot)
		dots.append(dot)
		dot.position = point
		$Line2D.add_point(point)
	if len(points):
		$drawing_line.set_point_position(1,get_global_mouse_position()) 
	else:
		$drawing_line.visible = false
		
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
		$Polygon2D.color[3] = 0.4
	$kill_zone_delay.start()
	points = []
	


func _on_kill_zone_delay_timeout():
	$slash/CollisionShape2D.disabled = true
	$vaporize/CollisionPolygon2D.polygon = []
	
	#print($vaporize/CollisionPolygon2D.polygon)


#func _on_collision_polygon_2d_child_entered_tree(node):
func damage_enemies(area,damage):
	if (area.get_parent() != null and area.get_parent() != AnimatedSprite2D):
		if (area.get_parent().name != "Squeed"):
			area.get_parent().take_damage(damage)

func _on_area_2d_area_entered(area):
	#if area.name == "vaporize":
		#do shit
	#print(area)
	damage_enemies(area,40)
	
	print(area.name)
	print("colision with an enemy")
	
	print(area.get_parent())
#	try:


	#pass # Replace with function body.

 

func _on_bomb_area_entered(area):
	print(area.name)
	print("bomb")
	damage_enemies(area,100)
	
	#pass # Replace with function body.


func _on_slash_area_entered(area):
	print("slash")
	damage_enemies(area,100)
	#pass # Replace with function body.
