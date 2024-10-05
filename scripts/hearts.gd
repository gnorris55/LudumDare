extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_hearts(amount: int) -> void:
	match amount:
		0: play("hp_0")
		1: play("hp_1")
		2: play("hp_2")
		3: play("hp_3")
