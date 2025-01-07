extends Area2D
class_name _player

@onready var player_anim = $heroin_anim
const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
var muteki = false
#signal body_exited

@onready var inv_time = $invincible_time
@onready var invty_time = $invicibility 

var num_bul = 45

var bullet = preload("res://object/bullet/bullet_player.png")
var bul_scene = load("res://script/player/bullet/bullet_scene.tscn")
var player_ins = load("res://script/player/player/player.tscn")
var explosion = load("res://script/effect/exp_par.tscn")
var tonakai = preload("res://script/player/player/tonakai.tscn")
var barrier = preload("res://script/item/buf_item/barrier.tscn").instantiate()
var bullet2 = preload("res://script/player/bullet/player_bul_2.tscn").instantiate()
@export var bullet_texture:Texture2D
#var bullet_texture = bullet

var is_visible = false

@export var bullet_time = 1.0


var t = tonakai.instantiate()
var t2 = tonakai.instantiate()
var buf_num = 0


var chara_dir := Vector2.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var bullet_lag = Timer.new()
var bul_value = 0



func _ready():
	add_child(bullet_lag)
	bullet_lag.one_shot = true
	get_parent().remove_child(barrier)
	Global_var.barrier_num = 0
	get_parent().remove_child(t)
	get_parent().remove_child(t2)
	
	
	


func _physics_process(delta):
	if Global_var.player_move == true:
		if $invincible_time.is_stopped():
			
			
			chara_dir = Input.get_vector("left","right","up","down")
			
			
			if chara_dir.x > 0: player_anim.flip_h = false
			elif chara_dir.x < 0:player_anim.flip_h = true
			# Get the input direction and handle the movement/deceleration.
			# As good practice, you should replace UI actions with custom gameplay actions.
			
			if chara_dir:
				#velocity = chara_dir * SPEED

				if Input.is_action_pressed("up") || Input.is_action_pressed("down"):
					player_anim.play("heroin_flying")
				if Input.is_action_pressed("right") || Input.is_action_pressed("left"):
					player_anim.play("heroin_right")			
			
				pass
			else:
				#↓の処理で、ボタンを離したときに動きが止まる。（vector.ZEROの新しい値が運動エネルギーとして設定される。）
				#chara_dir.normalized()
				#velocity = velocity.move_toward(Vector2.ZERO,300)
				player_anim.play("heroin_flying")
				#pass
			position += chara_dir * SPEED * delta
			
			if !Global_var.tutorial:
				position.x = clamp(position.x,100,320)
				position.y = clamp(position.y,40,360)
			else:
				position.x = clamp(position.x,60,235)
				position.y = clamp(position.y,55,210)	
			
			#move_and_slide()
			if Input.is_action_pressed("shoot") and bullet_lag.is_stopped():
				if Global_var.life != 0:
					if $invincible_time.is_stopped():
						bullet_lag.start(bullet_time)
						if bul_value == 0:shoot_bullet()
						if bul_value == 1:shoot_bullet3(3)
							
				pass
			
			if Input.is_action_just_pressed("bomb"):
				if Global_var.life != 0:
					if $invincible_time.is_stopped():
						shoot_bomb()	

#--------------------------------------------------

func shoot_bullet() -> void:
	# 弾丸のインスタンスを作成
	#var bullet = Node2D.new()
	SoundManager.se_play("shot1")
	#@@@@@@@@@@@@@@@@@@@@@range_areaを親ノードにadd_childしてないので意味なし@@@@@@@@@@@@@
	var range_area = Area2D.new()
	var bullet_script = preload("res://script/player/bullet/bullet_script.gd").new()
	
	bullet_script.texture = bullet_texture
	
	
	
	range_area.add_child(bullet_script)
	
	
	var collision_shape = CollisionShape2D.new()
	var shape = RectangleShape2D.new()

	shape.size = Vector2(100,100)
	collision_shape.shape = shape
	range_area.add_child(collision_shape)
	
	#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	var bul = bul_scene.instantiate()
	get_parent().add_child(bul)
	#bullet.add_child(range_area)
	
	
	bul.position = player_anim.global_position
	
