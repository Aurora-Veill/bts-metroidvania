extends CharacterBody2D
class_name pushable

@export var weight = 0.5
@export var pushingArea : Area2D
func _process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func pushed(pusher : CharacterBody2D, pVel : float):
	position.x += pVel * (1.0 / (weight + 1.0))
	pusher.position.x += pVel * (1.0 / (weight + 1.0))

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if !body:
		return
	if !body.has_method("Player"):
		return
	print("a")
	body.pushing = 1
	body.pushObj = self

func _on_area_2d_2_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if !body:
		return
	if !body.has_method("Player"):
		return
	print("a")
	body.pushing = -1
	body.pushObj = self

func _on_area_2d_2_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if !body:
		return
	if !body.has_method("Player"):
		return
	body.pushing = 0
	body.pushObj = null
