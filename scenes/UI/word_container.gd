extends HBoxContainer

@onready var character_line_scene:PackedScene = load("res://scenes/UI/character_line.tscn")

var word:String
var split:Array
var character_line
var delay:float


func populate(word):

	split = word.split("", true, 0)
	delay = 1/len(split)
	
	for character in split:
		delay += .1
		character_line = character_line_scene.instantiate()
		character_line.custom_minimum_size = Vector2(10,2)
		character_line.label_text = character
		add_child(character_line)
		character_line.start_timer(delay)
