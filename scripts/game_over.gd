extends Control

signal pressed_retry


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed_retry() -> void:
	visible = false
	emit_signal("pressed_retry")


func _on_player_overlay_squeed_died() -> void:
	visible = true
