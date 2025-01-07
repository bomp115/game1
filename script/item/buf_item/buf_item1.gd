extends Area2D


@export var speed = 50
var vec:Vector2 = Vector2.DOWN
var player = preload("res://script/player/player/player.gd")
var tonakai = preload("res://script/player/player/tonakai.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	scale = Vector2(0.5,0.5)
	pass # Replace with function body.

func start(pos):
	position = pos
	var vec = Vector2.DOWN
	anim()
	vec = vec.normalized()

func anim():
	$item_ani.play("buf_item_roll")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	position += vec * speed * delta
	
	if position.y > 370:
		queue_free()	
	pass


func _on_area_entered(area):
	if area.is_in_group("player"):
		if area.inv_time.is_stopped():
			queue_free()
	pass # Replace with function body.
