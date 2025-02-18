extends state

func physics(delta : float):
	var direction := Input.get_axis("Left", "Right")
	if direction:
		if direction > 0:
			owner.facingRight = true
		if direction < 0:
			owner.facingRight = false
		owner.velocity.x = direction * owner.SPEED * delta
	else:
		get_parent().change_state("Idle")
	if Input.is_action_just_pressed("Jump") and owner.is_on_floor():
		get_parent().change_state("Jumping")

func exitState():
	owner.velocity.x = move_toward(owner.velocity.x, 0, owner.SPEED)
