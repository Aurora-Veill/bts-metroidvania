extends state

func enterState():
	owner.sprite.frame = 1
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
	owner.sprite.frame = 0
	
