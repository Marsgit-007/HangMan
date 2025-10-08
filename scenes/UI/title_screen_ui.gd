extends Control


@onready var settings_dialog:= $SettingsDialog/NinePatchRect
@onready var animation_player:= $AnimationPlayer
@onready var sound_icon_1: TextureRect = $SettingsDialog/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/SoundIcon1
@onready var sound_icon_2: TextureRect = $SettingsDialog/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer2/SoundIcon2


enum SoundIcons {
	MUTE = 188,
	LOW = 188+47,
	MEDIUM = 188+47+47,
	HIGH = 188+47+47+47
}

func _ready() -> void:
	settings_dialog.visible  = false

	settings_dialog.custom_minimum_size = Vector2(0,0)
	#sound_icon_1.texture.region = Rect2(SoundIcons.HIGH, 62,47,31)
	
	
func _on_settings_button_pressed() -> void:
	if settings_dialog.visible == false:
		animation_player.play("open_SettingsDialog")
	else:
		animation_player.play_backwards("open_SettingsDialog")
		await animation_player.animation_finished
		settings_dialog.visible = false
		


func _on_h_slider_value_changed(value: float) -> void:
	change_volume_icon(value, sound_icon_1)


func _on_h_slider_2_value_changed(value: float) -> void:
	change_volume_icon(value, sound_icon_2)
			
func change_volume_icon(value, icon):
	match value:
		0.0:
			icon.texture.region = Rect2(SoundIcons.MUTE, 62,47,31)
		1.0:
			icon.texture.region = Rect2(SoundIcons.LOW, 62,47,31)
		2.0:
			icon.texture.region = Rect2(SoundIcons.MEDIUM, 62,47,31)
		3.0:
			icon.texture.region = Rect2(SoundIcons.HIGH, 62,47,31)
