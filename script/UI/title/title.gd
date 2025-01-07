extends Control

@onready var ground = $StaticBody2D

@onready var start = $TitileFrame/VBoxContainer/start
@onready var opt = $TitileFrame/VBoxContainer/option
@onready var exp = $TitileFrame/VBoxContainer/explanation

var process = true

var bound_count = 0
var dec_count = 0

var current_select = 0
var select_num = 3 #実際の選択肢より１多い
# Called when the node enters the scene tree for the first time.
func _ready():
	Global_var.translation_setting.default()
	Global_var.playing = false
	Global_var.player_move = false
	SaveLoad.load_game(1)
	process = true
	_free()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("bgm"),linear_to_db(Global_var.bgm_vol))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("se"),linear_to_db(Global_var.se_vol))
	var bound_count = 0
	var dec_count = 0
	
	var current_select = 0
	var select_num = 3 #実際の選択肢より１多い
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if process:
		Engine.time_scale = 1
		get_tree().paused = false		
	
	#print($RigidBody2D.position)
	if Input.is_action_just_pressed("shoot"):
		$start_label/AnimationPlayer.play("start_label_visible")
		dec_count += 1
		#print(dec_count)
		if dec_count >= 2:
			if dec_count == 2:SoundManager.se_play("decide1")
			$start_label.visible = false
			$TitileFrame.visible = true
			if dec_count >= 3:
				if current_select == 0:
					if dec_count == 3:SoundManager.se_play("decide1")
					start.emit_signal("pressed")
					pass
				elif current_select == 1:
					if dec_count == 3:SoundManager.se_play("decide1")
					opt.emit_signal("pressed")
					pass
				elif current_select == 2:
					if dec_count == 3:SoundManager.se_play("decide1")
					exp.emit_signal("pressed")
					pass	
	
	if dec_count >= 2:
		if process:	
			if Input.is_action_just_pressed("down"):
				current_select = min(current_select + 1,select_num)
				SoundManager.se_play("select1")
				if current_select == select_num:
					current_select = 0
			if 	Input.is_action_just_pressed("up"):
				current_select = max(current_select - 1,-1)	
				SoundManager.se_play("select1")
				if current_select == -1:
					current_select = select_num - 1	
					
			if current_select == 0:
				start.emit_signal("mouse_entered")
				opt.emit_signal("mouse_exited")
				exp.emit_signal("mouse_exited")
			elif current_select == 1:
				opt.emit_signal("mouse_entered")
				start.emit_signal("mouse_exited")
				exp.emit_signal("mouse_exited")
			elif current_select == 2:
				exp.emit_signal("mouse_entered")
				opt.emit_signal("mouse_exited")
				start.emit_signal("mouse_exited")				
					
					
	pass


func _on_rigid_body_2d_body_entered(body):
	if body.is_in_group("ground"):
		#print("g")
		$RigidBody2D.apply_impulse(Vector2(0,-30))
		bound_count += 1
		SoundManager.se_play("falling_att")
		if bound_count > 3 and dec_count < 2:
			$start_label/AnimationPlayer.play("start_label_visible")
			dec_count = 1
				
			pass
	pass # Replace with function body.





func _on_mouse_entered(extra_arg_0):
	if extra_arg_0 == 0:
		start.modulate = Color(1,1,0)
	if extra_arg_0 == 1:
		opt.modulate = Color(1,1,0)
	if extra_arg_0 == 2:
		exp.modulate = Color(1,1,0)				
	pass # Replace with function body.


func _on_mouse_exited(extra_arg_0):
	if extra_arg_0 == 0:
		start.modulate = Color(1,1,1)
	if extra_arg_0 == 1:
		opt.modulate = Color(1,1,1)
	if extra_arg_0 == 2:
		exp.modulate = Color(1,1,1)	
	pass # Replace with function body.


func _on_pressed(extra_arg_0):
	if process:
		process = false
		if extra_arg_0 == 0:
			#get_tree().change_scene_to_file("res://main_ui.tscn")
			#TransManager.trans_in()
			#await TransManager.transitioned_in
			#TransManager.trans_imi_out("res://prologue.tscn")
			
			get_tree().paused = true
			var mode = preload("res://script/UI/menu/mode_menu.tscn").instantiate()
			add_child(mode)
			pass
		if extra_arg_0 == 1:
			#get_tree().paused = true
			var option = preload("res://script/UI/title/option_ui.tscn").instantiate()
			get_parent().add_child(option)
		if extra_arg_0 == 2:
			#exit.modulate = Color(1,1,1)	
			#await get_tree().create_timer(2.0).timeout
			#get_tree().quit()
			$explanation.visible = true
			$explanation.tutorial_start.emit()
			#self.process_mode = Node.PROCESS_MODE_DISABLED
			
			
	pass # Replace with function body.

func _free():
	var enes = get_tree().get_nodes_in_group("enemy")
	for ene in enes:
		ene.queue_free()
	var shots = get_tree().get_nodes_in_group("ene_shot")
	for shot in shots:
		shot.queue_free()
	var bosses = get_tree().get_nodes_in_group("boss")
	for boss in bosses:
		boss.queue_free()	
