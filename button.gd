extends Area2D

signal button_changed

@export var id: int

var pressed = false


func _press(_body: Node2D):
	$AnimatedSprite2D.animation = "pressed"
	pressed = true
	button_changed.emit(true)

func _unpress(_body: Node2D):
	$AnimatedSprite2D.animation = "released"
	pressed = false
	button_changed.emit(false)
	 
