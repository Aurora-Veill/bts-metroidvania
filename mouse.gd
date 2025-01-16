extends CharacterBody2D


const SPEED = 650.0
const JUMP_VELOCITY = -450.0
var player : CharacterBody2D
@onready var mouseTimer = $MouseGone

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 2

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if Input.is_action_just_pressed("deactivateMouse"):
		mouseTimer.start(0.5)
	move_and_slide()


func Mouse():
	pass


func _on_mouse_gone_timeout() -> void:
	if Input.is_action_pressed("deactivateMouse"):
		player.controllingPlayer = true
		player.canSpawnMouse = true
		get_node("/root/Game/World Map").changeRoom(get_node("/root/Game/World Map").mouseRoom, get_node("/root/Game/World Map").playerRoom)
		queue_free()
