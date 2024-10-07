extends Node


#var sounds = [death_sound_1, death_sound_2, death_sound_3, death_sound_4, death_sound_5]

func _init() -> void:
	pass

func _ready() -> void:
	pass # Replace with function body.



func play_death_sound():
	var random_sound = randi_range(0, 4)
	##sounds[random_sound].Playing = true 
