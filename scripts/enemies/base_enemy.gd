extends Node2D

class_name Enemy

@onready var health_bar: ProgressBar = $ProgressBar

@export var speed = 60.0
@export var health = 50

var starting_position = Vector2(100, 100)
var target_position = Vector2(0, 0)

func _ready():
	health_bar.max_value = health
	print("current speed: " + str(speed))

func _init():
	#.value = 33.0
	#$ProgressBar.tex
	#progress_bar.value = 50
	position = starting_position
	
func movement(delta: float):
	var distance_vector = target_position - position
	var direction_vector = distance_vector.normalized()
	
	if ((position - target_position).length() < 0.5):
		print("reached destination")
		queue_free()
	
	position += delta*speed*direction_vector
# Called every frame. 'delta' is the elapsed time since the previous frame.
func take_damage(damage: int):
	health_bar.value -= damage

func _process(delta: float) -> void:
	movement(delta)
