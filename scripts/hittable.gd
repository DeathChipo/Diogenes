extends CharacterBody2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@export var sprite: PackedScene
@export var hp: int
var alive = true

func _ready():
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()

func _process(delta: float) -> void:
	pass

func hit(dmg: int):
	print("aie")
	hp -= dmg
	if (hp <= 0):
		$AnimatedSprite2D.animation = "death"
		alive = false
