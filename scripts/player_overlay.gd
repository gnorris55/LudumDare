extends Node2D

@onready var squeedNode = $Squeed
signal squeedDied

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_game_over_pressed_retry() -> void:
	squeedNode.change_hearts(squeedNode.maxHearts)
	squeedNode.play("knight_idle")


func _on_squeed_squeed_died() -> void:
	emit_signal("squeedDied")
