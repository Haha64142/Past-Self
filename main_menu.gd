extends Control

signal play
signal exit


func _on_play_pressed() -> void:
	play.emit()


func _on_exit_pressed() -> void:
	exit.emit()
