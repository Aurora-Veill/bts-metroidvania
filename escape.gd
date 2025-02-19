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
		
		#if sees player in front, turn around
		if owner.detectPlayer.get_collider().has_method("Player"):
			stateMachine.idleTimer.stop()
			owner.turnAround()
		
		#if sees mouse in front, go into attack mode
		elif owner.detectPlayer.get_collider().has_method("Mouse"):
			stateMachine.changeState("FoundYa")
			stateMachine.idleTimer.stop()
	elif owner.detectPlayerBehind.is_colliding() and (owner.detectPlayerBehind.get_collider().has_method("Player") or owner.detectPlayerBehind.get_collider().has_method("Mouse")):
		if owner.detectPlayerBehind.get_collider().has_method("Player"):
			stateMachine.idleTimer.stop()
		
		#if sees mouse behind and nothing in front, go into attack mode
		elif owner.detectPlayerBehind.get_collider().has_method("Mouse"):
			owner.turnAround()
			stateMachine.changeState("FoundYa")
			stateMachine.idleTimer.stop()
	else:
		if stateMachine.idleTimer.is_stopped():
			stateMachine.idleTimer.start(0.3)
	owner.move_and_slide()
			
#func enterState():
	#owner.apply_scale(Vector2(-1, 1))
	#owner.facingRight = !owner.facingRight
