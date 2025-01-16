extends CharacterBody2D


const SPEED = 450.0
const JUMP_VELOCITY = -500.0
var controllingPlayer = true
var canSpawnMouse = true
var canSpawnMech = false
var facingRight = true
var inMech = false
var mouse = preload("res://mouse.tscn")
var pushing = 0
var pushObj : pushable
var direction : float
@onready var globals = get_node("/root/Globals")
@onready var mouseTimer = $MouseSpawn

func _physics_process(delta: float) -> void:
	# Add the gravity.
	# Handle jump.
	if controllingPlayer:
		if (Input.is_action_just_pressed("Jump") and is_on_floor()):
			velocity.y = JUMP_VELOCITY
		if Input.is_action_just_pressed("spawnMouse"):
			mouseTimer.start(0.5)
		direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
		if direction > 0:
			if pushing == 1:
				pushObj.pushed(self, direction * SPEED * delta)
			facingRight = true
		if direction < 0:
			if pushing == -1:
				pushObj.pushed(self, direction * SPEED * delta)
			facingRight = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()



#shows that this is the mouse and not another entity
func Player():
	pass


func _on_mouse_spawn_timeout() -> void:
	if Input.is_action_pressed("spawnMouse"):
		spawnMouse()

func spawnMouse():
	if !canSpawnMouse:
		return
	controllingPlayer = false
	globals.controllingPlayer = false
	var Mouse = mouse.instantiate()
	Mouse.position = global_position
	Mouse.position.y += 40
	if facingRight:
		Mouse.position.x += 72
	else: 
		Mouse.position.x -= 72
	Mouse.visible = true
	Mouse.player = self
	get_parent().add_child(Mouse)
