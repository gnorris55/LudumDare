extends Node2D

class_name Enemy

@onready var health_bar: ProgressBar = $HealthBar
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var damage_particles: CPUParticles2D = $CPUParticles2D
@onready var spawn_particles: CPUParticles2D = $SpawnParticles

@onready var timer: Timer = $Timer

@export var speed = 60.0
@export var health = 50

var starting_position = Vector2(100, 100)
var target_position = Vector2(0, 0)

func _ready():
	health_bar.max_value = health
	toggle_visibility(false)
	#print("current speed: " + str(speed))

func _init():
	#.value = 33.0
	#$ProgressBar.tex
	#progress_bar.value = 50
	position = starting_position

	
func movement(delta: float):
	var distance_vector = target_position - position
	var direction_vector = distance_vector.normalized()
	
	if (direction_vector.x > 0 and animated_sprite.flip_h == false):
		animated_sprite.flip_h = true
	elif (direction_vector.x < 0 and animated_sprite.flip_h == true):
		animated_sprite.flip_h = false
	
	if ((position - target_position).length() < 0.5):
		#print("reached destination")
		queue_free()
	
	position += delta*speed*direction_vector
# Called every frame. 'delta' is the elapsed time since the previous frame.
func take_damage(damage: int):
	health -= damage
	damage_particles.emitting = true
	if (health <= 0):
		timer.start()
		animated_sprite.visible = false
		health_bar.visible = false
		
	health_bar.set_value(health)

func toggle_visibility(is_visible: bool) -> void:
	visible = is_visible
	spawn_particles.emitting = true

func _process(delta: float) -> void:
	#print(health)
	movement(delta)


func _on_timer_timeout() -> void:
	queue_free()
