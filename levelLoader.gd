extends Node

var loadedMaps = Array()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_room_change_trigger(roomLeft, roomEntered):
	pass
	#loadedMaps.pop_front().queue_free()
	#var newRoom = roomEntered.instantiate()
	#loadedMaps.append(newRoom)
