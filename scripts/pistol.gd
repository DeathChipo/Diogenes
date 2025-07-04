extends AnimatedSprite2D

signal atk_signal
const WEAPON_DISTANCE = 10.0
var screen_size = Vector2(1280, 720)
@export var damage: int = 1
@export var bullet_scene: PackedScene
var can_atk = true
@export var bullet_speed = 4000

func _ready() -> void:
	hide()
	flip_h = true

func _process(delta: float) -> void:
	if !get_parent().get_parent().attacking:
		var camera_position = position
		var mouse_position = get_viewport().get_mouse_position()
		var vec = mouse_position - Vector2(screen_size.x / 2, screen_size.y / 2)
		vec = vec.normalized() * WEAPON_DISTANCE
		position = vec
		rotation = vec.angle()
		if vec.angle() <= -2  || vec.angle() >= 2:
			flip_v = true
			$GunShot.flip_v = true
		else:
			flip_v = false
			$GunShot.flip_v = false

func atk():
	if !can_atk:
		return
	atk_signal.emit()
	get_parent().get_parent().attacking = true
	show()
	play()
	can_atk = false
	$AtkTimer.start()
	$GunShot.play()
	var bullet = bullet_scene.instantiate()
	bullet.get_stats(rotation, bullet_speed, damage, get_parent().get_parent().position + position)
	get_node("/root/Main/Player/WeaponManager/Bullets").add_child(bullet)
	if randi() % 2:
		get_node("/root/Main/SoundManager/sfx/GunShoot1").play()
	else:
		get_node("/root/Main/SoundManager/sfx/GunShoot2").play()

func _on_animation_finished() -> void:
	stop()
	hide()
	get_parent().get_parent().attacking = false

func _on_atk_timer_timeout() -> void:
	can_atk = true
