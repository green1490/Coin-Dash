extends Area2D
signal pickup
signal hurt

export (int) var speed

var velocity = Vector2()
var screensize = Vector2(480,720)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func die():
	$AnimatedSprite.animation = "hurt"
	# stop the _proccess function therfore if the player is that it can't be moved
	set_process(false)

func start(pos):
	set_process(true)
	position = pos
	$AnimatedSprite.animation = "idle"

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if velocity.length() > 0:
		#child node(AnimatedSprite)
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.flip_h  = velocity.x < 0
		velocity = velocity.normalized() * speed
	else:
		$AnimatedSprite.animation = "idle"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()
	position += velocity * delta
	#clap limits the position to min-max
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)


func _on_Player_area_entered(area):
	if area.is_in_group("coins"):
		area.pickup()
		emit_signal("pickup")
	if area.is_in_group("obstacles"):
		emit_signal("hurt")
		die()
