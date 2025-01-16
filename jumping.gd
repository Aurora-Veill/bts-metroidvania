extends state

func enterState():
	owner.velocity.y = owner.JUMP_VELOCITY
func physics(delta : float):
	if not owner.is_on_floor():
		owner.velocity += owner.get_gravity() * delta
	else:
		get_parent().change_state("Idle")
	var direction := Input.get_axis("Left", "Right")
	if direction:
		if direction > 0:
			owner.facingRight = true
		if direction < 0:
			owner.facingRight = false
		owner.velocity.x = direction * owner.SPEED
	else:
		direction = 0
