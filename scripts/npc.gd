extends "res://scripts/hittable.gd" 

@export var speed = 150
@export var target: Node2D
@onready var navigation_agent = $NavigationAgent2D
var attacking = false
@export var weapon = null
var static_atk = false

func _ready() -> void:
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()
	weapon = $WeaponManager/Fists
	if weapon:
		weapon.is_ennemy = true

func _physics_process(delta) -> void:
	if !alive:
		return
	if status == "aggressive":
		navigation_agent.target_position = target.position
	if status == "passive":
		navigation_agent.target_position = position
	if status == "fleeing":
		navigation_agent.target_position = 2 * position - target.position
	var direction = Vector2.ZERO
	direction = to_local(navigation_agent.get_next_path_position())
	direction = direction.normalized()
	$AnimatedSprite2D.flip_h = false
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	velocity = direction * speed
	if static_atk:
		velocity = Vector2.ZERO
	if velocity.length() > 0:
		$AnimatedSprite2D.animation = "walk"
	elif $AnimatedSprite2D.animation != "shocked":
		$AnimatedSprite2D.animation = "idle"
	move_and_slide()
	if !weapon || status != "aggressive":
		return
	var range = (position - target.position).length()
	if range <= weapon.range:
		static_atk = true
		weapon.atk()
	else:
		static_atk = false

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "death":
		queue_free()
	if $AnimatedSprite2D.animation == "shocked":
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.play()
		if randi() % 4 == 0:
			status = "aggressive"
		else:
			status = "fleeing"

func witness() -> void:
	if (alive && $AnimatedSprite2D.animation != "death"):
		$AnimatedSprite2D.animation = "shocked"
