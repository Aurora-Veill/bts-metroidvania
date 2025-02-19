extends state

func physics(delta : float):
	if owner.detectWall.is_colliding():
		owner.turnAround()
		owner.velocity.y = -100
		stateMachine.changeState("Bonk")
	if not owner.is_on_floor():
		owner.velocity += owner.get_gravity() * delta
	if owner.facingRight:
		owner.velocity.x = min(owner.velocity.x + 10, owner.attackSpeed)
	else:
		owner.velocity.x = max(owner.velocity.x - 10, owner.attackSpeed * -1)
	
	if owner.detectPlayer.is_colliding() and (owner.detectPlayer.get_collider().has_method("Player") or owner.detectPlayer.get_collider().has_method("Mouse")):
		if owner.detectPlayer.get_collider().has_method("Player"):
			stateMachine.idleTimer.stop()
			stateMachine.changeState("RunAway")
		elif owner.detectPlayer.get_collider().has_method("Mouse"):
			stateMachine.idleTimer.stop()
	elif owner.detectPlayerBehind.is_colliding() and (owner.detectPlayerBehind.get_collider().has_method("Player") or owner.detectPlayerBehind.get_collider().has_method("Mouse")):
		if owner.detectPlayerBehind.get_collider().has_method("Player"):
			owner.turnAround()
			stateMachine.idleTimer.stop()
			stateMachine.changeState("RunAway")
		elif owner.detectPlayerBehind.get_collider().has_method("Mouse"):
			owner.turnAround()
			stateMachine.idleTimer.stop()
	else:
		if stateMachine.idleTimer.is_stopped():
			stateMachine.idleTimer.start(1)
	owner.move_and_slide()
