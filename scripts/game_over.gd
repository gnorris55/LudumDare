extends Control

@onready var enemiesNode = get_node("../enemy_manager") #Temporary enemy variable
@onready var shapesNode = get_node("../shape_controller") #Temporary shape variable
@onready var playeroverlay = get_node("../PlayerOverlay")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


func _from_PlayerOverlay_squeed_died() -> void:
	enemiesNode.set_process(false)
	shapesNode.set_process(false)
	$TimeOfDeath.text = "Score: "+ str(playeroverlay.timer.time).pad_decimals(2) if str(playeroverlay.timer.time).pad_decimals(2) != "3.14" else "Score: Pi"
	#Ignore everything after the if, it usually doesn't apply.
	await get_tree().create_timer(2.5).timeout
	for node in enemiesNode.get_children():
		node.queue_free()
	visible = true


func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_exit_button_pressed() -> void:
	get_tree().quit()
