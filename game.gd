extends Node2D

@onready var roomCam = $"World Map/Camera"
@onready var playerCam = $Player/PlayerCam
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("toggleCam"):
		if roomCam.is_current():
			playerCam.make_current()
		else:
			roomCam.make_current()
