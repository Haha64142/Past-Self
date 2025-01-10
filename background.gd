extends Node2D

@export var Level = 1
var speed = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2.ZERO
	var background = load("res://Level Backgrounds/Level" + str(Level) + ".png")
	for child in get_children():
		child.texture = background


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += delta * speed
	if position.y >= 64:
		position.y = 0
