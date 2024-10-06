extends Node2D


@onready var health_bar: ProgressBar = $HealthBar
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

@onready var damage_particles: CPUParticles2D = $CPUParticles2D
@onready var teleport_particles: CPUParticles2D = $TeleportParticles

@export var speed = 60.0
@export var health = 50

var teleport_radius = 350
var starting_position = Vector2(100, 100)
#center of circle
var target_position = Vector2(0, 0)
var total_time = 0.0
var accumulator = 0.0
var spawn_rate = 6.0
var teleporting = false

func _ready():
	health_bar.max_value = health
	teleport_particles.emitting = false
	toggle_visibility(false)
	#timer.connect("timeout", self, "_on_timer_timeout")
	#print("current speed: " + str(speed))

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
	
	# temporary function so that scene does not get cluttered
	if ((position - target_position).length() < 0.5):
		queue_free()
	
	
	if (accumulator > spawn_rate):	
		teleport_radius -= 50
		print(accumulator)
		animated_sprite.play("teleport")
		teleport_particles.emitting = true
		accumulator -= spawn_rate
		
		timer.start()
		
	
	accumulator += delta
	
func teleport():
	var random_value = randf()
	position = target_position + fibonacci_sphere(teleport_radius, random_value)
	

var teleport_state = 0

func _on_timer_timeout() -> void:
	if (teleport_state == 0):	
		print("state 0")
		teleport()
		animated_sprite.play("teleport2")
		teleport_state = 1
		timer.start()
	elif (teleport_state == 1):
		print("state 1")
		animated_sprite.play("default animation")
		teleport_particles.emitting = false
		teleport_state = 0
		timer.stop()
	if (teleport_state == 2):
		queue_free()
	
	#position += delta*speed*direction_vector
# Called every frame. 'delta' is the elapsed time since the previous frame.
func take_damage(damage: int):
	health -= damage
	if (health <= 0):
		timer.start()
		animated_sprite.visible = false
		health_bar.visible = false
		teleport_state = 2
	health_bar.set_value(health)
	damage_particles.emitting = true

func toggle_visibility(is_visible: bool) -> void:
	visible = is_visible
	

func _process(delta: float) -> void:
	movement(delta)
