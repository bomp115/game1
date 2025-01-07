extends Area2D

@export var speed = 50
@export var bul_speed = 100
@export var pos_cha = 0
#@export var curve:Curve

var HP

#@onready var path = $enemy_6_path/enemy6_follow
#@onready var ani = $enemy_6_path/enemy6_follow/Area2D/AnimatedSprite2D

var _shoot_item1 = false
var _shoot_item_def = true
	

var fire_direction = Vector2.DOWN
var shoot_time_lag = 50
var shoot_time = 0
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
		speed = 50
	elif Global_var.difficulty == 2:
		speed = 100
	else:
		speed = 150
	
	if Global_var.difficulty == 1:
		bul_speed = 100
	elif Global_var.difficulty == 2:
		bul_speed = 150
	else:
		bul_speed = 200	
	pass # Replace with function body.

func start(pos):
	position = pos

func start_ran():
	#randomize()
	position.x = 110
	position.y = 45
	
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
	#position.y += speed * delta
	#path.progress += speed * delta
	#ani.play("def")
	if position.y > 370:
		queue_free()
	#ene_shoot()	
	#shoot_time -= 1	
	
	if position.x < 95 or  position.x > 320 or position.y < 30 or position.y > 370:
		queue_free()
		
	if position.y > 80:
		#position += Vector2.LEFT
		pass		
		#position.x += speed * delta
	pass
	
func hit():
	Global_var.score += 100
	explosion_ene()
	
	randomize()
	var app_item:int = randf_range(1,50)
	if app_item == 1:
		var i = item1.instantiate()
		get_parent().add_child(i)
		i.start(position)
	elif app_item == 2:
		get_parent().add_child(barrier_item)
		barrier_item.start(position)
	elif app_item == 3 and Global_var.bul_type1 == false:
		shoot_item1 = preload("res://script/item/buf_item/shoot_item_1.tscn").instantiate()
		get_parent().add_child(shoot_item1)
		shoot_item1.start(position)
	
	elif app_item == 4 and Global_var.bul_type_def == false:
		shoot_item2 = preload("res://script/item/buf_item/shoot_item_def.tscn").instantiate()
		get_parent().add_child(shoot_item2)
		shoot_item2.start(position)	
	elif app_item == 5:
		var curry = preload("res://script/item/score_item/curry.tscn").instantiate()
		get_parent().add_child(curry)
		curry.position = position
	elif app_item == 6:
		var ice = preload("res://script/item/score_item/ice.tscn").instantiate()
		get_parent().add_child(ice)
		ice.position = position
	elif app_item == 7:
		var water = preload("res://script/item/score_item/water.tscn").instantiate()
		get_parent().add_child(water)
		water.position = position
	elif app_item == 8:
		var takoyaki = preload("res://script/item/score_item/takoyaki.tscn").instantiate()
		get_parent().add_child(takoyaki)
		takoyaki.position = position
	elif app_item == 9:
		var cake = preload("res://script/item/score_item/cake.tscn").instantiate()
		get_parent().add_child(cake)
		cake.position = position		
						
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
