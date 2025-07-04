extends Node

@export var type_police: PackedScene
@export var type_military: PackedScene

var mob_cap: int = 0
var spawn = [[4740,1255],[4750,1250],[4740,1240],[4730,1200],[4754,1100]]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_node("/root/Main").game_speed >= 2 && mob_cap <= 2:
		spawn_mob()
	elif get_node("/root/Main").game_speed >= 5 && mob_cap <= 5:
		spawn_mob()
	elif get_node("/root/Main").game_speed >= 10 && mob_cap <= 15:
		spawn_mob()
	elif get_node("/root/Main").game_speed >= 15 && mob_cap <= 40:
		spawn_mob()
	elif get_node("/root/Main").game_speed >= 20 && mob_cap <= 80:
		spawn_mob()

func spawn_mob():
	var area
	var i = randi() % 3
	if (i == 0):
		area = $SpawnZone1
	elif (i == 1):
		area = $SpawnZone2
	else:
		area = $SpawnZone3
	var level = get_node("/root/Main/Score").player_level
	var pos: Vector2
	var randib = randi() % 3;
	pos.x = spawn[randib][0]
	pos.y = spawn[randib][1]
	print(pos)
	var police_nb = randi() % (60 - (level * 10))
	var military_nb = randi() % (0 + (level * 10))
	var to_spawn
	if police_nb > military_nb:
		to_spawn = type_police.instantiate()
	else:
		to_spawn = type_military.instantiate()
	to_spawn.status = "aggressive"
	to_spawn.position = pos
	to_spawn.target = get_node("/root/Main/Player")
	#to_spawn.position = get_node("/root/Main/Player").position
	mob_cap += 1
	add_child(to_spawn)

func get_random_position_in_area(area: Area2D) -> Vector2:
	var shape: CollisionShape2D = area.get_child(0)
	if shape and shape.shape is RectangleShape2D:
		var rect: Vector2 = (shape.shape as RectangleShape2D).extents
		var local_pos = Vector2(
			randf_range(-rect.x, rect.x),
			randf_range(-rect.y, rect.y)
		)
		return area.global_position + local_pos.rotated(area.global_rotation)
	return area.global_position
