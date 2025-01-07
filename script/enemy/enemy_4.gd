extends Area2D

@export var speed:int
@export var bul_speed = 100
@export var pos_cha = 0

var HP
#var cur:Curve2D
var t:float = 0.0
var timer = 0
var cur = Curve2D.new()

var _shoot_item1 = false
var _shoot_item_def = true

var fire_direction = Vector2.DOWN
var shoot_time_lag = 50
var shoot_time = 0
@export var app_time:int
@export var num_bullet = 45
#var ins = preload("res://enemy_1.tscn")
var exp_int = load("res://script/effect/exp_par.tscn")
var enemy_shot1 = preload("res://script/enemy/bullet/enemy_shot_3.tscn")
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
	#curve()
	pass # Replace with function body.

func curve():
	var line = Line2D.new()
	get_parent().add_child(line)
	cur.bake_interval = 0
	cur.add_point(position,Vector2.ZERO,Vector2(0,10))
	#cur.add_point(position + Vector2(-20,20))
	cur.add_point(position + Vector2(0,1),Vector2(-60,0),Vector2.ZERO)
	line.clear_points()
	for p in cur.get_baked_points():
		line.add_point(p)
		
	#cur.add_point(Vector2(100,250))		

func start(pos):
	position = pos

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
	position.y += speed * delta
	if position.y <= 80:
		pass
	$enemy_ani.play("enemy_fly")
	if position.y > 370:
		queue_free()
	ene_shoot()	
	shoot_time -= 1	
	
	if position.x < 95 or  position.x > 320 or position.y < 30 or position.y > 370:
		queue_free()
		
	if position.y > 80:
		
		#t += speed * delta
		#position -= cur.sample_baked(t)	
		#timer += delta
		#var max_point = cur.get_baked_points().size()
		#var rate = timer / 15.0
		#if rate < 1.0:
			#var idx = (max_point * rate)
			#position += cur.get_baked_points()[idx]
		#position += Vector2.LEFT	
		#var time = speed * delta
		position.x -= speed * delta
		pass
		#position.y = 50 * sin(50 * position.x + time)		
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
			var angle = (i - 2) * angle_step
			var ene_shot_ins = enemy_shot1.instantiate()
			var player = Global_var.other_node("player")
			var vec = (player.position - position).normalized()
			var direction = vec.rotated(deg_to_rad(angle))
			get_parent().add_child(ene_shot_ins)
			ene_shot_ins.start(position)
			ene_shot_ins.set_direction(direction,bul_speed)
			shoot_time = shoot_time_lag - Global_var.level	

func explosion_ene():
	var e = exp_int.instantiate()
	get_parent().add_child(e)
	e.start(position)
	e.ani_num(false,true)
