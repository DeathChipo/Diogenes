#extends CharacterBody2D

extends "res://scripts/hittable.gd"

var astar_grid = AStarGrid2D.new()
var start = Vector2i.ZERO
var end = Vector2i(2, 5)
@export var speed = 100.0
var current_point_index := 0
var target_points: Array = []

func _ready():
	initialize_grid()
	update_path()

func initialize_grid():
	astar_grid.cell_size = Vector2i(64, 64)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES
	astar_grid.default_estimate_heuristic = AStarGrid2D.HEURISTIC_OCTILE
	astar_grid.region = Rect2i(0, 0, 100, 100)
	astar_grid.region.position = Vector2i(-50, -50)
	astar_grid.update()

func update_path():
	$Path.points = PackedVector2Array(astar_grid.get_point_path(start, end))
	target_points = $Path.points.duplicate()
	if target_points.size() > 0:
		current_point_index = 0

func _physics_process(delta: float) -> void:
	if !alive:
		return
	if current_point_index >= target_points.size():
		velocity = Vector2.ZERO
		return
	var local_target = target_points[current_point_index]
	var global_target = $Path.to_global(local_target)
	var direction = (global_target - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	if global_position.distance_to(global_target) < 5.0:
		current_point_index += 1
