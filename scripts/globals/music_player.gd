extends Node

@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var sfx: AudioStreamPlayer = $sfx

@export var background_vol:float = 1.0:
	set(value):
		print("changed background to:", value)
		audio.volume_db = linear_to_db(value/3)
@export var sfx_vol:float = 1.0:
	set(value):
		print("changed sfx to:", value)
		sfx.volume_db = linear_to_db(value/3)
		

func _ready() -> void:
	audio.volume_db = linear_to_db(background_vol/3)
	sfx.volume_db = linear_to_db(sfx_vol/3)
