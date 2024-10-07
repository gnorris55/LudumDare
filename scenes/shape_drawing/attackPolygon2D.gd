extends Polygon2D

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func set_wobble(points1):
	var i = 0
	for point in points1:
		if rng.randi_range(0,25) == 0:
			polygon[i].x = point.x +rng.randi_range(-20,20)
			polygon[i].y = point.y +rng.randi_range(-20,20)
		i+=1
