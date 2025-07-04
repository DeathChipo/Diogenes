extends Node

var player_score: int = 0
var player_bonus: int = 0
var player_level: int = 1
var aggression_count: int = 0
var cop_agression_count: int = 0
var mili_agression_count: int = 0
var object_destroy: int = 0
var car_destroy: int = 0
var piss_count: int = 0
var bank_burn: bool = false

#func try_level_up():
	#if player_score > 20000 && player_level == 1:
		#player_level = 2
		#get_node("/root/Main/SoundManager").swap_music()
	#elif player_score > 45000 && player_level == 2:
		#player_level = 3
		#get_node("/root/Main/SoundManager").swap_music()
	#elif player_score > 100000 && player_level == 3:
		#player_level = 4
		#get_node("/root/Main/SoundManager").swap_music()
	#elif player_score > 3000000 && player_level == 4:
		#player_level = 5
		#get_node("/root/Main/SoundManager").swap_music()

func get_results():
	var str = "Civils assaulted: " + str(aggression_count) + "\nCops assaulted: " + str(cop_agression_count)
	str += "\nMilitaries assaulted: " + str(mili_agression_count) + "\nObjects destroyed: " + str(object_destroy)
	str += "\nCars destroyed: " + str(car_destroy)
	return str

func update_bonus():
	if player_bonus > 10000:
		if player_level < 5:
			player_bonus = 0
			player_level += 1
			get_node("/root/Main/SoundManager").swap_music()
			get_node("/root/Main/Player/WeaponManager").upgrade_weapon()

func add_assault(name: String):
	match name:
		"tra":
			print("Trash destroy")
			object_destroy += 1
			player_score += 1200
			player_bonus += 1200 / (player_level * 1.5)
		"bag":
			object_destroy += 1
			player_score += 900
			player_bonus += 700 / (player_level * 1.5)
		"Con":
			object_destroy += 1
			player_score += 1100
			player_bonus += 900 / (player_level * 1.5)
		"Sew":
			object_destroy += 1
			player_score += 800
			player_bonus += 800 / (player_level * 1.5)
		"Car":
			print("Car destroy")
			car_destroy += 1
			player_score += 9000
			player_bonus += 9000 / (player_level * 1.5)
		"Bys":
			print("Bystander \"killed\"")
			aggression_count += 1
			player_score += 3000
			player_bonus += 3000 / (player_level * 1.5)
		"Cop":
			cop_agression_count += 1
			player_score += 7500
			player_bonus += 7500 / (player_level * 1.5)
		"Mil":
			mili_agression_count += 1
			player_score += 13000
			player_bonus += 13000 / player_level * 1.5
	print(player_score)
	update_bonus()
	#try_level_up()
