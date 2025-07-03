extends Node2D

var equiped_weapon = 0
var weapon_obj = 0

func _ready() -> void:
	equiped_weapon = $Pistol

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("attack")):
		equiped_weapon.atk()
