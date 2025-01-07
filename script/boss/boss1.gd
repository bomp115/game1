extends Area2D

#signal boss_stage
signal boss_app
signal resetedPosition
signal end

@onready var ani = $AnimatedSprite2D
@onready var col = $CollisionShape2D

var HP = 5000

var count = [75,0,0,0,0,150,0,0,0,0]
var count_end1 = [false,true,true,true,true,true]
var phase = 0

var boss_stage = false
var boss_end = false

var dis_time = false
var _app = false

var shoot_time_int = 10
var shoot_time_lag = 20
var shoot_time_lag2 = 20
var shoot_time_lag3 = 20
var shoot_time_lag_disturb = 10
var shoot_time = shoot_time_lag
var shoot_time_disturb = 0
var speed = 50

var angle = 0

var randm_att

var resetPosition = true

var boss_shot1 = preload("res://script/enemy/bullet/enemy_shot_1.tscn")
var boss_shot2 = preload("res://script/enemy/bullet/enemy_shot_2.tscn")



var num_bullet = 45
var bul_speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(220,-50)
	scale = Vector2(0.7,0.7)
	col.disabled = true
	if Global_var.difficulty == 2:
		shoot_time_lag_disturb = 20
	elif Global_var.difficulty == 3:
		shoot_time_lag_disturb = 10	
	else:
		shoot_time_lag_disturb = 30	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _app == false:
		if position.y < 30:
			self.modulate.a = 0
			position += Vector2.DOWN * speed * delta
		elif position.y > 30 and position.y <= 70:
			self.modulate.a = 1	
			position += Vector2.DOWN * speed * delta	
		if position.y >= 70:
			_app = true
			boss_app.emit()		
	if boss_stage:
		#var players = get_tree().get_nodes_in_group("player")
		#for player in players:
			#var dis = player.position.distance_to(position)
			#print(dis)
			#if dis_time == false:
				#if dis <= 100:
					#if player.position.y > position.y:
						#position += Vector2.UP * speed * delta
						##dis_time = true
						#await get_tree().create_timer(2.0).timeout
						##dis_time = false
				#elif dis > 100:
					#if player.position.x >= position.x:
						#position += Vector2.RIGHT * speed * delta
						#position += Vector2.UP * speed * delta
						#$AnimatedSprite2D.play("vamp_r")
						#attack1()
						#shoot_time -= 1
						##dis_time = true
						#await get_tree().create_timer(2.0).timeout
						##dis_time = false				
					#elif player.position.x < position.x:
						#position += Vector2.LEFT * speed * delta
						#position += Vector2.DOWN * speed * delta
						#$AnimatedSprite2D.play("vamp_l")
						#attack2()
						#shoot_time -= 1
						##dis_time = true
						#await get_tree().create_timer(2.0).timeout
						##dis_time = false
			#if dis_time == false:
				#dis_time = true
				#$AnimatedSprite2D.play("vamp_def")
				#await get_tree().create_timer(1.0).timeout
				#dis_time = false
#---------------------------------------------
		col.disabled = false
		if resetPosition:
			ani.play("vamp_def")
			position.x += cos(atan2(30 - position.y,55 + (330 / 2) - position.x))	* 800 * delta
			position.y += sin(atan2(70 - position.y,35 + (330 / 2) - position.x))	* 800 * delta
			if abs(position.x - (55 + (330 / 2))) <= 15 and abs(position.y - 70) <= 15:
				angle = 0
				speed = 0
				resetPosition = false
				resetedPosition.emit()
		else:
			position.x += cos(deg_to_rad(angle)) * speed * delta	
			position.y += sin(deg_to_rad(angle)) * speed * delta

		if !boss_end:
			if phase < 3:
				if count_end1[0] == false:
					if count[0] > 0:
						ani.play("vamp_l")
						angle = 180
						speed = 100	
						shoot_time -= 10
						attack2()
						if Global_var.difficulty != 1:attack_disturb()
						count[0] -= 1
					else:
						count[0] = 75
						count[1] = 130
						count_end1[0] = true
						count_end1[1] = false
				if count_end1[1] == false:
					if count[1] > 0:
						ani.play("vamp_r")
						angle = 0
						speed = 100
						shoot_time -= 10
						attack2()
						if Global_var.difficulty != 1:attack_disturb()
						count[1] -= 1
					else:
						#count[0] = 75
						count_end1[0] = true			
						count_end1[1] = true
						count_end1[2] = false
						count[2] = 60
				if !count_end1[2]:
					if count[2] > 0:
						ani.play("vamp_l")
						speed = 100
						angle = 180
						attack2()
						if Global_var.difficulty != 1:attack_disturb()
						shoot_time -= 10
						count[2] -= 1
					else:
						count_end1[2] = true
						count_end1[3] = false
						count[3] = 60

				if !count_end1[3]:		
					if count[3] > 0:
						ani.play("vamp_def")
						count[3] -= 1
						speed = 0
					else:
						print("a")
						count_end1[3] = true
						#count_end[0] = false
						count_end1[4] = false
						count[4] = 60
						
				if !count_end1[4]:
					if count[4] > 0:
						ani.play("vamp_att")
						attack_ene1()
						speed = 0
						shoot_time -= 10
						count[4] -= 1
					else:
						count_end1[4] = true
						count_end1[0] = false
						count[0] = 60
						phase += 1	
					pass		
					
			if phase >= 3:
				if !count_end1[0]:
					if count[5] > 0:
						angle = 90
						speed = 50
						attack_disturb_whole()
						ani.play("vamp_front")
						count[5] -= 1
					else:
						count_end1[0] = true
						count_end1[1] = false
						randm_att = randi_range(0,1)
						count[5] = 150
						count[6] = 150
				elif !count_end1[1]:
					if count[6] > 0:
						speed = 0	
						ani.play("vamp_att")
						print(randm_att)
						if randm_att == 1:attack_swirl()
						else:attack1()
						shoot_time -= shoot_time_int
						count[6] -= 1
					else:
						count_end1[1] = true
						count_end1[2] = false
						count[6] = 150
						count[7] = 75
				elif !count_end1[2]:
					if count[7] > 0:
						ani.play("vamp_def")
						resetPosition = true	
						count[7] -= 1
					else:
						count_end1[2] = true
						count_end1[0] = false
						count[7] = 75		
						phase = 0
									
				pass		
							
		#if !count_end[4]:
			
				
				
					
					
				#resetPosition = true
			#count[0] = 0
		#if count[1] > 0:
			#angle = 0
			#attack2()
			#count[1] -= 1
					
				
		pass		
							
	
	pass
	
