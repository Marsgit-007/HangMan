extends Node2D

@onready var game_screen_ui: Control = $CanvasLayer/GameScreenUI
@onready var hangman_sprite: AnimatedSprite2D = $CanvasLayer/Hangman
@onready var fall_timer: Timer = $FallTimer
@onready var database = preload("res://save/Database.tres")
@onready var finish_timer: Timer = $FinishTimer
@onready var action_bgm: AudioStream = preload("res://assets/audio/background/bgm_action_4.mp3")



var tween:Tween


func _ready() -> void:
	MusicPlayer.audio.stop()
	MusicPlayer.audio.stream = action_bgm
	MusicPlayer.audio.play()
	hangman_sprite.frame = 0
	game_screen_ui.HangTheMan.connect(hangman)
	game_screen_ui.game_won.connect(finished)
	

func hangman():
	hangman_sprite.frame += 1
	if hangman_sprite.frame == 11:
		hangman_sprite.play("death")
		game_screen_ui.death()
		fall_timer.start()
		
		

func finished():
	database.data_base[globals.word] = hangman_sprite.frame
	print(database.data_base)
	ResourceSaver.save(database)
	hangman_sprite.play("dance")
	finish_timer.start()

func death_finished():
	database.data_base[globals.word] = 11
	print(database.data_base)
	ResourceSaver.save(database)





func _on_fall_timer_timeout() -> void:
	death_finished()
	hangman_sprite.play("fall")
	tween = create_tween()
	tween.tween_property(hangman_sprite, "position:y", 250, 1)
	finish_timer.start(2)


func _on_finish_timer_timeout() -> void:
	SceneManager.fade_out()
	SceneManager.change_scene("res://scenes/levels/level_select.tscn")
