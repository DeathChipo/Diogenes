extends CharacterBody2D


var speed = 200
var attacking = false
var max_hp = 1000
var hp = max_hp
var alive = true

func _ready():
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()

func controls() -> Vector2:
	var direction = Vector2.ZERO
	if !get_node("/root/Main").freeze:
		if Input.is_action_pressed("move_up"):
			direction.y -= 1
		if Input.is_action_pressed("move_down"):
			direction.y += 1
		if Input.is_action_pressed("move_left"):
			direction.x -= 1
		if Input.is_action_pressed("move_right"):
			direction.x += 1
		if direction.length() > 0:
			direction = direction.normalized() * speed
	return direction

func _physics_process(delta) -> void:
	if hp <= 0:
		get_node("/root/Main").freeze = true
		get_node("/root/Main").pause_animations()
		get_node("/root/Main/Camera/HUD").show_game_over()
	if get_node("/root/Main").menu:
		return 
	var direction = Vector2.ZERO
	#if !attacking:
	direction = controls()
	$AnimatedSprite2D.flip_h = false
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	if direction.length() > 0:
		$AnimatedSprite2D.animation = "walk"
	else:
		$AnimatedSprite2D.animation = "idle"
	velocity = direction * delta * speed
	move_and_slide()

func hit(dmg):
	get_node("/root/Main/SoundManager/sfx/Damage1").play()
	hp -= dmg

func check_witnesses():
	for body in $WitnessArea.get_overlapping_bodies():
		if body.is_in_group("hittable") && body.status == "passive":
			body.witness()
