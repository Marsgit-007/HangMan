extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var text_box: NinePatchRect = $TextBox
@onready var text_edit: LineEdit = $TextBox/MarginContainer/TextEdit
@onready var confirm: MarginContainer = $Confirm
@onready var warning: MarginContainer = $Warning


var input_word:String
var ready_to_proceeed: bool = false
var regex = RegEx.new()



func _ready() -> void:

	regex.compile("[\\d]|[^a-zA-Z\\s]")
	text_edit.keep_editing_on_text_submit =  true
	text_box.visible = false
	text_box.size = Vector2(115,40)
	text_box.position = Vector2(205,70)

func _on_play_button_pressed() -> void:
		if text_box.visible == true:
			animation_player.play_backwards("open_TextBox")
			await animation_player.animation_finished
			text_box.visible = false
			if text_edit.text.strip_edges().is_empty():
				print("empty")
			else:
				print(text_edit.text.strip_edges())
				ready_to_proceeed = true
		else:
			animation_player.play("open_TextBox")





func _on_confirm_button_pressed() -> void:
	globals.word = text_edit.text.strip_edges()
	SceneManager.fade_out()
	SceneManager.change_scene("res://scenes/levels/game_screen.tscn")


func _on_text_edit_text_changed(new_text: String) -> void:
	input_word = text_edit.text.strip_edges()
	if input_word.is_empty():
		confirm.visible = false
		warning.visible = false
	elif regex.search(input_word):
		confirm.visible = false
		warning.visible = true

	else:
		warning.visible = false
		confirm.visible = true
	
