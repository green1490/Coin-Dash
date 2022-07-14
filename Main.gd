extends Node2D

export (PackedScene) var Coin
export (PackedScene) var Powerup

export (int) var playtime = 10
var level
var score:int = 0
var time_left:int = 0
var screensize = Vector2()
var playing = false

func spawn_coins():
	$LevelSound.play()
	for _i in range(4 + level):
		# creates a scene instead of in the gui
		var c = Coin.instance()
		# adds the Coins instance as a child
		$CoinContainer.add_child(c)
#		c.screensize = screensize
		c.position = Vector2(rand_range(0, screensize.x),
		rand_range(0, screensize.y))

func new_game():
	playing = true
	level = 1
	score = 0
	time_left = playtime
	$Player.start($PlayerStart.position)
	$Player.show()
	$GameTimer.start()
	spawn_coins()
	
func _on_Player_pickup(type):
	match type:
		"coin":
			score += 1
			$CoinSound.play()
			$HUD.update_score(score)
		"powerup":
			time_left += 5
			$PowerupSound.play()
			$HUD.update_timer(time_left)

func game_over():
	playing = false
	$GameTimer.stop()
	for coin in $CoinContainer.get_children():
		coin.queue_free()
	$HUD.show_game_over()
	$Player.die()
	$EndSound.play()

func _on_Player_hurt():
	game_over()

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	screensize = get_viewport().get_visible_rect().size
	$Player.screensize = screensize
	$Player.hide()
	$HUD.update_score(score)
	$HUD.update_timer(time_left)

func _on_GameTimer_timeout():
	time_left -= 1
	$HUD.update_timer(time_left)
	if time_left <= 0:
		game_over()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$PowerupTimer.wait_time = rand_range(5, 10)
	$PowerupTimer.start()


func _on_PowerupTimer_timeout():
	var p = Powerup.instance()
	add_child(p)
	p.screensize = screensize
	p.position = Vector2(rand_range(0, screensize.x),rand_range(0, screensize.y))
