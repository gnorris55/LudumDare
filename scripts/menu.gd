extends ColorRect

@onready var shape_controller = get_node("../shape_controller")
@onready var enemy_manager = get_node("../shape_controller")
@onready var playerOverlay = get_node("../Player Overlay")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shape_controller.set_process(false)
	enemy_manager.set_process(false)
	playerOverlay.set_process(false)


func _start_game() -> void:
	visible = false;
	shape_controller.set_process(true)
	enemy_manager.set_process(true)
	playerOverlay.set_process(true)
