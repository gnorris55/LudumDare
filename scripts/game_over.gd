extends Control

@onready var enemiesNode = get_node("../enemy_manager") #Temporary enemy variable
@onready var shapesNode = get_node("../shape_controller") #Temporary shape variable

signal pressed_retry


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


func _from_PlayerOverlay_squeed_died() -> void:
	enemiesNode.set_process(false)
	shapesNode.set_process(false)
	await get_tree().create_timer(2.5).timeout
	for node in enemiesNode.get_children():
		node.queue_free()
	visible = true


func _on_retry_button_pressed() -> void:
	visible = false
	emit_signal("pressed_retry")
	shapesNode.set_process(true)
	enemiesNode.set_process(true)

func _on_exit_button_pressed() -> void:
	get_tree().quit()
