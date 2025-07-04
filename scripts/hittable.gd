extends CharacterBody2D


@export var kb_speed: float = 300
@export var kb_acceleration: float = 20
@export var kb_deceleration: float = 2
@export var sprite: PackedScene
@export var hp: int
@export var minimum_damages: int

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var last_hit

var move_direction: Vector2
var kb_timer: Timer
var alive = true
var test = false

@export var status: String = ""

func _ready():
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()
	last_hit = get_node("/root/Main").last_hit

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
	if alive:
		if (dmg >= minimum_damages):
			get_node("/root/Main").freeze = true
			get_node("/root/Main").pause_animations()
		#	move_direction = Vector2(1, 0)
		#	kb_timer = get_node("/root/Main/kb_timer")
		#	kb_timer.wait_time = 0.4
		#	kb_timer.one_shot = true
		#	kb_timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
		#	kb_timer.start()
			#test = true
			#get_node("/root/Main/pause_timer").wait_time = 0.1
			#get_node("/root/Main/pause_timer").one_shot = true
			#get_node("/root/Main/pause_timer").start()
			get_node("/root/Main/Camera").start_shake(2, 3, 2)
			get_node("/root/Main/freeze_timer").wait_time = 0.1
			get_node("/root/Main/freeze_timer").one_shot = true
			get_node("/root/Main/freeze_timer").start()
			hp -= dmg
			get_node("/root/Main/Player").check_witnesses()
		else :
			print("too weak")
		if (hp <= 0):
			if !get_node("/root/Main").first_blood:
				get_node("/root/Main").first_blood = true
				get_node("/root/Main/SoundManager").intro()
			$AnimatedSprite2D.animation = "death"
			$AnimatedSprite2D.play()
			get_node("/root/Main").freeze = true
			get_node("/root/Main/Camera").start_shake(4, 4, 4)
			get_node("/root/Main/Score").add_assault(name.substr(0, 3))
			if !last_hit:
				get_node("/root/Main/freeze_timer").wait_time = 0.2
				get_node("/root/Main/freeze_timer").one_shot = true
				get_node("/root/Main/freeze_timer").start()
			alive = false
		
func _on_Timer_timeout():
	print("KB FIN")
	if move_direction != Vector2.ZERO:
		move_direction = Vector2.ZERO
		kb_timer.wait_time = 1
		kb_timer.start()
	test = false
