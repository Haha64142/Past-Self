extends Node2D

signal next_level
signal level_select

var started = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.action_release("move_left")
	Input.action_release("move_right")
	Input.action_release("jump")
	$WinScreen.hide()
	$Flag/AnimatedSprite2D.play("default")
	$Player.position = $RespawnPosition.position
	$Player.id = 0
	
	if !$Button0.button_changed.is_connected(button0_changed):
		$Button0.button_changed.connect(button0_changed)
	if !$Flag.body_entered.is_connected(_on_flag_body_entered):
		$Flag.body_entered.connect(_on_flag_body_entered)
	if !$WinScreen/HBoxContainer/LevelSelect.pressed.is_connected(_on_level_select_pressed):
		$WinScreen/HBoxContainer/LevelSelect.pressed.connect(_on_level_select_pressed)
	if !$WinScreen/HBoxContainer/NextLevel.pressed.is_connected(_on_next_level_pressed):
		$WinScreen/HBoxContainer/NextLevel.pressed.connect(_on_next_level_pressed)
	
	while (Input.is_action_just_pressed("clone_1") or Input.is_action_just_pressed("clone_2")):
		await get_tree().create_timer(0.1).timeout
	started = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if started == false:
		return
	if Input.is_action_just_pressed("clone_1"):
		if $Player.clones[0] == null:
			var clone_position = $Player.position
			$Player.respawn($RespawnPosition.position)
			await get_tree().create_timer(0.1).timeout
			$Player.create_clone(0, clone_position)
		else:
			$Player.delete_clone(0)
	
	if Input.is_action_just_pressed("clone_2"):
		if $Player.clones[1] == null:
			var clone_position = $Player.position
			$Player.respawn($RespawnPosition.position)
			await get_tree().create_timer(0.1).timeout
			$Player.create_clone(1, clone_position)
		else:
			$Player.delete_clone(1)


func button0_changed(pressed: bool):
	pass


func _on_flag_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$WinScreen.show()
	

func _on_next_level_pressed():
	next_level.emit(1)
	

func _on_level_select_pressed():
	level_select.emit()
