extends Button

signal pressed_retry


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "Retry?"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _pressed() -> void:
	text = "Ok!"
	emit_signal("pressed_retry")
	await get_tree().create_timer(1.0).timeout
	print('after timeout')
	text = "Retry?"
