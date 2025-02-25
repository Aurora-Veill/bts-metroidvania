extends state

var frame = 0
var subframe = 0
func physics(delta : float):
	print("bonk")
	print(stateMachine.idleTimer.time_left)
	owner.sprite.frame = frame + 2
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
	subframe = (subframe + 1) % 6
	if subframe == 0:
		frame = (frame + 1) % 5

	
func exitState():
	owner.sprite.frame = 0

func enterState():
	print("starting timer")
	stateMachine.idleTimer.stop()
	stateMachine.startTimer(0.5)
