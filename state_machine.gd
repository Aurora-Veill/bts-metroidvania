extends state_machine


# Called when the node enters the scene tree for the first time.
@onready var idleTimer = $IdleTimer

func _on_idle_timer_timeout() -> void:
	changeState("Idle")

func startTimer(time : float):
	idleTimer.start(time)
