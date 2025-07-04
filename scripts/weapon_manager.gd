extends Node2D

var range_weapon = 0
var melee_weapon = 0

func _ready() -> void:
	melee_weapon = $Bat
	range_weapon = $Rifle

func _process(delta: float) -> void:
	if (get_parent().attacking):
		return
	if (Input.is_action_just_pressed("melee_atk")):
		melee_weapon.atk()
	if (Input.is_action_just_pressed("range_atk")):
		range_weapon.atk()
