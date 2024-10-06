extends Node2D

@onready var hearts = [$Heart1, $Heart2, $Heart3]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for heart in hearts:
		heart.visible = true
		heart.frame = 0
		heart.play("default")


func set_hearts(amount: int) -> void:
	var i = 0
	for heart in hearts:
		if (i >= amount):
			heart.visible = false
		else: heart.visible = true
		i += 1
