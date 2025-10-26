extends Control

signal HangTheMan
signal game_won

@onready var v_box_container: VBoxContainer = $WordScreen/MarginContainer/VBoxContainer
@onready var word_container_scene:PackedScene = load("res://scenes/UI/word_container.tscn")
const NORMAL_MATERIAL = preload("uid://4584b2k0tq63")
const GREY_MATERIAL = preload("uid://1fv5sdq0ywj0")




var input_word: String
var split
var word_count:int
var word_container
var selected_letter:String
var index:int
var pos = 0
var indices = []
var container_count
var letter_count
var count
var confirm_count
var fail_count

func _ready() -> void:
	for button in get_tree().get_nodes_in_group("key"):
		button.pressed.connect(button_recieved.bind(button))
	#label.text = globals.word
	#var word = globals.word
	var word = globals.word
	
	split = word.split(" ", true, 0)
	container_count = len(split)
	for thing in split:
		word_container = word_container_scene.instantiate()
		v_box_container.add_child(word_container)
		word_container.add_to_group("WordContainers")
		word_container.name = str(thing)
		word_container.populate(thing)
		

func button_recieved(button):
	selected_letter = button.name.to_lower()
	fail_count = 0

	for thing in split:
		pos = 0
		indices = []
		while pos != -1:
			pos = thing.find(selected_letter,pos)
			if pos != -1:
				indices.append(pos)
				pos += 1
		if indices.is_empty():
			fail_count += 1
			print("fail")
		else:
			print("Letters found in "+thing+" at positions:",indices)
			for container in get_tree().get_nodes_in_group("WordContainers"):
				if container.name == thing:
					for indice in indices:
						
						container.get_children()[indice].label.visible = true
	if fail_count == container_count:
		button.disabled = true
		button.material = GREY_MATERIAL
		HangTheMan.emit()
	else:
		button.disabled = true
	check_finished()
	#for thing in split:
		#index = thing.find(selected_letter)
		#print(index)
		#if index == -1:
			#print("fail")
		#else:
			#for container in get_tree().get_nodes_in_group("WordContainers"):
				#if container.name == thing:
					#container.get_children()[index].label.visible = true
				#else:
					#pass
	

			



#func _ready() -> void:
	#DirAccess.make_dir_recursive_absolute("res://resources/Pressed_Textures/")
	#for child in $MarginContainer/VBoxContainer/Row3.get_children():
		#print(str(child) + child.name)
		#new_resource = child.texture_normal.duplicate(true)
		#new_resource.region.position.x += 36
		#var new_name = str(child.name+"_pressed.tres")
		#var save_path = "res://resources/Pressed_Textures/%s" % [new_name]
		#ResourceSaver.save(new_resource, save_path)
	

func check_finished():
	confirm_count = 0
	
	for word_line in v_box_container.get_children():
		letter_count = len(word_line.get_children())
		count = 0
		for letter in word_line.get_children():
			if letter.label.visible == true:
				count += 1
			
		if count == letter_count:
			confirm_count += 1
			print("completed")
		else:
			print("fail")
	
	if confirm_count == container_count:
		game_won.emit()
		for button in get_tree().get_nodes_in_group("key"):
			button.disabled = true
	#split = input_word.split(" ", true, 0)
	#print(split[0])
	#print(split[1])

func death():
	for button in get_tree().get_nodes_in_group("key"):
		button.disabled = true
		button.material = GREY_MATERIAL
