extends Node2D

@onready var squeedNode = $Squeed
@onready var heartsController = $HeartsController
@onready var timer = $Timer

@export var maxHearts = 3;
@export var hearts: int

signal squeedDied
signal animation_finished


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hearts = maxHearts
	pass # Replace with function body.


func _signal_Squeeb_animation_finished() -> void:
	emit_signal("animation_finished")


func _Squeed_Area2D_entered(area: Area2D) -> void:
	change_hearts(hearts-1)
	if hearts == 0:
		emit_signal("animation_finished")
		SqueebDies()
		return
	elif hearts < 0: return
	$Squeek.play()
	squeedNode.play("squeeb_damage")
	await animation_finished
	squeedNode.play("squeeb_idle")
	print("1: "+ str(hearts) +" | "+ str(typeof(hearts)))


func change_hearts(num: int) -> void:
	hearts = num
	heartsController.set_hearts(hearts)


func signal_MenuBox_StartButton_pressed() -> void:
	timer.StartTimer()


func SqueebDies() -> void:
	squeedNode.play("squeeb_death")
	timer.StopTimer()
	emit_signal("squeedDied")
	timer.visible = false
	print("2: "+ str(hearts))
