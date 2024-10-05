extends Node

#var rng: RandomNumberGenerator

#rng = RandomNumberGenerator.new()
#rng.seed = OS.get_ticks_msec()

const enemy = preload("res://scenes/enemies/base_enemy.tscn")
const fast_enemy = preload("res://scenes/enemies/fast_enemy.tscn")
const slow_enemy = preload("res://scenes/enemies/slow_enemy.tscn")
var enemy_arr = [enemy, fast_enemy, slow_enemy]
var enemies = []
var total_time = 0.0
var accumulated_time = 0.0

# Called when the node enters the scene tree for the first time.

func initialize_enemy(enemy_instance, starting_position: Vector2 = Vector2(0, 0), target_position: Vector2 = Vector2(10, 0) ):
	enemy_instance.position = starting_position
	enemy_instance.target_position = target_position
	add_child(enemy_instance)

func fibonacci_sphere(radius: float = 1.0, random_value: float = 0.0) -> Vector2:
	
	
	var angle = random_value * 2*PI  # Scale to the range of 0 to PI

	# Calculate the random point on the circle
	var random_point = Vector2(radius * cos(angle), radius * sin(angle))
	
	return random_point
	
	#return points

func load_multiple_enemies(number_enemies: int):
	for i in range(number_enemies):
		var new_instance = enemy.instantiate()
		initialize_enemy(new_instance, Vector2(i*30, i*30))
		
		

func _ready() -> void:
	#load_multiple_enemies(5)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if (accumulated_time >= 1.0):
		#print("enemy should spawn")
		var enemy_spawn_index = randi_range(0, 2)
		var random_value = randf()
		
		#print(random_value)
		
		var new_instance = enemy_arr[enemy_spawn_index].instantiate()
		initialize_enemy(new_instance, fibonacci_sphere(200.0, random_value), Vector2(0, 0))
		accumulated_time -= 1.0
		
	#print(accumulated_time)
	
		
	total_time += delta
	accumulated_time += delta
	
