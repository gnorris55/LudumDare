extends Node2D

class_name Enemy

@export var speed = 60.0
@export var health = 50

var starting_position = Vector2(100, 100)
var target_position = Vector2(0, 0)

func _ready():
	print("current speed: " + str(speed))

func _init():
	position = starting_position
	
func movement(delta: float):
	var distance_vector = target_position - position
	var direction_vector = distance_vector.normalized()
	
	if ((position - target_position).length() < 0.5):
		print("reached destination")
		queue_free()
	
	position += delta*speed*direction_vector
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	movement(delta)
