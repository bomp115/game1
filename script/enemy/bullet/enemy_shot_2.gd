extends Area2D

var vec = Vector2.ZERO
@export var speed = 100
@export var direction:Vector2 = Vector2()

var player = load("res://script/player/player/player.tscn")

var round_shot = false
var angle = 0

func start(pos):
	position = pos
	
	if get_tree().get_first_node_in_group("player"):
		vec = get_tree().get_first_node_in_group("player").position - position
		pass
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
		speed = 150
	else:
		speed = 200
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if round_shot:
		position += direction * speed * delta
		var end_vec = Vector2.ZERO
		direction.move_toward(end_vec,100)
	else:
		position.x += cos(deg_to_rad(angle)) * speed * delta
		position.y += sin(deg_to_rad(angle)) * speed * delta	
	#rotation += speed * delta
	#position += transform.x * speed * delta
	#position += Vector2(1,0).rotated(rotation) * speed * delta

	if position.x < 95 or  position.x > 320 or position.y < 30 or position.y > 370:
		queue_free()
		pass
	pass
	
func hit():
	queue_free()	

func rot_bul(rot):
	rotation += rot

func set_direction(new_direction:Vector2,new_speed:float):
	direction = new_direction
	speed = new_speed

func set_angle(ang):
	angle = ang
