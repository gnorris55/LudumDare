extends Label

var time = 0.0
@export var on = false


func _process(delta: float) -> void:
	if on:
		time += delta
		text = str(time).pad_decimals(1)


func StartTimer() -> void:
	time = 0.0
	on = true


func StopTimer() -> void:
	on = false
