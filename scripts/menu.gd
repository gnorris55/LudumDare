extends ColorRect

@onready var shape_controller = get_node("../shape_controller")
@onready var enemy_manager = get_node("../enemy_manager")
@onready var playerOverlay = get_node("../PlayerOverlay")

signal StartButton_pressed


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shape_controller.set_process(false)
	enemy_manager.set_process(false)
	playerOverlay.set_process(false)
	playerOverlay.visible = false


func _signal_StartButton_pressed() -> void:
	visible = false;
	emit_signal("StartButton_pressed")
	shape_controller.set_process(true)
	enemy_manager.set_process(true)
	playerOverlay.set_process(true)
	playerOverlay.visible = true
