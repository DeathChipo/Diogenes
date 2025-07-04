extends Node2D

@onready var asp = $AudioStreamPlayer

var	volume = -10
var	sec_loop_vol = true

var time_begin
var time_delay

var	beat_hit = false
var	bar_hit = false

var bar = 0
var bar_counter = 0
var beat = 0
var beat_perc = 0

var	listen = false
var	transi_precut = false
var	transi_cut = false
var	transi_reprise = false
var	transi_bar = 0
var transi_beat = 0

var level = 0

var loop
var loop_reset = false

var intro_listen = false

func _ready():
	time_begin = Time.get_ticks_usec()
	time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	loop = [
	[$Loop1/Loop1Raw, $Loop1/Loop1transi, $Loop2/Loop2Raw],
	[$Loop2/Loop2Raw, $Loop2/Loop2transi, $Loop3/Loop3Raw],
	[$Loop3/Loop3Raw, $Loop3/Loop3transi, $Loop4/Loop4Raw],
	[$Loop4/Loop4Raw, $Loop4/Loop4transi, $Loop5/Loop5Raw],
	[$Loop5/Loop5Raw, $Loop5/Loop5transi, $Loop5/Loop5Raw],
			]

func randSound(str, nb):
	var r = randi() % nb + 1
	get_node("/root/Main/SoundManager/sfx/" + str + str(r)).play()
		

func play_sound(sound):
	if (sound.playing == false):
		AudioServer.set_bus_volume_db(0, volume)	
		sound.play()

func	play_all_music():
	for i in range(0, 5):
		for j in range (0, 3):
			play_sound(loop[i][j])
			loop[i][j].volume_db = -80.0

func	stop_all_music():
	for i in range(0, 4):
		for j in range (0, 2):
			loop[i][j].stop()

func	music_setup():
	if (intro_listen == true && bar_counter == 9):
		time_begin = Time.get_ticks_usec()
		time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
		play_all_music()
		loop[0][0].volume_db = 10.0
		sec_loop_vol = false
		intro_listen = false
		bar = 1
		bar_counter = 1
		beat = 1
	
func	swap_music():
	if sec_loop_vol == false && intro_listen == false:
		transi_precut = true;
		transi_bar = bar
		transi_beat = beat + 1
		if (transi_beat >= 5):
			transi_beat = 1
		sec_loop_vol = true
		if beat >= 3:
			transi_bar += 1
		if (transi_bar >= 5):
			transi_bar = 1;
		print(transi_bar)
			
func intro():
	listen = true
	time_begin = Time.get_ticks_usec()
	time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	play_sound($Intro)
	intro_listen = true

func transition():
	if transi_precut == true && beat == 4 && beat == transi_beat:
		print("la3")
		transi_precut = false
		transi_cut = true
		$PreCut/transi3.play()
	elif transi_precut == true && beat == 1 && beat == transi_beat:
		print("la2")
		transi_precut = false
		transi_cut = true
		$PreCut/transi2.play()
	elif transi_precut == true && beat == 2 && beat == transi_beat:
		print("la1p")
		transi_precut = false
		transi_cut = true
		$PreCut/transi1.play()
	elif transi_precut == true && beat == 3 && beat == transi_beat:
		transi_precut = false
		transi_cut = true
		
	if transi_cut == true && bar == transi_bar && beat == 3:
		loop[level][0].volume_db = -80.0
		loop[level][1].volume_db = 10.0
		transi_cut = false
		transi_reprise = true
	var tmp = transi_bar + 1
	if (tmp == 5):
		tmp = 1
	if transi_reprise == true && bar == tmp:
		loop[level][1].volume_db = -80.0
		loop[level][2].volume_db = 10.0
		level += 1
		if level == 5:
			level = 4
		transi_reprise = false
		sec_loop_vol = false

		
func loop_transi():
	if (bar_counter % 16 == 1 && loop_reset == true):
		stop_all_music()
		play_all_music()
		loop[level][0].volume_db = 10.0
		loop_reset = false
		print("testtttttttt")
	elif loop_reset	== false && bar_counter % 16 == 10:
		loop_reset = true

func	update_bar(time):
	if fmod(time, 60/float(115)*4) < 0.5 && bar_hit == false:
		bar += 1
		bar_counter += 1
		if (bar == 5):
			bar = 1
		print("\n")
		print(bar)
		bar_hit = true
	elif fmod(time, 60/float(115)*4) > 1 && bar_hit == true:
		bar_hit = false

func	update_beat(time):
	if fmod(time, 60/float(115)) < 0.2 && beat_hit == false:
		beat += 1
		if (beat == 5):
			beat = 1
		print(beat)
		beat_hit = true
	elif fmod(time, 60/float(115)) > 0.4 && beat_hit == true:
		beat_hit = false

func _process(delta: float) -> void:
	var time = (Time.get_ticks_usec() - time_begin) / 1000000.0
	time -= time_delay
	time = max(0, time)
	music_setup()
	if (listen || intro_listen):
		update_bar(time)
		update_beat(time)
	if (listen == true):
		transition()
		loop_transi()
	if Input.is_action_just_pressed("start_music") && listen == false:
		intro()
	if Input.is_action_just_pressed("change_music") && transi_cut == false:
		swap_music()
