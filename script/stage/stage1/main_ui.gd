extends Node2D

signal _start
signal end

signal _eve
#var stage_size:Vector2
#@onready var bullet = $player/bullet
@onready var stage1 = $StageMati4
@onready var heroin_move = $player
@onready var stage = $StageMati4
@onready var collision_bullet = $bullet_col/CollisionShape2D
@onready var heart1 = $HBoxContainer/SantaHeart20240912 
@onready var heart2 = $HBoxContainer/SantaHeart20240913 
@onready var heart3 = $HBoxContainer/SantaHeart20240914 
@onready var result = $result

@onready var bul_col = $bullet_col

var gameover_lag = false
var boss_hpbar_app = false
var boss_end = false

var mes_ins = false
var mes_ins_end = false

var mukade_app = false
var mukade_num = 1

var bul_ins = preload("res://script/player/bullet/bullet_scene.tscn")
var ene1 = preload("res://script/enemy/enemy_1.tscn")
var ene2 = preload("res://script/enemy/enemy_2.tscn")
var ene3 = preload("res://script/enemy/enemy_3.tscn")
var ene4 = preload("res://script/enemy/enemy_4.tscn")
var ene6 = preload("res://script/enemy/enemy_6.tscn")
var mukade = preload("res://script/enemy/enemy_mukade_2.tscn")
var ghost = preload("res://script/enemy/ghost.tscn")
var enemy_bullet = preload("res://script/enemy/bullet/enemy_bullet.tscn")

var boss1 = preload("res://script/boss/boss_1.tscn").instantiate()

var over_menu = preload("res://script/UI/menu/gameover.tscn").instantiate()

var santa_tatie = preload("res://script/UI/tatie/santa_tatie.tscn").instantiate()
var vam_tatie = preload("res://script/UI/tatie/vampire_tatie.tscn").instantiate()

var mes_syu = preload("res://script/UI/message/message_syu.tscn").instantiate()
var mes_vam = preload("res://script/UI/message/message_vam.tscn").instantiate()


var bul_script = preload("res://script/player/bullet/bullet_script.gd")

var trans_path = "res://script/UI/title/title.tscn"

var mukade_time = [10,0,0,0,0,0,0,0]
var mukade_time_lag = 20
#var mukade = [true,false,false,false,false,false,false,false]

var time = Timer.new()

var dis:int
var e_b = ene3.instantiate()

var is_pause = false


var scrool_speed
var stage_speed = 0.3

var phase = 0
var phase_time

var ene_time = 100
var ene_time2 = 10

@onready var col_size = collision_bullet
var chara_dir:Vector2
# Called when the node enters the scene tree for the first time.

func free_ene():
	var enes = get_tree().get_nodes_in_group("enemy")
	for ene in enes:
		ene.queue_free()
	var shots = get_tree().get_nodes_in_group("ene_shot")
	for shot in shots:
		shot.queue_free()
	var bosses = get_tree().get_nodes_in_group("boss1")
	for boss in bosses:
		boss.queue_free()	
		
func free_shot():
	var shots = get_tree().get_nodes_in_group("ene_shot")
	for shot in shots:
		shot.queue_free()			

func _ready():
	if Global_var.difficulty == 1:phase_time = 15
	elif Global_var.difficulty == 2:phase_time = 30
	else:phase_time = 50
	Global_var.lines = 0
	Global_var.playing = true
	Global_var.player_move = true
	$StageMati4.material.set_shader_parameter("scroll_speed",0.3)
	free_ene()
	get_tree().paused = false
	Engine.time_scale = 1
	Global_var.life = 3
	Global_var.bomb_num = 3
	SaveLoad.save(1)
	Global_var.player_pos = $player.position
	SoundManager.bgm_play("stage1")
	$start.play("start1_fade")
	await _start
	await get_tree().create_timer(2.0).timeout
	$start.play("start1_out")
	await _start
	$start.play("start2_in")
	await _start
	await get_tree().create_timer(2.0).timeout
	$start.play("start2_out")
	await _start	
	#bul_col.body_exited.connect(Callable(,"_on_body_exited"))
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("pause"):
		pause()
		#var current_paused = get_tree().paused
		#get_tree().paused = !current_paused
		#print(current_paused)
		pass	
		#$StageMati4.material.set_shader_parameter("scroll_speed",scrool_speed)		
 
