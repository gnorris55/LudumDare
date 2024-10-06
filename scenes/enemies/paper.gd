extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_area_2d_area_entered(area):
	print("something has entered the paper")
	if (area.get_parent() != null):
		area.get_parent().toggle_visibility(true)
		#area.get_parent().take_damage(20)
		
	
func _process(delta: float) -> void:
	pass
