extends Node2D

var level

func level1():
	var img = BackBufferCopy.new()
	print(img.)

func _process(delta: float) -> void:
	level = get_node("/root/Main/SoundManager").level
	if level == 1:
		level1()
