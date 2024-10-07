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
	print(str($Menu.volume_db) +" | "+ str($Intro.volume_db) +" | "+ str($Loop.volume_db))


func _signal_StartButton_pressed() -> void:
	$Menu.volume_db = -20.0
	$Menu.stop()
	$Intro.play()


func _on_Intro_finished() -> void:
	$Loop.play()
	$loop_adjustable.play()


func _signal_PlayerOverlay_squeedDied() -> void:
	var tween = create_tween()
	$Menu.play()
	tween.tween_property($Menu, "volume_db", 0, 2.5)
	tween.set_parallel()
	tween.tween_property($Intro, "volume_db", -80, 5)
	tween.set_parallel()
	tween.tween_property($Loop, "volume_db", -80, 5)
	$loop_adjustable.stop()
	$SqueebDie.play()