#----------------------------------------------
#-------------------------------------------------
	
func shoot_bullet2():
	var angle_step = 2 * PI / num_bul
	for i in range(num_bul):
		#SoundManager.se_play("shot1")
		var angle = i * angle_step
		var direction = transform.y.rotated(deg_to_rad(angle))
		#var direction = Vector2(cos(angle),sin(angle)).normalized()
		var bullet2 = preload("res://script/player/bullet/player_bul_2.tscn").instantiate()
		get_parent().add_child(bullet2)
		#bullet2.position = position
		bullet2.start(position)
		#bullet2.direction = direction 
		bullet2.set_direction(direction)
	pass	


#---------------------------------------------
#-----------------------------------------------
var shoot_direction = Vector2.UP
var bullet_num = 3	
	
func shoot_bullet3(pbullet_num):
	var main = get_tree().current_scene

	var dir = shoot_direction.rotated(global_rotation)
	var spread = 0.2
	SoundManager.se_play("shot1")
	if pbullet_num > 1:
		for i in range(pbullet_num):
			var a = -spread + i * (2 * spread) / (pbullet_num-1)
			var bullet2 = preload("res://script/player/bullet/player_bul_2.tscn").instantiate()
			bullet2.initialized(position,SPEED, dir.rotated(a))
			get_parent().add_child(bullet2)
	else:
		var bullet2 = preload("res://script/player/bullet/player_bul_2.tscn").instantiate()
		bullet2.initialized(position,SPEED, dir)
		get_parent().add_child(bullet2)		
	
#-----------------------------------------------------
#-------------------------------------------------------

func shoot_bomb():
	if Global_var.bomb_num > 0:
		var bomb = preload("res://script/player/bullet/bomb.tscn").instantiate()
		bomb.start(position)
		get_parent().add_child(bomb)
		Global_var.bomb_num -= 1
		if Global_var.tutorial:Global_var.bomb_num += 1
		if Global_var.bomb_num < 0:Global_var.bomb_num = 0

#--------------------------------------------	


func _process(delta):
	if Global_var.life != 0:
		if $invincible_time.is_stopped():
			if !is_visible:
				#restart_player()
				#await get_tree().create_timer(2.0).timeout
				self.modulate.a = 0.5
				#$CollisionShape2D.disabled = true
				#$approach1/CollisionShape2D.disabled = true
				if $invicibility.is_stopped():
					is_visible = true
					#$CollisionShape2D.disabled = false
					#$approach1/CollisionShape2D.disabled = false
					self.modulate.a = 1.0
	elif Global_var.life == 0:
		#$CollisionShape2D.disabled = true
		#$approach1/CollisionShape2D.disabled = true				
		pass	
	t.position = position - Vector2(-20,0)
	t2.position = position - Vector2(20,0)
	barrier.position = position								
	pass


func _on_area_2d_body_exited(body):
	print("c")
	#bullet.visible = false
	pass # Replace with function body.
	
func _on_body_exited(body:Node):
	queue_free()
	print("j")
	if body.is_in_group(&"bullets"):
		pass	






