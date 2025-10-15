extends Control


@onready var v_box_container: VBoxContainer = $WordScreen/MarginContainer/VBoxContainer
@onready var word_container_scene:PackedScene = load("res://scenes/UI/word_container.tscn")

var input_word: String
var split
var word_count:int
var word_container

func _ready() -> void:
	#label.text = globals.word
	var word = "thisisa ofthelimits"
	
	split = word.split(" ", true, 0)

	for thing in split:
		word_container = word_container_scene.instantiate()
		v_box_container.add_child(word_container)
		word_container.populate(thing)
		

#func _ready() -> void:
	#DirAccess.make_dir_recursive_absolute("res://resources/Pressed_Textures/")
	#for child in $MarginContainer/VBoxContainer/Row3.get_children():
		#print(str(child) + child.name)
		#new_resource = child.texture_normal.duplicate(true)
		#new_resource.region.position.x += 36
		#var new_name = str(child.name+"_pressed.tres")
		#var save_path = "res://resources/Pressed_Textures/%s" % [new_name]
		#ResourceSaver.save(new_resource, save_path)
	


	#split = input_word.split(" ", true, 0)
	#print(split[0])
	#print(split[1])
