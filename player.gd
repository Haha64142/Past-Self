extends CharacterBody2D

@export var player_scene: PackedScene

var PLAYER_SIZE = Vector2(40, 40)
var WALK_SPEED = 300
var ACCELERATION_SPEED = WALK_SPEED * 7
var JUMP_HEIGHT = 500
var GRAVITY = ProjectSettings.get("physics/2d/default_gravity")
var TERMINAL_VELOCITY = 700
var clones = [null, null]
var id


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("move_left", "move_right") * WALK_SPEED
	velocity.x = move_toward(velocity.x, direction, ACCELERATION_SPEED * delta)
	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -JUMP_HEIGHT
	
	velocity.y = minf(TERMINAL_VELOCITY, velocity.y + GRAVITY * delta)
	
	move_and_slide()
	
	if position.y + (PLAYER_SIZE.y / 2) > ProjectSettings.get("display/window/size/viewport_height"):
		respawn(get_parent().get_node("RespawnPosition").position)
	
	
	if velocity.y > 100:
		$AnimatedSprite2D.play("fall")
	elif velocity.y < 0:
		$AnimatedSprite2D.play("jump")
	elif abs(velocity.x) > 0:
		$AnimatedSprite2D.play("run")
		if velocity.x > 0:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.play("idle")
	

func create_clone(clone_number: int, clone_start_position: Vector2):
	clones[clone_number] = player_scene.instantiate()
	clones[clone_number].position = clone_start_position
	clones[clone_number].modulate = [Color(0x00AB6ECC), Color(0xFF1900CC)][clone_number]
	clones[clone_number].id = clone_number + 1
	clones[clone_number].z_index = 0
	get_parent().add_child(clones[clone_number])
	clones[clone_number].add_to_group("clones")
	

func delete_clone(clone_number):
	clones[clone_number].remove_from_group("clones")
	clones[clone_number].queue_free()
	clones[clone_number] = null
	

func respawn(respawn_posititon: Vector2):
	position = respawn_posititon - Vector2((id - 1) * 40, 0)
	velocity = Vector2.ZERO