func _on_area_entered(area):
	
	if area.is_in_group("enemy"):
		if is_visible == true:
			if $invincible_time.is_stopped():
				area.hited()
				if Global_var.barrier_num != 1:
					SoundManager.se_play("beated1")
					exp_instance()
					buf_num = 0
					get_parent().remove_child(t)
					get_parent().remove_child(t2)			
					$invincible_time.start(2.0)
					$invicibility.start(4.0)	
					is_visible = false	
					Global_var.life -= 1
					self.modulate.a = 0
				if Global_var.barrier_num == 1:
					SoundManager.se_play("barrier_off")
					Global_var.barrier_num -= 1
					get_parent().remove_child(barrier)
					is_visible = false
					$invicibility.start(4.0)			
	elif area.is_in_group("ene_shot"):
		if is_visible == true:
			if $invincible_time.is_stopped():
				area.hit()
				if Global_var.barrier_num != 1:
					buf_num = 0
					SoundManager.se_play("beated1")
					get_parent().remove_child(t)
					get_parent().remove_child(t2)			
					exp_instance()
					$invincible_time.start(2.0)
					$invicibility.start(4.0)	
					is_visible = false	
					self.modulate.a = 0															
					Global_var.life -= 1
				if Global_var.barrier_num == 1:
					SoundManager.se_play("barrier_off")
					Global_var.barrier_num -= 1
					get_parent().remove_child(barrier)
					is_visible = false
					$invicibility.start(4.0)
				#queue_free()
			#restart_player()
	pass # Replace with function body.

func enebody_damage():
	if is_visible == true:
		if $invincible_time.is_stopped():
			if Global_var.barrier_num != 1:
				SoundManager.se_play("beated1")
				exp_instance()
				buf_num = 0
				get_parent().remove_child(t)
				get_parent().remove_child(t2)			
				$invincible_time.start(2.0)
				$invicibility.start(4.0)	
				is_visible = false	
				Global_var.life -= 1
				self.modulate.a = 0

			if Global_var.barrier_num == 1:
				SoundManager.se_play("barrier_off")
				Global_var.barrier_num = 0
				get_parent().remove_child(barrier)
				is_visible = false
				$invicibility.start(4.0)	

func _on_approach_1_area_entered(area):
	if area.is_in_group("enemy1") or area.is_in_group("enemy2") or area.is_in_group("enemy_shot_1") or area.is_in_group("enemy_shot_2") or area.is_in_group("enemy3") or area.is_in_group("enemy4") or area.is_in_group("enemy_shot_3") or area.is_in_group("enemy"):
		if $invincible_time.is_stopped():
			SoundManager.se_play("approach")
			Global_var.approach_num += 1
	pass # Replace with function body.
	
func restart_player():
	#var current_scene = get_tree().current_scene
	var p = player_ins.instantiate()
	get_parent().add_child(p)
	p.start_pos(position)
	#get_tree().reload_current_scene()
	#self.visible = true	
	
func start_pos(pos):
	position = pos	
	
func _finish_ani(del):
	del.queue_free()
	
	
func exp_instance():
	var e = explosion.instantiate()
	get_parent().add_child(e)
	
	e.start(position)
	e.ani_num(true,false)
	


func _on_bufitem_entered(area):
	if area.is_in_group("buf_item1"):
		if $invincible_time.is_stopped():
			SoundManager.se_play("power1")
			if buf_num == 0:
				get_parent().add_child(t)
			if buf_num == 1:
				get_parent().add_child(t2)
			buf_num += 1
	elif area.is_in_group("barrier_item"):
		if $invincible_time.is_stopped():
			SoundManager.se_play("barrier1")
			get_parent().add_child(barrier)
			barrier.start(position)
			Global_var.barrier_num = 1
			area.queue_free()					
		#t.position = Vector2(200,300)
	elif area.is_in_group("shoot_item1"):
		if $invincible_time.is_stopped():
			SoundManager.se_play("power1")
			bul_value = 1
			Global_var.bul_type_def = false
			Global_var.bul_type1 = true
			area.queue_free()
	elif area.is_in_group("shoot_item_def"):
		if $invincible_time.is_stopped():
			SoundManager.se_play("power1")
			bul_value = 0
			Global_var.bul_type_def = true
			Global_var.bul_type1 = false			
			area.queue_free()
	elif area.is_in_group("heart"):
		if $invincible_time.is_stopped():
			SoundManager.se_play("up2")
			Global_var.life += 1
			if Global_var.life > 3:Global_var.life = 3
			area.queue_free()						
		pass
	pass # Replace with function body.
