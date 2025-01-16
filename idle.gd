extends state

func physics(delta : float):
	
	if Input.get_axis("Left", "Right"):
		get_parent().change_state("Walking")
	if (Input.is_action_just_pressed("Jump") and owner.is_on_floor()):
		get_parent().change_state("Jumping")
	if not owner.is_on_floor():
		owner.velocity += owner.get_gravity() * delta
	owner.velocity.x = 0
