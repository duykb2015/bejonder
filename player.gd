extends Area2D

signal hit

@export var speed := 400.0
@export var teleport_distance := 150.0

var screen_size: Vector2

func _ready() -> void:
	screen_size = get_viewport_rect().size
	#hide()


func _process(delta: float) -> void:
	process_player_input(delta)


func process_player_input(delta: float) -> void:
	var direction := Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		direction.x += 1

	if Input.is_action_pressed("move_left"):
		direction.x -= 1

	if Input.is_action_pressed("move_up"):
		direction.y -= 1

	if Input.is_action_pressed("move_down"):
		direction.y += 1

	if direction.length() > 0:
		direction = direction.normalized()

		$AnimatedSprite2D.play()
		position += direction * speed * delta
	else:
		$AnimatedSprite2D.stop()

	# Teleport
	if Input.is_action_just_pressed("jump") and direction != Vector2.ZERO:
		position += direction * teleport_distance

	position = position.clamp(Vector2.ZERO, screen_size)

	if direction.x < 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		# See the note below about the following boolean assignment.
		$AnimatedSprite2D.flip_h = direction.x < 0
	else:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = direction.y > 0

func _on_body_entered(body: Node2D) -> void:
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
