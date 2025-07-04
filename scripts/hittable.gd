extends CharacterBody2D


@export var kb_speed: float = 300
@export var kb_acceleration: float = 20
@export var kb_deceleration: float = 2
@export var sprite: PackedScene
@export var hp: int
@export var minimum_damages: int

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var ftimer
@onready var last_hit

var move_direction: Vector2
var kb_timer: Timer
var alive = true
var test = false


func _ready():
	#var tex_size = $AnimatedSprite2D.texture.get_size() * $AnimatedSprite2D.scale
	#var shape = RectangleShape2D.new()
	#shape.size = tex_size
	#collision_shape.shape = shape
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()
	ftimer = get_node("/root/Main/freeze_timer")
	last_hit = get_node("/root/Main").last_hit

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if test:
		print("I TAKE KB")
		move_direction = move_direction.normalized()
		velocity = velocity.lerp(move_direction * kb_speed, kb_acceleration * delta)
		if move_direction == Vector2.ZERO:
			velocity = velocity.lerp(Vector2.ZERO, kb_deceleration * delta)
		print(velocity)
		move_and_slide()
	

func hit(dmg: int):
	print("aie")
	if (dmg >= minimum_damages):
		get_parent().freeze = true
		move_direction = Vector2(1, 0)
		kb_timer = get_node("/root/Main/kb_timer")
		kb_timer.wait_time = 0.4
		kb_timer.one_shot = true
		kb_timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
		kb_timer.start()
		#test = true
		get_node("/root/Main").pause_animations()
		get_node("/root/Main/Camera").start_shake(0.5, 0.5, 1)
		ftimer.wait_time = 0.1
		ftimer.one_shot = true
		ftimer.start()
		hp -= dmg
	else :
		print("too weak")
	if (hp <= 0):
		$AnimatedSprite2D.animation = "death"
		get_parent().freeze = true
		get_node("/root/Main").pause_animations()
		get_node("/root/Main/Camera").start_shake(1.5, 1.5, 3)
		if !last_hit:
			ftimer.wait_time = 0.2
			ftimer.one_shot = true
			ftimer.start()
		alive = false
		
func _on_Timer_timeout():
	print("KB FIN")
	if move_direction != Vector2.ZERO:
		move_direction = Vector2.ZERO
		kb_timer.wait_time = 1
		kb_timer.start()
	test = false
