extends Area2D

@export var speed = 1
@export var bul_speed = 100
@export var pos_cha = 0

var HP

var _shoot_item1 = false
var _shoot_item_def = true

var angle = 270

var vec = Vector2.ZERO
	
var boss_shot = false	
var isHoming = true

var stage_enemy

var fire_direction = Vector2.DOWN
var shoot_time_lag = 50
var shoot_time = shoot_time_lag
@export var app_time:int
@export var num_bullet = 45
#var ins = preload("res://enemy_1.tscn")
var exp_int = load("res://script/effect/exp_par.tscn")
var enemy_shot = preload("res://script/enemy/bullet/ene_shot_5.tscn")
var item1 = preload("res://script/item/buf_item/buf_item_1.tscn")
var barrier_item = preload("res://script/item/buf_item/barrier_item.tscn").instantiate()
var shoot_item1 = preload("res://script/item/buf_item/shoot_item_1.tscn").instantiate()
var shoot_item2 = preload("res://script/item/buf_item/shoot_item_def.tscn").instantiate()
# Called when the node enters the scene tree for the first time.
func _ready():
	if Global_var.difficulty == 1:
		speed = 1
	elif Global_var.difficulty == 2:
		speed = 2
	else:
		speed = 3
	pass # Replace with function body.

func start(pos):
	position = pos
	if get_tree().get_first_node_in_group("player") and (Global_var.difficulty == 2 or Global_var.difficulty == 1):
		vec = get_tree().get_first_node_in_group("player").position - position	

func start_ran():
	#randomize()
	position.x = 280
	position.y = 35
	
#func appear():
	#var appear_ins := ins.instantiate()
	#get_parent().add_child(appear_ins)
	#appear_ins.start_ran()
	#pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if app_time < 0:
		#appear()
		#app_time = 50
	#else:
		#app_time -= 1
	if boss_shot:
		position.x += cos(deg_to_rad(angle))
		position.y += sin(deg_to_rad(angle))
	else:			
		position.y += speed * delta
		
	
	$enemy_ani.play("enemy_fly")
	if position.y > 370:
		queue_free()
	ene_shoot()	
	shoot_time -= 1	
	
	if position.x < 95 or  position.x > 320 or position.y < 30 or position.y > 370:
		queue_free()
	
	var players = get_tree().get_nodes_in_group("player")
	for player in players:
		if Global_var.difficulty == 3 or stage_enemy:
			vec = player.position - position
			#var dis_x = self.position.x.distance_to(player.position.x)
			position += vec * speed * delta			
				
	if Global_var.difficulty == 2 or Global_var.difficulty == 1:
		position += vec * speed * delta		
	#if position.y > 80:
		##position += Vector2.LEFT		
		#position.x += speed * delta
	pass
	
var item_setting = _item_setting.new()	
	
func hit():
	Global_var.score += 100
	explosion_ene()
	
	item_setting.app_solo(self,get_parent())		
						
	queue_free()	
	
func hited():
	
	queue_free()	
	
func ene_shoot():
	if shoot_time < 0:
		var angle_step = num_bullet / 4
		for i in range(5):
			var angle = i * angle_step - num_bullet / 8
			var direction = fire_direction.rotated(deg_to_rad(angle))
			var ene_shot_ins = enemy_shot.instantiate()
			get_parent().add_child(ene_shot_ins)
			ene_shot_ins.start(position)
			ene_shot_ins.set_direction(direction,bul_speed)
			shoot_time = shoot_time_lag - Global_var.level	

func explosion_ene():
	var e = exp_int.instantiate()
	get_parent().add_child(e)
	e.start(position)
	e.ani_num(false,true)
