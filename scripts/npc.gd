extends "res://scripts/hittable.gd" 

@export var speed = 150
@export var target: Node2D
@onready var navigation_agent = $NavigationAgent2D

func _ready() -> void:
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()

func _physics_process(delta) -> void:
	if !alive:
		return
	navigation_agent.target_position = target.position
	var direction = Vector2.ZERO
	direction = to_local(navigation_agent.get_next_path_position())
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "death":
		queue_free()
