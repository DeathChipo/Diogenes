extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HealthBar.hide()
	$RageBar.hide()
	$star1.hide()
	$star2.hide()
	$star3.hide()
	$star4.hide()
	$star5.hide()
	$GameOver.hide()
	$score.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$HealthBar.value = get_node("/root/Main/Player").hp * 100 / get_node("/root/Main/Player").max_hp
	$RageBar.value = get_node("/root/Main/Score").player_bonus / 100
	var level = get_node("/root/Main/Score").player_level
	if (level >= 1):
		$star1.show()
	if (level >= 2):
		$star2.show()
	if (level >= 3):
		$star3.show()
	if (level >= 4):
		$star4.show()
	if (level >= 5):
		$star5.show()

func show_game_over():
	$HealthBar.hide()
	$GameOver.show()
	$score.text = "Score: " + str(get_node("/root/Main/Score").player_score, " ")
	$score.text += get_node("/root/Main/Score").get_results()
	$score.show()


func _on_button_pressed() -> void:
	$Button.hide()
	$HealthBar.show()
	$RageBar.show()
	get_node("/root/Main").start_game()
