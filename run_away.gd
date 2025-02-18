extends state

func enterState():
	owner.sprite.texture = preload("res://ratxclamation.png")
	owner.sprite.position.y = -8
	owner.velocity.x *= -0.5
	if owner.is_on_floor():
		owner.velocity.y = -100

func physics(delta : float):
	owner.move_and_slide()
	if not owner.is_on_floor():
		owner.velocity += owner.get_gravity() * delta
	else:
		stateMachine.changeState("Escape")

func exitState():
	owner.sprite.texture = preload("res://rat.png")
	owner.sprite.position.y = 0
	
