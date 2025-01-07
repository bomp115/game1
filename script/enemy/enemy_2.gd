extends Area2D

@export var speed:int
@export var bul_speed = 100
var shoot_time_lag = 50
var shoot_time = 0
@export var app_time:int = 10
@export var num_bullet = 8

var HP

var _shoot_item1 = false
var _shoot_item_def = true

#var ins = preload("res://enemy_1.tscn")
var exp_int = load("res://script/effect/exp_par.tscn")
var enemy_shot1 = preload("res://script/enemy/bullet/enemy_shot_2.tscn")
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
	randomize()
	position.x = randf_range(100,320)	
	position.y = 35
	
var item_setting = _item_setting.new()	
	
func app_item():
	var shoot_item1 = true
	var shoot_item2 = false	
	item_setting.app_solo(self,get_parent())	
			
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
	
	position.y += speed * delta
	$enemy_ani.play("enemy_fly")
	if position.y > 370:
		queue_free()
	ene_shoot()	
	shoot_time -= 1	
	
	if position.x < 95 or  position.x > 320 or position.y < 30 or position.y > 370:
		queue_free()	
	pass
	
func hit():
	Global_var.score += 100
	explosion_ene()
	app_item()
	queue_free()	
	
func hited():
	
	queue_free()	
	
func ene_shoot():
	if shoot_time < 0:
		var angle_step = 2 * PI / num_bullet
		for i in range(num_bullet):
			var angle = i * angle_step
			var direction = Vector2(cos(angle),sin(angle)).normalized()
			var ene_shot_ins = enemy_shot1.instantiate()
			ene_shot_ins.round_shot = true
			get_parent().add_child(ene_shot_ins)
			ene_shot_ins.start(position)
			ene_shot_ins.set_direction(direction,bul_speed)
			shoot_time = shoot_time_lag - Global_var.level	

func explosion_ene():
	var e = exp_int.instantiate()
	get_parent().add_child(e)
	e.start(position)
	e.ani_num(false,true)