func _physics_process(delta):
	position.x = clamp(position.x,100,320)
	position.y = clamp(position.y,40,360)	
	pass
	
func attack1():
	if shoot_time < 0:
		var angle_step = 2 * PI / num_bullet
		var ang = 0
		for i in range(num_bullet):
			var angle = i * angle_step
			#var direction = Vector2(cos(angle),sin(angle)).normalized()
			var boss2_shot_ins = boss_shot2.instantiate()
			boss2_shot_ins.angle = ang
			ang += 10
			get_parent().add_child(boss2_shot_ins)
			boss2_shot_ins.start(position)
			#boss2_shot_ins.set_direction(direction,bul_speed)
			shoot_time = shoot_time_lag - Global_var.level		

func attack2():
	if shoot_time < 0:
		var boss_shot1_ins = boss_shot1.instantiate()
		boss_shot1_ins.isHoming = true
		get_parent().add_child(boss_shot1_ins)
		boss_shot1_ins.start(position)
		shoot_time = shoot_time_lag2 - Global_var.level	

func attack_swirl():
	if shoot_time < 0:
		var boss2_shot_ins = boss_shot2.instantiate()
		boss2_shot_ins.angle = angle
		boss2_shot_ins.speed = 100
		angle += 10
		get_parent().add_child(boss2_shot_ins)	
		boss2_shot_ins.start(position)
		shoot_time = shoot_time_lag - Global_var.level		
		
func attack_ene1():
	if	shoot_time < 0:
		var boss_eneshot1 = preload("res://script/enemy/bullet/enemy_bullet.tscn").instantiate()
		var boss_eneshot2 = preload("res://script/enemy/bullet/enemy_bullet.tscn").instantiate()
		var boss_eneshot3 = preload("res://script/enemy/bullet/enemy_bullet.tscn").instantiate()
		boss_eneshot1.boss_shot = true
		boss_eneshot2.boss_shot = true
		boss_eneshot3.boss_shot = true
		boss_eneshot1.angle = 45
		boss_eneshot2.angle = 90
		boss_eneshot3.angle = 135
		get_parent().add_child(boss_eneshot1)
		get_parent().add_child(boss_eneshot2)
		get_parent().add_child(boss_eneshot3)
		boss_eneshot1.start(position)
		boss_eneshot2.start(position)
		boss_eneshot3.start(position)
		shoot_time = shoot_time_lag3 - Global_var.level
		
func attack_disturb():
	if shoot_time_disturb < 0:
		var bullet_disturb = load("res://script/enemy/bullet/bulllet_disturb.tscn").instantiate()
		get_parent().add_child(bullet_disturb)
		bullet_disturb.start(position)
		shoot_time_disturb = shoot_time_lag_disturb
	else:
		shoot_time_disturb -= 10
		
func attack_disturb_whole():
	if shoot_time_disturb < 0:
		var bullet_disturb = load("res://script/enemy/bullet/bulllet_disturb.tscn").instantiate()
		bullet_disturb.whole_round = true
		get_parent().add_child(bullet_disturb)
		bullet_disturb.start(position)
		shoot_time_disturb = shoot_time_lag_disturb
	else:
		shoot_time_disturb -= 10			
				
		
								


func _on_area_entered(area):
	if area.is_in_group("player"):
		area.enebody_damage()
	elif area.is_in_group("shot"):
		HP -= area.damage
		area.queue_free()
		
			
		
	pass # Replace with function body.
