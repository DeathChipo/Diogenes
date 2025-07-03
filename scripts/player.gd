extends CharacterBody2D

var speed = 200
var attacking = false

func controls() -> Vector2:
	var direction = Vector2.ZERO
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
	var direction = Vector2.ZERO
	#if !attacking:
	direction = controls()
	velocity = direction * delta * speed
	move_and_slide()

#func _on_sword_atk_signal() -> void:
	#pass
