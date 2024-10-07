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
	var tween = create_tween()
	tween.tween_property($Menu, "volume_db", 15, 2.5)
	await tween.finished
	$Intro.play()
	$Menu.stop()


func _on_Intro_finished() -> void:
	$Loop.play()
	$loop_adjustable.play()


func _signal_PlayerOverlay_squeedDied() -> void:
	$SqueebDie.play()
	$loop_adjustable.stop()
	# Fucking Tweens ---------
	var tween = create_tween()
	$Menu.volume_db = -20.0
	$Menu.play()
	tween.tween_property($Menu, "volume_db", 0, 2.5)
	tween.set_parallel()
	tween.tween_property($Intro, "volume_db", -80, 5)
	tween.set_parallel()
	tween.tween_property($Loop, "volume_db", -80, 5)
