extends Control

@onready var back = $ColorRect/VBoxContainer/back
@onready var option = $ColorRect/VBoxContainer/option
@onready var save = $ColorRect/VBoxContainer/save
@onready var load = $ColorRect/VBoxContainer/load
@onready var title = $ColorRect/VBoxContainer/title

var trans_path = "res://script/UI/title/title.tscn"

var paused = 0
var current_select = 0
@export var select_num = 4
var ui_num = 0
#var main = preload("res://main_ui.tscn").instantiate()
# Called when the node enters the scene tree for the first time.
func _ready():
	paused = 0
	#var paused_swi = true
	#var current_select = 0
	var main = get_tree().get_nodes_in_group("main")
	for m in main:
		#print(m)
		pass
	#process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	pass # Replace with function body.

func pause(pau:bool):
	get_tree().paused = pau	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_select == 0:
		back.emit_signal("mouse_entered")
		#back.modulate = Color(1,1,1)
	else:
		back.emit_signal("mouse_exited")
	
	if current_select == 1:
		option.emit_signal("mouse_entered")
		#option.modulate = Color(1,1,1)
		pass
	else:
		#option.modulate = Color(0,0,0)
		option.emit_signal("mouse_exited")
	
	if current_select == 2:
		load.emit_signal("mouse_entered")
		#back.modulate = Color(1,1,1)
	else:
		#load.modulate = Color(0,0,0)
		load.emit_signal("mouse_exited")
			
	if current_select == 3:
		title.emit_signal("mouse_entered")
		#back.modulate = Color(1,1,1)
	else:
		#title.modulate = Color(0,0,0)						
		title.emit_signal("mouse_exited")
		
						
				
	if Input.is_action_just_pressed("down"):
		current_select = min(current_select + 1,select_num)
		#print(current_select)		
		SoundManager.se_play("select1")
		if current_select == select_num:
			current_select = 0	
			#print(current_select)
	elif Input.is_action_just_pressed("up"):
		current_select = max(current_select - 1,-1)
		#print(current_select)
		SoundManager.se_play("select1")
		if current_select == -1:
			current_select = select_num - 1	
					
			
	if Input.is_action_just_pressed("shoot"):
		if current_select == 0:
			SoundManager.se_play("decide1")
			back.emit_signal("pressed")
		elif current_select == 1:
			SoundManager.se_play("decide1")
			option.emit_signal("pressed")
		elif current_select == 2:
			SoundManager.se_play("decide1")
			load.emit_signal("pressed")	
		elif current_select == 3:
			SoundManager.se_play("decide1")
			title.emit_signal("pressed")						
					
				
	#if Input.is_action_just_pressed("pause") and get_tree().paused:
		#get_tree().paused = false
		#queue_free()
	#elif Input.is_action_just_pressed("pause") and !get_tree().paused:	
		#get_tree().paused = true

	if Input.is_action_just_pressed("pause"):
		paused += 1        #ボタンをおすなどしてシーンを移動したりしたときに０に戻す。main_uiとの同時発火を防ぐため。
		if paused >= 2:
			SoundManager.se_play("reject")
			get_tree().paused = false	
			Engine.time_scale = 1
			var mains = get_tree().get_nodes_in_group("main")
			for main in mains:
				main.is_pause = !main.is_pause
			#get_parent().remove_child(self)
			queue_free()
			paused = 0
				
	#pass


func _on_back_pressed():
	get_tree().paused = false
	Engine.time_scale = 1
	var mains = get_tree().get_nodes_in_group("main")
	for main in mains:
		main.is_pause = !main.is_pause	
	#set_process(true)
	#queue_free()
	get_parent().remove_child(self)
	paused = 0
	pass # Replace with function body.







func _on_mouse_entered(extra_arg_0):
	if extra_arg_0 == 0:
		back.modulate = Color(1,1,1)
	elif extra_arg_0 == 1:
		option.modulate = Color(1,1,1)
	elif extra_arg_0 == 2:
		load.modulate = Color(1,1,1)
	elif extra_arg_0 == 3:
		title.modulate = Color(1,1,1)								
	pass # Replace with function body.


func _on_mouse_exited(extra_arg_0):
	if extra_arg_0 == 0:
		back.modulate = Color(0,0,0)
	elif extra_arg_0 == 1:
		option.modulate = Color(0,0,0)
	elif extra_arg_0 == 2:
		load.modulate = Color(0,0,0)
	elif extra_arg_0 == 3:
		title.modulate = Color(0,0,0)	
	pass # Replace with function body.


func _on_option_pressed():
	process_mode = Node.PROCESS_MODE_DISABLED
	var opt = preload("res://script/UI/title/option_ui.tscn").instantiate()
	#get_tree().get_root().add_child(option)
	get_parent().add_child(opt)
	pass # Replace with function body.



func _on_load_pressed():
	SaveLoad.load_game(1)

	SoundManager.bgm_stop()
	get_tree().reload_current_scene()
	get_parent().remove_child(self)
	
	current_select = 0
	
	

	pass # Replace with function body.


func _on_title_pressed():
	
	get_tree().paused = false
	Engine.time_scale = 1
	get_parent().remove_child(self)
	SoundManager.bgm_stop()
	TransManager.transition_to(trans_path)
	pass # Replace with function body.
