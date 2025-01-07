extends Node2D


@export var speed = 50
@export var bul_speed = 100
@export var pos_cha = 0
var HP = 50
var dead = false
#@export var curve:Curve
var target_position :Vector2 = Vector2(150,300)
var current_position:Vector2
var current_direction = Vector2(1,0)

#@onready var path = $PathFollow2D
@onready var ani = $Area2D/mukade_seg
@onready var seg = $Area2D/mukade_seg
@onready var col = $Area2D/CollisionShape2D
#@onready var area = $enemy6_follow/enemy_6

var _shoot_item1 = false
var _shoot_item_def = true

var target_pos:Vector2
var direction:Vector2
var direction_body
var count = 200

var damaging = false

var bodysegment = []
var a
	
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

var move_end = [false,true,true,true,true,true]

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
	for i in 8: #0~7
		a = ani.duplicate()
		var c = col.duplicate()
		a.play("body" + str(i))
		ani.add_sibling(a)
		a.visible = true
		c.visible = true
		if i == 0:
			a.head = true
		else:
			a.head = false
		$Area2D.add_child(c)
		#a.rotation = 0.1
		#if i != 0:
			#a.rotation = 9.0	
		bodysegment.push_back({
			node = a,
			pos = position + Vector2(0,-60),
			shape = c,
			head = a.head
		})	
		
	newtarget(Vector2(200,100))		
		#if i == 1 or i == 2 or i== 3 or i== 4 or i == 5 or i == 6:
			#a.visible = false	
		#else:
			#a.visible = true	
		
	#ani.position = self.curve.get_point_position(0)
	#current_position = position
	pass # Replace with function body.

func start(pos:Vector2):
	#position.x = pos_x
	#position.y = pos_y
	position = pos
	for i in bodysegment.size():
		bodysegment[i].pos = pos
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
	

	position += direction * speed * delta
	
		
	for i in bodysegment.size():
		if bodysegment[i].pos.x > 330 or bodysegment[i].pos.y > 340:
			$Area2D.remove_child(bodysegment[i].node)
			#bodysegment[i].node.free()
			#break
			if i == 7:
				queue_free()	
			
	if position.y > 80:
		#position += Vector2.LEFT
		pass		
		#position.x += speed * delta
	pass
							
	#----------------------------------------
	if damaging:
		var tween = get_tree().create_tween()
		for i in bodysegment.size():
			tween.tween_property(bodysegment[i].node,"modulate",Color(1,0,0,1),0.1).set_trans(Tween.TRANS_CUBIC)
			tween.tween_property(bodysegment[i].node,"modulate",Color(1,1,1,1),0.1).set_trans(Tween.TRANS_CUBIC)
		damaging = false
	#---------------------------------------------
	#---------------------------------------------	
	update_body(delta)	
		
	var target = ani.global_transform.origin
	#direction = (target - self.global_transform.origin).normalized()
	for i in bodysegment.size():
		#if bodysegment[i].node.position >= target_pos:
		#if bodysegment[0].node.rotation < direction.angle() + 1.5:
		#target_pos.normalized()
		#bodysegment[i].node.position += direction * speed * delta
		#if bodysegment[i].pos >= direction:
			#bodysegment[i].node.rotation = lerp(bodysegment[i].node.rotation,direction.angle() - 2.0,0.01)
			#pass 	
		#bodysegment[i].node.look_at(direction + Vector2(180,-80))
		pass	
	target_change()
		
#----------------------------------------------		
func update_body(delta):
	var prev = {pos = position}
	for i in bodysegment.size():
		var body = bodysegment[i]
		if i == 7:
			body.pos = Global_var.lexp(body.pos,prev.pos,2.0*delta)
		else:
			body.pos = Global_var.lexp(body.pos,prev.pos,3.0*delta)	
		if i == 0:
			bodysegment[i].node.rotation = lerp(bodysegment[i].node.rotation,direction.angle() + deg_to_rad(35) - 2.0,0.1)
		else:
			body.node.look_at(prev.pos)
			
					
		prev = body
		
		body.node.position = body.pos - position
		body.shape.position = body.node.position
		
		direction_body = (body.pos - prev.pos).normalized()	
		
			
		
func newtarget(target:Vector2):
	target_pos = target
	direction = (target_pos - position).normalized()
	
func target_change():
	if !move_end[0]:
		if count <= 0:
			newtarget(Vector2(200,100))
			count = 100
			move_end[0] = true
			move_end[1] = false
		else:
			count -= 1
	if !move_end[1]:
		if count <= 0:
			newtarget(Vector2(200,300))
			count = 200
			move_end[1] = true
			move_end[2] = false
		else:
			count -= 1	
	if !move_end[2]:
		if count <= 0:
			newtarget(Vector2(300,200))
			count = 60
			move_end[2] = true
			move_end[3] = false
		else:
			count -= 1							
#------------------------------------------------------------	
	
func hit():
	Global_var.score += 1000
	explosion_ene()
	
	randomize()
	var app_item:int = randf_range(1,50)
	if app_item == 1:
		var i = item1.instantiate()
		get_parent().add_child(i)
		i.start(position + Vector2(110,40))
	elif app_item == 2:
		get_parent().add_child(barrier_item)
		barrier_item.start(position + Vector2(110,40))
	elif app_item == 3 and Global_var.bul_type1 == false:
		shoot_item1 = preload("res://script/item/buf_item/shoot_item_1.tscn").instantiate()
		get_parent().add_child(shoot_item1)
		shoot_item1.start(position + Vector2(110,40))
	
	elif app_item == 4 and Global_var.bul_type_def == false:
		shoot_item2 = preload("res://script/item/buf_item/shoot_item_def.tscn").instantiate()
		get_parent().add_child(shoot_item2)
		shoot_item2.start(position + Vector2(110,40))		
						
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


func _on_area_entered(area):
	if area.is_in_group("shot"):
		for b in bodysegment:
			if b.head:
				print("head")
				HP -= area.damage
				#var mukades = get_tree().get_nodes_in_group("mukade_whole")
				#var mukades = get_tree().get_nodes_in_group("mukade" + str(mukade_num))
				#var stage1s = get_tree().get_nodes_in_group("main")
				#for stage1 in stage1s:
					#var mukade_num = stage1.mukade_num
					#print(mukade_num,"mukade")
					#var mukades = get_tree().get_nodes_in_group("mukade" + str(mukade_num))
					#for mukade in mukades:
				damaging = true	
				if HP < 0:
					HP = 0
					#for mukade in mukades:
					hit()
				area.queue_free()
			else:
				print("reflect")	
				if "angle" in area:
					area.angle = randf_range(10,170)
				elif "reflect" in area:
					area.reflect = true
					area.ang = randf_range(10,170)
					
		#queue_free()
	if area.is_in_group("player"):
		if Global_var.barrier_num != 1 and area.is_visible:
			hited()
		area.enebody_damage()
		#area.queue_free()
		#queue_free()	
	pass # Replace with function body.
