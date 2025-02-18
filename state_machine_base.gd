extends Node
class_name state_machine

var states = {}
var curState = ""
func _ready() -> void:
	for i in get_children():
		states.get_or_add(i.name, i)
		i.stateMachine = self
	curState = states[get_child(0).name].name

func move(delta : float):
	states[curState].physics(delta)

func changeState(newState):
	states[curState].exitState()
	curState = newState
	states[curState].enterState()
