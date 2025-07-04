extends Node2D

var range_weapon = 0
var melee_weapon = 0

func _ready() -> void:
	melee_weapon = $Fists
	range_weapon = $Fists

func _process(delta: float) -> void:
	if get_node("/root/Main").menu:
		return 
	if (get_parent().attacking):
		return
	if (Input.is_action_just_pressed("melee_atk")):
		melee_weapon.atk()
	if range_weapon != $Rifle:
		if (Input.is_action_just_pressed("range_atk")):
			get_node("/root/Main/Camera").start_shake(2, 10, 10)
			range_weapon.atk()
	else:
		if (Input.is_action_pressed("range_atk")):
			get_node("/root/Main/Camera").start_shake(2, 10, 10)
			range_weapon.atk()

func upgrade_weapon():
	if get_node("/root/Main/Score").player_level == 2:
		melee_weapon = $Pipe
	elif get_node("/root/Main/Score").player_level == 3:
		range_weapon = $Pistol
	elif get_node("/root/Main/Score").player_level == 4:
		melee_weapon = $Bat
	elif get_node("/root/Main/Score").player_level == 5:
		range_weapon = $Rifle
