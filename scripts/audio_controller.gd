extends Node

@onready var enemy_manager = get_node("../enemy_manager")

@export var ltdb = 0
@export var dbtl = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Menu.play()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var enemy_count = enemy_manager.get_child_count()
	var adjustable_volume = 2 * enemy_count - 100
	$loop_adjustable.volume_db = clampf(adjustable_volume, -100.0, 10.0)


func _signal_StartButton_pressed() -> void:
	$Menu.stop()
	$Intro.play()


func _on_Intro_finished() -> void:
	$Loop.play()
	$loop_adjustable.play()


func _signal_PlayerOverlay_squeedDied() -> void:
	$Intro.stop()
	$Loop.stop()
	$loop_adjustable.stop()
	$SqueebDie.play()
