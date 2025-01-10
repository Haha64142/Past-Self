extends Control

signal start_level
signal main_menu


func _on_level_1_pressed() -> void:
	start_level.emit(1)


func _on_level_2_pressed() -> void:
	start_level.emit(2)


func _on_level_3_pressed() -> void:
	start_level.emit(3)


func _on_main_menu_pressed() -> void:
	main_menu.emit()
