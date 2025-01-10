extends Node

var levels = [preload("res://level_1.tscn"), preload("res://level_2.tscn"), preload("res://level_3.tscn")]
var level_select_scene = preload("res://level_select.tscn")
var main_menu_scene = preload("res://main_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MainMenu.play.connect(_on_level_select)
	$MainMenu.exit.connect(exit_game)


func exit_game():
	get_tree().quit()


func _on_start_level(level_number) -> void:
	for child in get_children():
		child.queue_free()
	
	var level = levels[level_number - 1].instantiate()
	level.level_select.connect(_on_level_select)
	level.next_level.connect(_on_next_level)
	level.main_menu.connect(_on_main_menu)
	add_child(level)


func _on_main_menu():
	for child in get_children():
		child.queue_free()
	
	var main_menu = main_menu_scene.instantiate()
	main_menu.play.connect(_on_level_select)
	main_menu.exit.connect(exit_game)
	add_child(main_menu)


func _on_level_select():
	for child in get_children():
		child.queue_free()
	
	var level_select = level_select_scene.instantiate()
	level_select.start_level.connect(_on_start_level)
	level_select.main_menu.connect(_on_main_menu)
	add_child(level_select)


func _on_next_level(current_level: int):
	_on_start_level(current_level + 1)
