extends Area2D


@export var speed = 400
var direction = Vector2()
var vec = Vector2.ZERO

var reflect = false
var ang

var damage = 10

var verocity = Vector2.ZERO
var dir = Vector2.UP

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("player_bul2")
	pass # Replace with function body.

func start(pos):
	position = pos
	
	if get_tree().get_first_node_in_group("player"):
		vec = get_tree().get_first_node_in_group("player").position - position
		pass
	else:
		vec = Vector2.UP	
	
	vec = vec.normalized()
	rotation = atan2(vec.x,vec.y)
		
	pass



func initialized(start_pos,pspeed,pdir):
	position = start_pos
	speed = pspeed
	verocity = pdir * speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#var players = get_tree().get_nodes_in_group("player")
	#for player in players:
		#var _dir = Vector2.UP.rotated(player.global_rotation)
		#var spread = 0.2
		#var bul_num = 3
		#for i in range(bul_num):
			#var a = -spread + i * (2 * spread) / (bul_num-1)	
			#position += _dir.rotated(a) * speed * delta
	if !reflect:
		position += verocity * delta
	else:
		position.x += cos(deg_to_rad(ang)) * speed * delta
		position.y	+= sin(deg_to_rad(ang)) * speed * delta	
	
	if position.y < Global_var.field_y:
		queue_free()	
	if position.x < 95 or  position.x > 320 or position.y < 30 or position.y > 370:
		queue_free()		
	
	pass


func _on_area_entered(area):
	if area.is_in_group("enemy"):
		area.hit()
		SoundManager.se_play("beat1")
		queue_free()
	pass # Replace with function body.
	
func set_direction(new_dir:Vector2):
	direction = new_dir	
