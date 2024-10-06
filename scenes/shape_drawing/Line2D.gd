extends Line2D

var rng = RandomNumberGenerator.new()
var wobble_speed = 10
var wobble_range = 40
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_wobble(points1,theta):
#	clear_points()
	var i = 0
	for point in points1:
		if rng.randi_range(0,25) == 0:
#			point.x += rng.randi_range(-20,20)#10*sin(wobble_speed*theta)#10*rng.randi_range(-100,100)/100#sin(100*delta)#rng.randi_range(-5,5)
#			point.y += rng.randi_range(-20,20)#10*sin(wobble_speed*theta)
			print(points)
			points[i].x = point.x +rng.randi_range(-5,5)
			points[i].y = point.y +rng.randi_range(-5,5)
		i+=1
#	for point in points1:
#		point.x += 10*sin(wobble_speed*theta)#10*rng.randi_range(-100,100)/100#sin(100*delta)#rng.randi_range(-5,5)
#		point.y += 10*sin(wobble_speed*theta)
##		print(sin(30*delta))
#		add_point(point)
	#points = points1
func set_intermitant_points(points1):
	var i = 0
	clear_points()
	for point in points1:
		add_point(point)
		if i == len(points1) -2:
			var p1 = point#points[len(points)-2]
			var p2 = points1[len(points1)-1]
			var dist_between = point.distance_to(p2)
			var v2 =0# p2-p1#point - p1
			for j in range(1,5):
				v2 = p1-p2
				v2 = v2.limit_length(dist_between*(j/5))#*(j/5))
				var pj = p1 + v2
				pj.x += rng.randi_range(-wobble_range,wobble_range)
				pj.y += rng.randi_range(-wobble_range,wobble_range)
				add_point(pj)
		i+=1
