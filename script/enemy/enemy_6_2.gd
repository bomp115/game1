extends Path2D

@export var speed = 50
@export var bul_speed = 100
@export var pos_cha = 0
var HP
#@export var curve:Curve

@onready var path = $enemy6_follow
@onready var ani = $enemy6_follow/enemy_6/AnimatedSprite2D
@onready var area = $enemy6_follow/enemy_6

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
	path.progress += speed * delta
	#position.y += speed * delta
	ani.play("def")
	if position.y > 370:
		queue_free()
	#ene_shoot()	
	#shoot_time -= 1	
	
	if path.position.x < 0 or  path.position.x > 210 or path.position.y < 0 or path.position.y > 340:
		queue_free()
		
	if position.y > 80:
		#position += Vector2.LEFT
		pass		
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
	e.start(path.position + Vector2(110,40))
	e.ani_num(false,true)


func _on_enemy_6_area_entered(area):
	if area.is_in_group("shot"):
		SoundManager.se_play("beat1")
		hit()
		area.queue_free()
		queue_free()
	elif area.is_in_group("player"):
		if Global_var.barrier_num != 1 and area.is_visible:
			hited()
		area.enebody_damage()
		#area.queue_free()
		#queue_free()	
	pass # Replace with function body.
