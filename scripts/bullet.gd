extends Area2D

var angle = 0
var speed = 0
var damage = 0
var speed_fix = 0
var is_ennemy = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("hittable"):
		get_node("/root/Main/SoundManager").randSound("Hit", 2)
		
		if (body.alive):
			queue_free()
		body.hit(damage)
	if body.is_in_group("walls"):
		var r = randi() % 5
		get_node("/root/Main/SoundManager").randSound("ShootFail", 5)
				
		queue_free()

func _process(delta: float) -> void:
	if speed == 0:
		return
	position += Vector2.RIGHT.rotated(angle) * speed * delta
	rotation = angle
	$Sprite2D.flip_h = true
	while speed > speed_fix * 0.5:
		speed -= speed_fix / 1000

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	get_node("/root/Main/SoundManager").randSound("ShootFail", 5)
	queue_free()

func get_stats(ang, spe, dam, pos, en) -> void:
	position = pos
	angle = ang
	speed = spe
	speed_fix = spe
	damage = dam
	is_ennemy = en
	if is_ennemy:
		collision_layer = 1 >> 4
		collision_mask = 1 << 1
		collision_mask = 1 >> 0
