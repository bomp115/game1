extends Node2D

@onready var ani = $ghost_main/AnimatedSprite2D
@onready var col = $ghost_main/CollisionShape2D
@onready var main = $ghost_main

var ghost

var prespawntimer = 0
var dir = 1
var dirtarget = 0
var movetimer = 0
var speed = 50
var pos = Vector2.ZERO
var basepos = Vector2.ZERO

var seg_size = 6
var bodysegment = []

var path_str
var exp_int = load("res://script/effect/exp_par.tscn")
var enemy_shot1 = preload("res://script/enemy/bullet/enemy_shot_3.tscn")
var item1 = preload("res://script/item/buf_item/buf_item_1.tscn")
var barrier_item = preload("res://script/item/buf_item/barrier_item.tscn")
var shoot_item1 = preload("res://script/item/buf_item/shoot_item_1.tscn")
var shoot_item2 = preload("res://script/item/buf_item/shoot_item_def.tscn")
var ghost_script = load("res://script/enemy/ghost_main.gd")
# Called when the node enters the scene tree for the first time.
func _ready():
	start(Vector2(randi_range(120,300),45))
	ani.play("def")
	basepos = position
	pos = basepos
	
	for i in seg_size:
		var a = Area2D.new()
		#path_str = i
		a.set_script(ghost_script)
		#print(a.get_script())
		self.add_child(a)
		var s = AnimatedSprite2D.new()
		var c = CollisionShape2D.new()
		#s.visible = true
		#s.play("def") 
		#s.add_to_group("ghost" + str(i))
		#a.add_child(s)
		#var c = col.duplicate()
		#c.disabled = false
		#a.add_child(c)
		sprite_ani(s,a)
		set_col(c,a)
		
		
		a.area_entered.connect(_on_area_entered.bind(i))
		#print(a.is_connected("area_entered",_on_area_entered))
		bodysegment.push_back({
			area = a,
			node = s,
			col = c,
			pos = position
		})
			
	pass # Replace with function body.


func sprite_ani(node,parent):
	var frame = SpriteFrames.new()
	frame.add_animation("def")
	frame.add_frame("def",load("res://object/enemy/ghost/ghost1.png"))
	frame.add_frame("def",load("res://object/enemy/ghost/ghost2.png"))
	frame.add_frame("def",load("res://object/enemy/ghost/ghost3.png"))
	frame.add_frame("def",load("res://object/enemy/ghost/ghost4.png"))
	frame.add_frame("def",load("res://object/enemy/ghost/ghost5.png"))
	node.sprite_frames = frame
	parent.add_child(node)
	node.play("def")
	node.visible = true
	return node
	
func set_col(node,parent):
	var rectangle = RectangleShape2D.new()
	rectangle.size = Vector2(23,30)	
	node.shape = rectangle
	parent.add_child(node)
	return node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#prespawntimer += 1.0 * delta
	#if prespawntimer >= 0.5:
	movetimer += 1.0 * delta
	
	position.y += dir * speed * delta
	
	pos.x = basepos.x - 20 * cos(2.0*movetimer) + lerp(-40,0,0.9)
	position.x = pos.x #pos.xのみを参照しないとposition.yにはpos.y=0が代入される。
	
	updatebody(delta)
	field_limit()
	
	pass
	
func start(pos):
	global_position = pos	
	
func updatebody(delta):
	var prev = {pos = position}	
	for i in bodysegment.size():
		var body = bodysegment[i]
		body.pos = Global_var.lexp(body.pos,prev.pos,3.0 * delta)
		prev = body
		
		body.node.position = body.pos - position
		body.col.position = body.node.position

func field_limit():
	if position.x < Global_var.field_x or position.x > Global_var.field_lx:
		self.modulate.a = 0
	else:
		self.modulate.a = 1
	for i in bodysegment.size():
		if bodysegment[i].pos.y > Global_var.field_ly:
			bodysegment[i].area.remove_child(bodysegment[i].node)
			bodysegment[i].area.remove_child(bodysegment[i].col)
			if i == seg_size - 1:
				queue_free()
				break
	pass			

var item_setting = _item_setting.new()

func hit(enemy):
	Global_var.score += 100
	item_setting.app_multi(enemy,bodysegment,get_parent())									
		

func explosion(enemy):
	var e = exp_int.instantiate()
	get_parent().add_child(e)
	if enemy == 0:e.position = bodysegment[0].pos
	if enemy == 1:e.position = bodysegment[1].pos
	if enemy == 2:e.position = bodysegment[2].pos
	if enemy == 3:e.position = bodysegment[3].pos
	if enemy == 4:e.position = bodysegment[4].pos
	if enemy == 5:e.position = bodysegment[5].pos
	e.ani_num(false,true)		

