extends Enemy

var facingRight = true
@onready var detectWall = $detectWall
@onready var detectPlayer = $detectPlayer
@onready var stateMachine = $StateMachine
@onready var detectPlayerBehind = $detectPlayerBehind
@onready var sprite = $Sprite2D

func move(delta : float):
	stateMachine.move(delta)

func turnAround():
	apply_scale(Vector2(-1, 1))
	facingRight = !facingRight
