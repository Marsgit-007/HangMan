extends Control

@onready var word_label: RichTextLabel = $PanelContainer/HBoxContainer/VBoxContainer/Label
@onready var hangman_state: TextureRect = $PanelContainer/HBoxContainer/TextureRect
@onready var guess_label: RichTextLabel = $PanelContainer/HBoxContainer/VBoxContainer/RichTextLabel
@onready var hangman_frames: SpriteFrames =  preload("res://assets/graphics/animations/hangman.res")

var color


func populate(word,guess_num):
	word_label.text = "[color=black]%s[/color]"%[word]
	match guess_num:
		0,1,2,3:
			color = "green"
		4,5,6:
			color = "orange"
		7,8,9,10,11:
			color = "red"
	guess_label.text = "guess:[color=%s]%s[/color]"%[color, str(guess_num)]
	hangman_state.texture = hangman_frames.get_frame_texture("default", guess_num)
