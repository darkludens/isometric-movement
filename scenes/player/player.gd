extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const ROTATION_SPEED = 1.5

# Referência ao nó pivot onde a câmera está anexada
@onready var pivot = $Pivot

func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle player movement relative to camera direction
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction: Vector3 = (pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction != Vector3.ZERO:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

	# Handle camera rotation
	if Input.is_action_pressed("rotate-left"):
		pivot.rotate_y(-ROTATION_SPEED * delta)
	elif Input.is_action_pressed("rotate-right"):
		pivot.rotate_y(ROTATION_SPEED * delta)
