extends Area2D

signal atk_signal
const WEAPON_DISTANCE = 20.0
var screen_size = Vector2(1280, 720)
@export var damage: int = 1
var can_atk = true
var type = "sword"

func _ready() -> void:
	$CollisionShape2D.disabled = true
	hide()	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("hittable"):
		body.hit(damage)

func _process(delta: float) -> void:
	if !get_parent().get_parent().attacking:
		var camera_position = position
		var mouse_position = get_viewport().get_mouse_position()
		var vec = mouse_position - Vector2(screen_size.x / 2, screen_size.y / 2)
		vec = vec.normalized() * WEAPON_DISTANCE
		position = vec
		rotation = vec.angle()

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

func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.stop()
	hide()
	$CollisionShape2D.disabled = true
	get_parent().get_parent().attacking = false

func _on_atk_timer_timeout() -> void:
	can_atk = true
