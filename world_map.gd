extends Node

var rooms = {"intro_00" : "res://intro_00.tscn", "intro_01" : "res://intro_01.tscn", "intro_02" : "res://intro_02.tscn", "intro_s1" : "res://intro_s1.tscn"}
var connections = {"intro_00" : ["intro_01"], "intro_01" : ["intro_00", "intro_02"], "intro_02" : ["intro_01", "intro_s1"], "intro_s1" : ["intro_02"]}
var loadedRooms = {}
var currentRoom = "intro_00"
var playerRoom = "intro_00"
var mouseRoom = "intro_00"
@onready var cam = $Camera
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loadRoom("intro_00")
	loadConnections("intro_00")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func changeRoom(oldRoomName : String, newRoomName : String):
	if currentRoom != oldRoomName:
		return
	for i in connections[oldRoomName]:
		if loadedRooms.has(i):
			if i == newRoomName:
				pass
			elif connections[newRoomName].has(i):
				pass
			elif i == mouseRoom or i == playerRoom:
				pass
			else:
				loadedRooms[i].queue_free()
				loadedRooms.erase(i)
	loadConnections(newRoomName)
	currentRoom = newRoomName
	cam.set_offset(loadedRooms[newRoomName].global_position)

func loadConnections(roomName : String):
	for i in connections[roomName]:
		if !loadedRooms.has(i):
			loadRoom(i)

func loadRoom(roomName : String):
	var newRoom = load(rooms[roomName]).instantiate()
	newRoom.global_position.x = 1152 * newRoom.gridLoc.x
	newRoom.global_position.y = 672 * newRoom.gridLoc.y
	loadedRooms.get_or_add(roomName, newRoom)
	add_child(newRoom)
	


func _on_room_change_trigger_change(roomL: String, roomR: String, isPlayer : bool) -> void:
	if currentRoom == roomL:
		if isPlayer:
			playerRoom = roomR
		else:
			mouseRoom = roomR
		changeRoom(roomL, roomR)
	elif currentRoom == roomR:
		if isPlayer:
			playerRoom = roomL
		else:
			mouseRoom = roomL
		changeRoom(roomR, roomL)

func what_room_is_player_really_in(position : Vector2) -> Vector2:
	var xPos = floor(position.x / 1152)
	var yPos = floor(position.y / 672)
	return Vector2(xPos, yPos)

func _on_room_change_trigger_left(roomL: String, roomR: String, isPlayer : bool, mover : CharacterBody2D) -> void:
	if loadedRooms[currentRoom].gridLoc == what_room_is_player_really_in(mover.position):
		return
	_on_room_change_trigger_change(roomL, roomR, isPlayer)