func _process(delta):
	#if mukade_app:ene_mukade()
	if phase == 0:
		pass	
	
	if phase == 3 or phase == 4:
		if ene_time2 < 0:
			ene_born(ene6,Vector2(110,45))
			if Global_var.difficulty == 3:ene_time2 = 10
			elif Global_var.difficulty == 2:ene_time2 = 30
			else:ene_time2 = 50
		else:
			ene_time2 -= 1	

	
	if phase == 1:
		if ene_time < 0:
			ene_born(ene1,Vector2(randf_range(100,320),45))
			#ene_born(mukade,Vector2(110,135))
			if Global_var.difficulty == 3:ene_born(ghost,Vector2(110,45))
			ene_time = Global_var.ene_apptime
			#mukade_app = true
			phase = 1.5
		else:
			ene_time -= 1
	if phase == 1.5:
		if ene_time < 0:
			ene_born(ene4,Vector2(280,35))
			if Global_var.difficulty == 3:ene_born(ene3,Vector2(110,35))
			ene_time = Global_var.ene_apptime
			phase = 1
		else:
			ene_time -= 1

	if phase == 2:
		if ene_time < 0:
			ene_born(ene2,Vector2(randf_range(100,320),35))
			if Global_var.difficulty != 1:ene_born(ene1,Vector2(randf_range(100,320),35))
			ene_time = Global_var.ene_apptime
			ene_born(enemy_bullet,Vector2(randi_range(100,320),35))
		else:
			ene_time -= 1			
						
	if phase == 3:
		if ene_time < 0:
			ene_born(ene1,Vector2(randf_range(100,320),35))
			ene_born(ene2,Vector2(randf_range(100,320),35))
			ene_time = Global_var.ene_apptime
		else:
			ene_time -= 1
							
	if phase == 4:
		if ene_time < 0:
			#ene_born(ene1)
			ene_born(ene2,Vector2(randf_range(100,320),35))
			if Global_var.difficulty == 3:ene_born(ene3,Vector2(150,35))
			ene_born(ghost,Vector2(110,45))
			ene_time = Global_var.ene_apptime
		else:
			ene_time -= 1
	if phase == 5:
		if ene_time < 0:
			ene_born(ene3,Vector2(110,35))
			ene_born(ene4,Vector2(280,35))
			if Global_var.difficulty == 3:ene_born(ghost,Vector2(110,110))
			ene_time = Global_var.ene_apptime
		else:
			ene_time -= 1			
				
	if phase == 8:
		boss_hp_app()
		boss_hp()
		ending()
		boss_end = false
		
		pass
		
							
	

						
	update_bullet()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var velocity_m = Vector2.ZERO
	velocity_m.x = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity_m.y = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity_m = velocity_m.normalized()

	chara_dir.x = Input.get_axis("left", "right")
	chara_dir.y = Input.get_axis("up", "down")
	
	if Global_var.life == 3:
		heart1.modulate.a = 1.0	
		heart2.modulate.a = 1.0	
		heart3.modulate.a = 1.0	
	elif Global_var.life == 2:
		heart1.modulate.a = 1.0	
		heart2.modulate.a = 1.0		
		heart3.modulate.a = 0.5	
	elif Global_var.life == 1:
		heart1.modulate.a = 1.0
		heart2.modulate.a = 0.5
		heart3.modulate.a = 0.5	
	elif Global_var.life == 0:
		heart1.modulate.a = 0.5
		heart1.modulate.a = 0.5
		heart1.modulate.a = 0.5	
		if gameover_lag == false:
			gameover_lag = true
			await get_tree().create_timer(2.0).timeout
			get_tree().paused = true
			Engine.time_scale = 0
			gameover_lag = false
			get_parent().add_child(over_menu)
			
							
	pass
	
func update_bullet():
	var stage_size = stage1.texture.get_size() - Vector2(100,50)
	var stage_position = stage1.global_position
	#Global_var.collision_bullet = collision_bullet
 
	#var screen_size = get_viewport().size
	#var screen_rect = Rect2(Vector2.ZERO,screen_size)
	
	var bullet_rect = Global_var.bullet_rect
	var stage_rect = Rect2(stage_position,stage_size)
	
	var is_within_screen = bullet_rect.intersects(stage_rect)
	
	if is_within_screen:
		#Global_var.bullet.show()
		#print("a")
		pass
	else:
		#Global_var.bullet.hide()	
		#print("b")
		pass
	
	pass	
	
func _on_body_exited():
	print("i")
	#bullet.queue_free()
	pass

func ene_born(pack:PackedScene,pos:Vector2):
	var e = pack.instantiate()
	get_parent().add_child(e)
	#e.start_ran()
	e.start(pos)
	if pack == enemy_bullet:
		e.stage_enemy = true
	return e
		

