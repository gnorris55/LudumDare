extends AnimatedSprite2D

@onready var heartsNode = get_node("../Hearts")
@export var maxHearts = 3;
@export var devTest: bool = false
var hearts

signal squeedDied


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hearts = maxHearts
	play("knight_idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_node2d_entered_squeed(body: Node2D) -> void:
	if body is Enemy:
		change_hearts(hearts - 1)
		if hearts == 0:
			play("knight_death")
			await get_tree().create_timer(4.0).timeout
			emit_signal("squeedDied")


func _input(event: InputEvent) -> void:
	if devTest: if event is InputEventKey and event.is_pressed(): if Input.is_key_pressed(KEY_L):	
		print("damage!")
		change_hearts(hearts - 1)
		if hearts == 0:
			play("knight_death")
			await get_tree().create_timer(4.0).timeout
			emit_signal("squeedDied")


func change_hearts(num: int) -> void:
	hearts = num
	heartsNode.set_hearts(hearts)
