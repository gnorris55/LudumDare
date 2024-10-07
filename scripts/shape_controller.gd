extends Node2D

#ima work on this later
var points = []
var dots = []
var overshot_lines = []
var attacking = false
const MAX_DIST = 400
const MAX_TOTAL_DIST = 1000
var theta = 0
var rng = RandomNumberGenerator.new()

var total_dist = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	#$Line2D.texture = load("res://assets/sprites/dot.png")
	pass # Replace with function body.

const DOT_SCENE = preload("res://scenes/shape_drawing/dot.tscn")
const OVERSHOT_LINE_SCENE = preload("res://scenes/shape_drawing/overshot_line.tscn")
const SLASH_ERASER_SCENE = preload("res://scenes/shape_drawing/slash_eraser.tscn")
const SHOCKWAVE_SCENE = preload("res://scenes/shape_drawing/shockwave.tscn")
const BOMB_EFFECTS_SCENE = preload("res://scenes/shape_drawing/bomb_effcts.tscn")
const NO_MORE_INK_SCENE = preload("res://scenes/shape_drawing/no_more_ink.tscn")


func _process(delta):
	if attacking:
		$Polygon2D.color[3] += delta*3
#		if len(points) >2:
#			$Polygon2D.set_wobble(points)
	else:
		theta += delta
		$Line2D.set_wobble(points,theta)
		if Input.is_action_just_pressed("add point"):
			$click.playing = true
			if total_dist < MAX_TOTAL_DIST:
				var point = get_global_mouse_position()
				if len(points):
					$draw_line_sound.playing = true
					var overshot_point = point
					var p1 = points[len(points)-1]
					var v2 = point -p1
					v2 = v2.limit_length(MAX_DIST)#
					point = p1 + v2
					total_dist += v2.length()
					
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
				dot.play("default")
				$Line2D.add_point(point)
			else:
				$invalid_line_sound.playing = true
				var i = NO_MORE_INK_SCENE.instantiate()
				add_child(i)
				i.position = get_global_mouse_position()#points[len(points)-1]
				
	if len(points):
		$drawing_line.set_point_position(1,get_global_mouse_position()) 
	else:
		$drawing_line.visible = false
		
	if Input.is_action_just_pressed("finish shape"):
		finish_shape()
		
		
	
#when the mouse is down add a dot 
func finish_shape():
	attacking = true
	deleate_dots()
	deleate_line()
	deleate_overshot_lines()
	total_dist = 0
	if len(points) == 1:#creates a bomb
		$bomb/CollisionShape2D.disabled = false
		$bomb.position = points[0]
		var b = SHOCKWAVE_SCENE.instantiate()
		b.position = points[0]
		b.emitting = true
		
		add_child(b)
		
	elif len(points) ==2:#slash attack
		$eraser_sound.playing = true
		var s = SLASH_ERASER_SCENE.instantiate()
		print("created a slash eraser")
		add_child(s)
		s.set_direction_v(points[0],points[1])
		$slash_line.add_point(points[0])# = points
		$slash_line.add_point(points[1])
		#$slash_line.visible = true
	else:
		$vaporize_sound.playing = true
		$Polygon2D.polygon = points
	
	$attack_delay.start()
	
func deleate_line():
	$Line2D.points = []
func deleate_dots():
	while len(dots):
		if len(dots):
			dots[0].queue_free()
			dots.erase(dots[0])
#	for dot in dots:
#		dots.erase(dot)
#		dot.queue_free()
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
		$bomb_sound.playing = true
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
		print(area.name)
		if (area.name != "bomb" and area.name != "slash" and area.name != "vaporize"):#stop it from coliding with another thing
			area.get_parent().take_damage(damage)

func _on_area_2d_area_entered(area):
	#if area.name == "vaporize":
		#do shit

	damage_enemies(area,40)
#	try:


	#pass # Replace with function body.

 

func _on_bomb_area_entered(area):
	print(area.name)
	print("bomb")
	damage_enemies(area, 60)
	
	#pass # Replace with function body.


func _on_slash_area_entered(area):
	print("slash")
	damage_enemies(area,100)
	#pass # Replace with function body.
