extends RichTextLabel


var death_time = 2
var total_time = 0
var speed = 15
var a = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	total_time += delta
	if total_time> death_time:
		queue_free()
	position.y -= speed *delta
	a -= 0.7*delta
#	add_theme_color_override("default_color")
	add_theme_color_override("default_color",Color(1,0,0,a))
