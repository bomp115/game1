extends Path2D

@export var speed = 50
@export var bul_speed = 100
@export var pos_cha = 0
var HP = 50
var dead = false
#@export var curve:Curve
var target_position :Vector2 = Vector2(150,300)
var current_position:Vector2
var current_direction = Vector2(1,0)

@onready var path = $PathFollow2D
@onready var ani = $PathFollow2D/Area2D/AnimatedSprite2D
#@onready var area = $enemy6_follow/enemy_6

var _shoot_item1 = false
var _shoot_item_def = true

var damaging = false
	
var head = false
var body1 = false	
var body2 = false
var body3 = false
var body4 = false
var body5 = false
var body6 = false
var body7 = false

#var time = {
	#"head":60,
	#"body1":0,
	#"body2":0,
	#"body3":0,
	#"body4":0,
	#"body5":0,
	#"body6":0,
	#"body7":0,
#}

var time = 100

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
	ani.position = self.curve.get_point_position(0)
	#current_position = position
	pass # Replace with function body.

func start(pos_x,pos_y):
	position.x = pos_x
	position.y = pos_y

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
	#position.y += speed * delta
	
	#var dir_to_target = (target_position - current_position).normalized()
	#var smooth_dir = current_direction.lerp(dir_to_target,1)
	#current_position += smooth_dir * speed * delta
	#position = current_position
	#current_direction = smooth_dir 
	
	path.progress += speed * delta
	
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
	
	if head:
		ani.play("head")
		pass
	elif body1:
		ani.play("body1")
	elif body2:
		ani.play("body2")
	elif body3:
		ani.play("body3")
	elif body4:
		ani.play("body4")
	elif body5:
		ani.play("body5")
	elif body6:
		ani.play("body6")
	elif body7:
		ani.play("body7")							
	
	if damaging:
		var tween = get_tree().create_tween()
		tween.tween_property(ani,"modulate",Color(1,0,0,1),0.1).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(ani,"modulate",Color(1,1,1,1),0.1).set_trans(Tween.TRANS_CUBIC)
		damaging = false
	
func hit():
	Global_var.score += 1000
	explosion_ene()
	
	randomize()
	var app_item:int = randf_range(1,50)
	if app_item == 1:
		var i = item1.instantiate()
		get_parent().add_child(i)
		i.start(path.position + Vector2(110,40))
	elif app_item == 2:
		get_parent().add_child(barrier_item)
		barrier_item.start(path.position + Vector2(110,40))
	elif app_item == 3 and Global_var.bul_type1 == false:
		shoot_item1 = preload("res://script/item/buf_item/shoot_item_1.tscn").instantiate()
		get_parent().add_child(shoot_item1)
		shoot_item1.start(path.position + Vector2(110,40))
	
	elif app_item == 4 and Global_var.bul_type_def == false:
		shoot_item2 = preload("res://script/item/buf_item/shoot_item_def.tscn").instantiate()
		get_parent().add_child(shoot_item2)
		shoot_item2.start(path.position + Vector2(110,40))		
						
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


func _on_area_entered(area):
	if area.is_in_group("shot"):
		if head:
			HP -= area.damage
			#var mukades = get_tree().get_nodes_in_group("mukade_whole")
			#var mukades = get_tree().get_nodes_in_group("mukade" + str(mukade_num))
			var stage1s = get_tree().get_nodes_in_group("main")
			for stage1 in stage1s:
				var mukade_num = stage1.mukade_num
				print(mukade_num,"mukade")
				var mukades = get_tree().get_nodes_in_group("mukade" + str(mukade_num))
				for mukade in mukades:
					mukade.damaging = true	
				if HP < 0:
					HP = 0
					for mukade in mukades:
						mukade.hit()
			area.queue_free()
		else:	
			if "angle" in area:
				area.angle = randf_range(10,170)
			elif "reflect" in area:
				area.reflect = true
				area.ang = randf_range(10,170)
					
		#queue_free()
	elif area.is_in_group("player"):
		if Global_var.barrier_num != 1 and area.is_visible:
			hited()
		area.enebody_damage()
		#area.queue_free()
		#queue_free()	
	pass # Replace with function body.