func _on_timer_timeout():
	if phase == 0:
		phase = 1
		$phase.start(phase_time)
	elif phase == 1 or phase == 1.5:
		phase = 2
		$phase.start(phase_time)
	elif phase == 2:
		phase = 3
		$phase.start(phase_time)
	elif phase == 3:
		phase = 4
		$phase.start(phase_time)
	elif phase == 4:
		phase = 5
		$phase.start(phase_time)
	elif phase == 5:
		phase = 8
		$phase.start(3)		
	elif phase == 8:
		free_ene()
		get_parent().add_child(boss1)
		Global_var.player_move = false
		await boss1.boss_app
		get_parent().add_child(santa_tatie)
		get_parent().add_child(vam_tatie)
		santa_tatie._in()
		vam_tatie._in()		
		$StageMati4.material.set_shader_parameter("scroll_speed",0.1)
		await santa_tatie.santa_tatie_start
		get_parent().add_child(mes_syu)
		get_parent().add_child(mes_vam)
		var wait_meses = get_tree().get_nodes_in_group("mes_syu")
		var wait_vams = get_tree().get_nodes_in_group("mes_vam")
		for wait_mes in wait_meses:
			wait_mes.mes_win_in()
		for wait_vam in wait_vams:
			wait_vam.mes_win_in()		
		for wait_mes in wait_meses:
			await wait_mes.mes_end
			wait_mes.mes_out()
			#wait_mes.mes_out2()
		for wait_vam in wait_vams:
			wait_vam.mes_out()
			#wait_vam.mes_out2()
		santa_tatie._out()
		vam_tatie._out()
		await santa_tatie.santa_tatie_fin
		SoundManager.bgm_stop()
		SoundManager.bgm_play("boss1")
		boss_hpbar_app = true
		Global_var.player_move = true
		boss1.boss_stage = true
		
		#boss1.boss_stage.emit()
		
		pass			
	pass # Replace with function body.


func _on_start_animation_finished(anim_name):
	_start.emit()
	pass # Replace with function body.
	
func pause():
	
	is_pause = !is_pause
	#get_tree().paused = is_pause
	print(is_pause)
	if is_pause:
		SoundManager.se_play("decide1")
		var pause_ui = preload("res://script/UI/menu/pause_ui.tscn").instantiate()
		
		get_parent().add_child(pause_ui)
		#pause_ui.pause(true)
		
		get_tree().paused = is_pause
		#self.set_process(false)
		#$pause_ui.set_process(true)
		var scrool_speed = 0
		Engine.time_scale = 0
	else:
		#pause_ui.pause(false)
		get_tree().paused = is_pause
		#self.set_process(true)
		var pause_ui = preload("res://script/UI/menu/pause_ui.tscn").instantiate()
		#var pause_ui = preload("res://pause_ui.tscn").instantiate()
		get_parent().remove_child(pause_ui)
		
		#set_process(true)	
		var scrool_speed = stage_speed
		Engine.time_scale = 1	
	pass	
	
func boss_hp_app():
	if boss_hpbar_app:
		$boss_hpbar.visible = true
		var bosses = get_tree().get_nodes_in_group("boss1")
		for boss in bosses:
			if $boss_hpbar.value < boss.HP:
				$boss_hpbar.value += 50
			else:
				boss_hpbar_app = false	

func boss_hp():
	var bosses = get_tree().get_nodes_in_group("boss1")
	for boss in bosses:
		$boss_hpbar.value = boss.HP
		if boss.HP < 0:
			$boss_hpbar.value = 0
			boss.HP = 0
			boss_end = true	
			
func ending():
	if boss_end:
		free_shot()
		Global_var.player_move = false
		end_text()
		var bosses = get_tree().get_nodes_in_group("boss1")
		for boss in bosses:
			boss.boss_end = true
			boss.resetPosition = true
			await boss.resetedPosition
			boss.boss_stage = false
		santa_tatie._in()
		vam_tatie._in()						
		await santa_tatie.santa_tatie_start
		if !mes_ins:
			var mes_syu = preload("res://script/UI/message/message_syu.tscn").instantiate()
			var mes_vam = preload("res://script/UI/message/message_vam.tscn").instantiate()
			get_parent().add_child(mes_syu)
			get_parent().add_child(mes_vam)
			mes_ins = true
		#mes_syu.visible = true
		#mes_vam.visible = true	
		var wait_meses = get_tree().get_nodes_in_group("mes_syu")
		var wait_vams = get_tree().get_nodes_in_group("mes_vam")
		Global_var.mode = false
		for wait_mes in wait_meses:
			wait_mes.wait_scene = false
			wait_mes.mes_win_in()
			#wait_mes.visible = true
			break
		for wait_vam in wait_vams:
			wait_vam.wait_scene = false
			wait_vam.mes_win_in()	
			#wait_vam.visible = true		
			break
		for wait_mes in wait_meses:
			await wait_mes.ending_mes #会話終了
			if !mes_ins_end:wait_mes.mes_out()
			break
		for wait_vam in wait_vams:
			if !mes_ins_end:wait_vam.mes_out()
			mes_ins_end = true
			break
		santa_tatie._out()
		vam_tatie._out()
		await santa_tatie.santa_tatie_fin
		result.visible = true
		result.start.emit()
		result.se_start.emit()
		result.cal_start = true	
		#if result.t_value == Global_var.score + Global_var.approach_num * 100 + Global_var.continue_num * -100:
			#result.cal_start = false
		#elif !result.cal_start:
		await result.end
		result.stage_change(trans_path)	
		
