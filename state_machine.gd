extends state_machine


# Called when the node enters the scene tree for the first time.


func _on_idle_timer_timeout() -> void:
	changeState("Idle")
