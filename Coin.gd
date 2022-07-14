extends Area2D

func pickup():
	# monitoring Aread2d vairable.Turning off will not detect objects
	monitoring = false
	$Tween.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = rand_range(3,8)
	$Timer.start()
	$Tween.interpolate_property($AnimatedSprite, 'scale',
	$AnimatedSprite.scale,
	$AnimatedSprite.scale * 3, 0.3,
	Tween.TRANS_QUAD,
	Tween.EASE_IN_OUT)
	$Tween.interpolate_property($AnimatedSprite, 'modulate',
	Color(1, 1, 1, 1),
	Color(1, 1, 1, 0), 0.3,
	Tween.TRANS_QUAD,
	Tween.EASE_IN_OUT)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Tween_tween_completed(_object, _key):
	queue_free()


func _on_Timer_timeout():
	$AnimatedSprite.frame = 0
	$AnimatedSprite.play()
