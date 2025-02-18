extends state

func physics(delta : float):
	if owner.detectWall.is_colliding():
		owner.facingRight = !owner.facingRight
		owner.apply_scale(Vector2(-1, 1))
		owner.velocity.y = -100
		stateMachine.changeState("Idle")
	if not owner.is_on_floor():
		owner.velocity += owner.get_gravity() * delta
	if !owner.facingRight:
		owner.velocity.x = min(owner.velocity.x + 10, owner.attackSpeed)
	else:
		owner.velocity.x = max(owner.velocity.x - 10, owner.attackSpeed * -1)
	if owner.detectPlayer.is_colliding() and (owner.detectPlayer.get_collider().has_method("Player") or owner.detectPlayer.get_collider().has_method("Mouse")):
		if owner.detectPlayer.get_collider().has_method("Player"):
			owner.idleTimer.stop()
		elif owner.detectPlayer.get_collider().has_method("Mouse"):
			stateMachine.changeState("FoundYa")
			owner.idleTimer.stop()
	elif owner.detectPlayerBehind.is_colliding() and (owner.detectPlayerBehind.get_collider().has_method("Player") or owner.detectPlayerBehind.get_collider().has_method("Mouse")):
		if owner.detectPlayerBehind.get_collider().has_method("Player"):
			owner.facingRight = !owner.facingRight
			owner.apply_scale(Vector2(-1, 1))
			owner.idleTimer.stop()
		elif owner.detectPlayerBehind.get_collider().has_method("Mouse"):
			owner.facingRight = !owner.facingRight
			owner.apply_scale(Vector2(-1, 1))
			stateMachine.changeState("FoundYa")
			owner.idleTimer.stop()
	else:
		if owner.idleTimer.is_stopped():
			owner.idleTimer.start(0.3)
	owner.move_and_slide()
			

func enterState():
	owner.sprite.flip_h = true

func exitState():
	owner.sprite.flip_h = false