var text_read = false		
		
func end_text():
	if !text_read:
		Global_var.mes2 = []
		Global_var.mes3 = []
		Global_var.lines2 = 0
		Global_var.lines3 = 0
		Global_var.scene = 2
		if Global_var.language == "en":
			Global_var.mes2.append("")
			Global_var.mes3.append("Damn... here...")
			Global_var.mes2.append("Are you still going to do it?\n I have to take care of you now, don't I?")
			Global_var.mes3.append("")
			Global_var.mes2.append("#@Vampires are not as powerful as they were in their heyday, even though they are not as prominent as they used to be. \nYou should know your own size.")
			Global_var.mes3.append("")
			Global_var.mes2.append("")
			Global_var.mes3.append("#@I am the last surviving vampire.\n If I don't do my duty here, I'll be doing my ancestors a disservice.")
			Global_var.mes2.append("#@If that's the case, at least change the date. Then we won't have to bother you.")
			Global_var.mes3.append("")
			Global_var.mes2.append("")
			Global_var.mes3.append("#@You're going to let me get away with this? You'll regret it.")
			Global_var.mes2.append("#@Do you think we're some kind of watchdogs of justice or something?\n Well, if it gets too much, we might stop them even outside of Christmas.")
			Global_var.mes3.append("")
			Global_var.mes2.append("And for that matter, put yourself in the shoes of the people who will be caught up in your blood donation.")
			Global_var.mes3.append("")
			Global_var.mes2.append("If you kill someone because of it, it would be a complete disaster for both parties.")
			Global_var.mes3.append("")
			Global_var.mes2.append("")
			Global_var.mes3.append("#@You have to at least do that to be acknowledged for your existence. \nBut I'll be careful next time.")
			Global_var.mes2.append("~~~~@")
			Global_var.mes3.append("~~~~@")
		else:	
			Global_var.mes2.append("")
			Global_var.mes3.append("くそ・・こんなところで・・")
			Global_var.mes2.append("まだやるの？\nこれ以上はあんたを始末しなきゃなんないんだけど？")
			Global_var.mes3.append("")
			Global_var.mes2.append("#@だいたい、ただでさえ昔と違って吸血鬼なんて影が薄くなってるのに、全盛期のような力を奮えるわけないじゃない。身の丈を思い知りなさい。")
			Global_var.mes3.append("")
			Global_var.mes2.append("")
			Global_var.mes3.append("#@あたしは吸血鬼の最後の生き残りよ\nここで意地を通さなきゃ先祖にし、示しがつかないわ")
			Global_var.mes2.append("#@ならせめて日を改めなさいな。そしたらあたしたちもとやかくいわずに済むしね。")
			Global_var.mes3.append("")
			Global_var.mes2.append("")
			Global_var.mes3.append("#@あんた、あたしの横暴を見逃すっていうの？後悔するわよ。")
			Global_var.mes2.append("#@あたしたちを正義の番人かなにかと勘違いしてる？まあ、あんまり度が過ぎるようだったらクリスマス以外でも止めにいくことはあるかもね。")
			Global_var.mes3.append("")
			Global_var.mes2.append("それにしたって、あんたたちの献血に巻き込まれる人の身にもなってみなさいな。それで殺したりなんてしたら、お互い本末転倒でしょうが。")
			Global_var.mes3.append("")
			Global_var.mes2.append("")
			Global_var.mes3.append("#@それくらいはしなきゃ、存在を認められないのよ。でも、次からは気を付けるわ。")
			Global_var.mes2.append("~~~~@")
			Global_var.mes3.append("~~~~@")
		
		
		text_read = true	
		





func _on_end():
	print("end")
	pass # Replace with function body.
