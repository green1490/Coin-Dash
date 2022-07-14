extends CanvasLayer
signal start_game

func update_score(value):
	$MarginContainer/ScoreLabel.text = str(value)
	
func update_timer(value):
	$MarginContainer/TimeLabel.text = str(value)

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageLabel/MessageTimer.start()
	
	


func _ready():
	pass

func show_game_over():
	show_message("Game Over")
	yield($MessageLabel/MessageTimer, "timeout")
	$StartButton.show()
	$MessageLabel.text = "Coin Dash!"
	$MessageLabel.show()

func _on_MessageTimer_timeout():
	$MessageLabel.hide()

func _on_StartButton_pressed():
	$StartButton.hide()
	$MessageLabel.hide()
	emit_signal("start_game")
