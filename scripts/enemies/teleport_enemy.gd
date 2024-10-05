extends Node2D


@onready var health_bar: ProgressBar = $ProgressBar

@export var speed = 60.0
@export var health = 50

var teleport_radius = 200
var starting_position = Vector2(100, 100)
#center of circle
var target_position = Vector2(0, 0)
var accumulator = 0.0

func _ready():
	health_bar.max_value = health
	print("current speed: " + str(speed))

func _init():
	#.value = 33.0
	#$ProgressBar.tex
	#progress_bar.value = 50
	position = starting_position
	
func fibonacci_sphere(radius: float = 1.0, random_value: float = 0.0) -> Vector2:
	var angle = random_value * 2*PI  # Scale to the range of 0 to PI

	# Calculate the random point on the circle
	var random_point = Vector2(radius * cos(angle), radius * sin(angle))
	
	return random_point
	
	#return points

func movement(delta: float):
	
	# this is going to be the center
	#var direction_vector = distance_vector.normalized()
	
	if ((position - target_position).length() < 0.5):
		print("reached destination")
		queue_free()
	
	if (accumulator > 2.0):	
		teleport_radius -= 20
		var random_value = randf()

		position = target_position + fibonacci_sphere(teleport_radius, random_value)
		accumulator -= 1.0
	
	accumulator += delta
	
	#position += delta*speed*direction_vector
# Called every frame. 'delta' is the elapsed time since the previous frame.
func take_damage(damage: int):
	health_bar.value -= damage

func _process(delta: float) -> void:
	movement(delta)
