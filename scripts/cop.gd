extends "res://scripts/npc.gd" 

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()
	rng.randomize()
	var r = rng.randi_range(1, 4)
	if (r < 4):
		weapon = $WeaponManager/Bat
	else:
		weapon = $WeaponManager/Pistol
	if weapon:
		weapon.is_ennemy = true
