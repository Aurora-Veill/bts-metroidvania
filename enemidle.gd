extends state


func physics(delta : float) :
	print("idle")
	if owner.detectWall.is_colliding():
		owner.facingRight = !owner.facingRight
		owner.apply_scale(Vector2(-1, 1))
	if owner.facingRight:
		owner.velocity.x = owner.speed
	else:
		owner.velocity.x = owner.speed * -1
	if not owner.is_on_floor():
		owner.velocity += owner.get_gravity() * delta
	else:
		owner.velocity.y = 0
	owner.move_and_slide()
	if owner.detectPlayer.is_colliding():
		if owner.detectPlayer.get_collider().has_method("Player"):
			stateMachine.changeState("RunAway")
		elif owner.detectPlayer.get_collider().has_method("Mouse"):
			stateMachine.changeState("FoundYa")
			

func enterState():
	pass
