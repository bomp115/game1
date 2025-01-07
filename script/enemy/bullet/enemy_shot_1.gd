extends Area2D

var vec = Vector2.ZERO
@export var speed:int = 100
var isHoming = false

var angle

var player = load("res://script/player/player/player.tscn")


func start(pos):
	position = pos
	
	if get_tree().get_first_node_in_group("player"):
		vec = get_tree().get_first_node_in_group("player").position - position
	else:
		vec = Vector2.DOWN	
	
	vec = vec.normalized()
	rotation = atan2(vec.x,vec.y)
		
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global_var.difficulty == 1:
		speed = 100
	elif Global_var.difficulty == 2:
		speed = 200
	else:
		speed = 300
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if isHoming:position += vec * speed * delta
	else:
		position.x += cos(deg_to_rad(angle)) * speed * delta
		position.y += sin(deg_to_rad(angle)) * speed * delta
	
	
	if position.x < 95 or  position.x > 320 or position.y < 30 or position.y > 370:
		queue_free()
		pass
	pass
	
func hit():
	queue_free()	