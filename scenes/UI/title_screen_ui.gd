extends Control

@onready var help_dialog:= $HelpDialog/NinePatchRect
@onready var settings_dialog:= $SettingsDialog/NinePatchRect
@onready var animation_player:= $AnimationPlayer

enum SoundIcons {
	MUTE = 188,
	LOW = 188+47,
	MEDIUM = 188+47+47,
	HIGH = 188+47+47+47
}

func _ready() -> void:
	settings_dialog.visible  = false
	settings_dialog.custom_minimum_size = Vector2(0,0)



func _on_help_button_pressed() -> void:
	if help_dialog.visible == true:
		help_dialog.visible = false
	if help_dialog.visible == false:
		help_dialog.visible = true
	


func _on_settings_button_pressed() -> void:
	if help_dialog.visible == true:
		help_dialog.visible = false
	if settings_dialog.visible == false:
		animation_player.play("open_SettingsDialog")
	else:
		animation_player.play_backwards("open_SettingsDialog")
		await animation_player.animation_finished
		settings_dialog.visible = false
		
