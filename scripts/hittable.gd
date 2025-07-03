extends CharacterBody2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@export var sprite: PackedScene
@export var hp: int
var alive = true

func _ready():
	#var tex_size = $AnimatedSprite2D.texture.get_size() * $AnimatedSprite2D.scale
	#var shape = RectangleShape2D.new()
	#shape.size = tex_size
	#collision_shape.shape = shape
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hit(dmg: int):
	print("aie")
	hp -= dmg
	if (hp <= 0):
		$AnimatedSprite2D.animation = "death"
		alive = false
