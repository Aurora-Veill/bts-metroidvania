extends CharacterBody2D
class_name Enemy

var hp = 1
var speed = 100
var attackSpeed = 300
func _physics_process(delta: float) -> void:
	move(delta)
	if detect():
		attack(delta)

func move(delta : float):
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.y = 0
	move_and_slide()

func detect() -> bool:
	return false

func attack(delta : float):
	pass

func takeDamage(dmg : int):
	hp -= dmg
	if hp <= 0:
		die()

func die():
	queue_free()
