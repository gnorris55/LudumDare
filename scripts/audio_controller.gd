extends Node

@onready var enemy_manager = get_node("../enemy_manager")

@export var ltdb = 0
@export var dbtl = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Menu.volume_db -= 30
	print($Menu.volume_db)
	$Menu.play()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var enemy_count = enemy_manager.get_child_count()
	var adjustable_volume = enemy_count - 40
	$loop_adjustable.volume_db = clampf(adjustable_volume, -100.0, 0.0)
	#if enemy_count > 26:
		#$loop_adjustable.volume_db = 0
	#else: $loop_adjustable.volume_db = -80
	#print(str(enemy_count))


func _signal_StartButton_pressed() -> void:
	var tween = create_tween()
	tween.tween_property($Menu, "volume_db", -20, 2.5)
	await tween.finished
	$Intro.volume_db -= 20
	$Intro.play()
	$Menu.stop()


func _on_Intro_finished() -> void:
	$Loop.volume_db -= 20
	$Loop.play()
	$loop_adjustable.play()


func _signal_PlayerOverlay_squeedDied() -> void:
	$SqueebDie.play()
	$loop_adjustable.stop()
	# Fucking Tweens ---------
	var tween = create_tween()
	$Menu.volume_db = -20.0
	$Menu.play()
	tween.tween_property($Menu, "volume_db", -30, 2.5)
	tween.set_parallel()
	tween.tween_property($Intro, "volume_db", -80, 5)
	tween.set_parallel()
	tween.tween_property($Loop, "volume_db", -80, 5)
