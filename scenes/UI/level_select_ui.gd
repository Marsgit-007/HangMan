extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var text_box: NinePatchRect = $TextBox
@onready var text_edit: LineEdit = $TextBox/MarginContainer/TextEdit
@onready var confirm: MarginContainer = $Confirm
@onready var warning: MarginContainer = $Warning
@onready var warning_2: MarginContainer = $Warning2
@onready var warning_3: MarginContainer = $Warning3
@onready var database: GameInfo = preload("user://Database.tres")
@onready var history_button: TextureButton = $NinePatchRect/MarginContainer/VBoxContainer/HistoryButton
@onready var  TITLE_SCREEN = preload("uid://co317ev70xbl2")


const GREY_MATERIAL = preload("uid://1fv5sdq0ywj0")

var input_word:String
var regex = RegEx.new()
var split


func _ready() -> void:
	if !MusicPlayer.audio.stream == TITLE_SCREEN:
		MusicPlayer.audio.stream = TITLE_SCREEN
		MusicPlayer.audio.play()
	if database.data_base.is_empty():
		history_button.material = GREY_MATERIAL
		history_button.disabled = true
		
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
		else:
			animation_player.play("open_TextBox")





func _on_confirm_button_pressed() -> void:
	globals.word = text_edit.text.strip_edges().to_lower()
	SceneManager.fade_out()
	SceneManager.change_scene("res://scenes/levels/game_screen.tscn")


func _on_text_edit_text_changed(text_changed) -> void:
	input_word = text_edit.text.strip_edges()
	split = input_word.split(" ", true, 0)


		
	for word in split:
		if len(word) > 11:
			warning_2.visible = true
			confirm.visible = false
			warning.visible = false
			warning_3.visible = false
			return
		else:
			warning_2.visible = false
	if input_word.is_empty():
		confirm.visible = false
		warning.visible = false
		warning_2.visible = false
		warning_3.visible = false
	elif regex.search(input_word):
		confirm.visible = false
		warning.visible = true
		warning_2.visible = false
		warning_3.visible = false
		
	else:
		warning_3.visible = false
		warning_2.visible = false
		warning.visible = false
		confirm.visible = true
	if len(split) > 2:
		warning_3.visible = true
		confirm.visible = false
		warning.visible = false
		warning_2.visible = false
	


func _on_history_button_pressed() -> void:
	SceneManager.fade_out()
	SceneManager.change_scene("res://scenes/levels/history.tscn")


func _on_texture_button_pressed() -> void:
	SceneManager.fade_out()
	SceneManager.change_scene("res://scenes/levels/title_screen.tscn")
