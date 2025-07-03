#extends CharacterBody2D

extends "res://scripts/hittable.gd"

var speed = 5000

@export var target: Node2D
@onready var navigation_agent = $NavigationAgent2D

func _physics_process(delta):
	if !alive:
		return
	var direction = to_local(navigation_agent.get_next_path_position())
	direction = direction.normalized()
	velocity = direction * speed * delta
	move_and_slide()

func _ready() -> void:
	navigation_agent.target_position = target.position


func _on_timer_timeout() -> void:
	navigation_agent.target_position = target.position 
