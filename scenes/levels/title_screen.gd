extends Node2D

@onready var logo: TextureRect = $logo
@onready var parallax_2d: Parallax2D = $Parallax2D


var tween:Tween

func _ready() -> void:
	if not FileAccess.file_exists("user://Database.tres"):
		ResourceSaver.save(GameInfo.new(),"user://Database.tres")
	tween = create_tween()
	tween.finished.connect(move_background)
	tween.tween_property(logo, "position:y",-50, 8.6)



func move_background() -> void:
	parallax_2d.autoscroll = Vector2(-10,-10)
