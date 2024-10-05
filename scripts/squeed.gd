extends AnimatedSprite2D

@export var devTest: bool
var hearts = 3
@onready var heartsNode = get_node("../Hearts")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("knight_idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	if devTest:
		if event is InputEventKey and event.is_pressed():
			if Input.is_key_pressed(KEY_L):
				print("damage!")
				hearts -= 1
				heartsNode.set_hearts(hearts)


func _on_node2d_entered_squeed(body: Node2D) -> void:
	if body is Enemy:
		hearts -= 1
		heartsNode.set_hearts(hearts)
