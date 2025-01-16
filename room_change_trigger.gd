extends Area2D
@export var roomL = "intro_00"
@export var roomR = "intro_01"

signal left(roomL : String, roomR : String, isPlayer : bool)
signal change(roomL : String, roomR : String, isPlayer : bool)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if !body.has_method("Player") and !body.has_method("Mouse"):
		return
	change.emit(roomL, roomR, body.has_method("Player"))

func _on_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body == null:
		return
	if !body.has_method("Player") and !body.has_method("Mouse"):
		return
	left.emit(roomL, roomR, body.has_method("Player"), body)
	
