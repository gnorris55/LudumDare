extends Node2D

@onready var squeedNode = $Squeed
@onready var heartsController = $HeartsController
@onready var timer = $Timer

@export var maxHearts = 3;

var hearts

signal squeedDied


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hearts = maxHearts
	pass # Replace with function body.
	
	
func _Squeed_Area2D_entered(area: Area2D) -> void:
	take_damage()


func take_damage() -> void:
	change_hearts(hearts-1)
	if hearts == 0:
		SqueebDies()
		return
	elif hearts < 0: return
	squeedNode.play("squeeb_damage")
	await get_tree().create_timer(1).timeout
	squeedNode.play("squeeb_idle")

func SqueebDies() -> void:
	squeedNode.play("squeeb_death")
	timer.StopTimer()
	emit_signal("squeedDied")
	pass

func _from_GameOver_pressed_retry() -> void:
	change_hearts(maxHearts)
	squeedNode.play("squeeb_idle")
	timer.StartTimer()


func change_hearts(num: int) -> void:
	hearts = num
	heartsController.set_hearts(hearts)


#func _input(event: InputEvent) -> void:
	#iif event is InputEventKey and event.is_pressed(): if Input.is_key_pressed(KEY_L):
		#take_damage()
