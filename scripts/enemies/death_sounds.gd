extends Node

@onready var death_sound_1: AudioStreamPlayer = $DeathSound1
@onready var death_sound_2: AudioStreamPlayer = $DeathSound2
@onready var death_sound_3: AudioStreamPlayer = $DeathSound3
@onready var death_sound_4: AudioStreamPlayer = $DeathSound4
@onready var death_sound_5: AudioStreamPlayer = $DeathSound5

var death_sounds = []

#var sounds = [death_sound_1, death_sound_2, death_sound_3, death_sound_4, death_sound_5]

func _init() -> void:
	pass

func _ready() -> void:
	death_sounds = [death_sound_1,death_sound_2,death_sound_3,death_sound_4,death_sound_5]



func play_death_sound():
	var random_sound = randi_range(0, 4)
	death_sounds[random_sound].play()
