extends Node2D

export (PackedScene) var Coin
export (int) var playtime
var level
var score = 0
var time_left = 60
var screensize = Vector2()
var playing = false

func spawn_coins():
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
	
func _on_Player_pickup():
	score += 1
	$HUD.update_score(score)

func game_over():
	playing = false
	$GameTimer.stop()
	for coin in $CoinContainer.get_children():
		coin.queue_free()
	$HUD.show_game_over()
	$Player.die()

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
#func _process(delta):
#	pass
