extends Sprite2D


#var end_point = Vector2(0,0)
var time_to_point = 0.5#the overal time to travel
var d_vector = 0 
var total_delta = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#position.x += end_point
	var my_vec = d_vector.limit_length(d_vector.length()*delta/time_to_point)
#	print(d_vector)
#	print("vec",my_vec)
	position.x += my_vec.x
	position.y += my_vec.y
	total_delta += delta
	if total_delta > time_to_point:
		queue_free()
	#move_toward(position,end_point,delta)
	#pass

func set_direction_v(start,end):
	d_vector = end- start
	position.x = start.x
	position.y = start.y