func pos_change():
	bodysegment[0].pos = Vector2(1000,500)
	bodysegment[1].node.position = Vector2(1000,500)
	bodysegment[2].node.position = Vector2(1000,500)
	bodysegment[3].node.position = Vector2(1000,500)
	bodysegment[4].node.position = Vector2(1000,500)
	
func col_change(enemy):
	if enemy == 0:bodysegment[0].col.disabled = true;bodysegment[0].col.visible = false
	if enemy == 1:bodysegment[1].col.disabled = true;bodysegment[1].col.visible = false
	if enemy == 2:bodysegment[2].col.disabled = true;bodysegment[2].col.visible = false
	if enemy == 3:bodysegment[3].col.disabled = true;bodysegment[3].col.visible = false
	if enemy == 4:bodysegment[4].col.disabled = true;bodysegment[4].col.visible = false
	if enemy == 5:bodysegment[5].col.disabled = true;bodysegment[5].col.visible = false
		
func hp_free(enemy):
	#if enemy == 0:bodysegment[0].area.target = ""
	#if enemy == 1:bodysegment[1].area.target = ""
	#if enemy == 2:bodysegment[2].area.target = ""
	#if enemy == 3:bodysegment[3].area.target = ""
	#if enemy == 4:bodysegment[4].area.target = ""
	#if enemy == 5:bodysegment[5].area.target = ""
	pass


var tonakai_bul = _tonakai_bul.new()

func _on_area_entered(area:Area2D,arg):
	if area.is_in_group("shot"):
		area.queue_free()
		SoundManager.se_play("beat1")
		if arg == 0:bodysegment[0].area.set_script(null);self.remove_child(bodysegment[0].area);explosion(0);hit(0);col_change(0);bodysegment[0].area.remove_child(bodysegment[0].col);hp_free(0);
		if arg == 1:bodysegment[1].area.set_script(null);self.remove_child(bodysegment[1].area);explosion(1);hit(1);col_change(1);bodysegment[1].area.remove_child(bodysegment[1].col);hp_free(1);
		if arg == 2:bodysegment[2].area.set_script(null);self.remove_child(bodysegment[2].area);explosion(2);hit(2);col_change(2);bodysegment[2].area.remove_child(bodysegment[2].col);hp_free(2);
		if arg == 3:bodysegment[3].area.set_script(null);self.remove_child(bodysegment[3].area);explosion(3);hit(3);col_change(3);bodysegment[3].area.remove_child(bodysegment[3].col);hp_free(3);
		if arg == 4:bodysegment[4].area.set_script(null);self.remove_child(bodysegment[4].area);explosion(4);hit(4);col_change(4);bodysegment[4].area.remove_child(bodysegment[4].col);hp_free(4);
		if arg == 5:bodysegment[5].area.set_script(null);self.remove_child(bodysegment[5].area);explosion(5);hit(5);col_change(5);bodysegment[5].area.remove_child(bodysegment[5].col);hp_free(5);
	if area.is_in_group("player"):
		if Global_var.barrier_num != 1 and area.is_visible:
			area.enebody_damage()
			if arg == 0:bodysegment[0].area.set_script(null);bodysegment[0].area.remove_child(bodysegment[0].node);bodysegment[0].area.remove_child(bodysegment[0].col);hp_free(0)
			if arg == 1:bodysegment[1].area.set_script(null);bodysegment[1].area.remove_child(bodysegment[1].node);bodysegment[1].area.remove_child(bodysegment[1].col);hp_free(1)
			if arg == 2:bodysegment[2].area.set_script(null);bodysegment[2].area.remove_child(bodysegment[2].node);bodysegment[2].area.remove_child(bodysegment[2].col);hp_free(2)
			if arg == 3:bodysegment[3].area.set_script(null);bodysegment[3].area.remove_child(bodysegment[3].node);bodysegment[3].area.remove_child(bodysegment[3].col);hp_free(3)
			if arg == 4:bodysegment[4].area.set_script(null);bodysegment[4].area.remove_child(bodysegment[4].node);bodysegment[4].area.remove_child(bodysegment[4].col);hp_free(4)
			if arg == 5:bodysegment[5].area.set_script(null);bodysegment[5].area.remove_child(bodysegment[5].node);bodysegment[5].area.remove_child(bodysegment[5].col);hp_free(5)	
	#pass	
	
												
