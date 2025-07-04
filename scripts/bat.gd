extends Area2D

signal atk_signal
const WEAPON_DISTANCE = 10.0
var screen_size = Vector2(1280, 720)
@export var damage: int = 1
var can_atk = true
@onready var is_ennemy = false
@export var range = 64 * 1

func _ready() -> void:
	$CollisionShape2D.disabled = true
	hide()

func _process(delta: float) -> void:
	if !get_parent().get_parent().attacking:
		var camera_position = position
		var vec
		if !is_ennemy:
			var direction = get_viewport().get_mouse_position()
			vec = direction - Vector2(screen_size.x / 2, screen_size.y / 2)
		else:
			var direction = get_node("/root/Main/Player").position
			vec = direction - get_parent().get_parent().position
		vec = vec.normalized() * WEAPON_DISTANCE
		position = vec
		rotation = vec.angle() + PI / 2
		if is_ennemy:
			collision_layer = 1 >> 4
			collision_mask = 1 << 1
			collision_mask = 1 >> 0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("hittable"):
		body.hit(damage)
		get_node("/root/Main/SoundManager").randSound("BatonHit", 3)

func atk():
	if !can_atk:
		return
	atk_signal.emit()
	get_parent().get_parent().attacking = true
	show()
	$CollisionShape2D.disabled = false
	$AnimatedSprite2D.play()
	can_atk = false
	$AtkTimer.start()
	get_node("/root/Main/SoundManager").randSound("HitFail", 4)

func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.stop()
	hide()
	$CollisionShape2D.disabled = true
	get_parent().get_parent().attacking = false

func _on_atk_timer_timeout() -> void:
	can_atk = true
