extends state

func enterState():
	owner.sprite.frame = 1
	owner.velocity.y = -100

func physics(delta : float):
	
	owner.move_and_slide()
	if not owner.is_on_floor():
		owner.velocity += owner.get_gravity() * delta
	else:
		stateMachine.changeState("Attack")

func exitState():
	owner.sprite.frame = 0
	
