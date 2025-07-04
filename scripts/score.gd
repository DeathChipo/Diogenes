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

func try_level_up():
	if player_score > 10000 && player_level == 1:
		player_level = 2
	elif player_score > 25000 && player_level == 2:
		player_level = 3
	elif player_score > 50000 && player_level == 3:
		player_level = 4
	elif player_score > 1000000 && player_level == 4:
		player_level = 5

func update_bonus():
	if player_bonus > 10000:
		pass
		# Can special
		player_bonus = 0	

func add_assault(name: String):
	match name:
		"tra":
			print("Trash destroy")
			object_destroy += 1
			player_score += 1000
			player_bonus += 1000
		"bag":
			object_destroy += 1
			player_score += 500
			player_bonus += 500
		"Con":
			object_destroy += 1
			player_score += 750
			player_bonus += 750
		"Sew":
			object_destroy += 1
			player_score += 500
			player_bonus += 500
		"Car":
			print("Car destroy")
			car_destroy += 1
			player_score += 9000
			player_bonus += 9000
		"Bys":
			print("Bystander \"killed\"")
			aggression_count += 1
			player_score += 3000
			player_bonus += 3000
		"Cop":
			cop_agression_count += 1
			player_score += 7500
			player_bonus += 7500
		"Mil":
			mili_agression_count += 1
			player_score += 13000
			player_bonus += 13000
	print(player_score)
	update_bonus()
	try_level_up()
