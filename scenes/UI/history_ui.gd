extends Control

@onready var v_box_container: VBoxContainer = $MarginContainer/NinePatchRect/MarginContainer/ScrollContainer/VBoxContainer

var data: GameInfo = preload("user://Database.tres")
var history_card_scene: PackedScene = preload("res://scenes/UI/history_card.tscn")
var history_card

func _ready() -> void:
	var database = data.data_base
	for word in database:
		var guess_num = database[word]
		history_card = history_card_scene.instantiate()
		v_box_container.add_child(history_card)
		history_card.populate(word, guess_num)
		
		


func _on_texture_button_pressed() -> void:
	SceneManager.fade_out()
	SceneManager.change_scene("res://scenes/levels/level_select.tscn")
