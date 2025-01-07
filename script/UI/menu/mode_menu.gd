extends Control

@onready var eazy = $ModeFrame/VBoxContainer/eazy
@onready var normal = $ModeFrame/VBoxContainer/normal
@onready var hard = $ModeFrame/VBoxContainer/hard 
@onready var back = $ModeFrame/back

var select_num = 4
var current_select = 0

var trans_path = "res://script/UI/prologue/prologue.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	#get_tree().paused = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("down"):
		current_select = min(current_select + 1,select_num)
		#print(current_select)
		SoundManager.se_play("select1")
		if current_select == select_num:
			current_select = 0
	if Input.is_action_just_pressed("up"):
		current_select = max(current_select - 1,-1)
		SoundManager.se_play("select1")
		if current_select == -1:
			current_select = select_num - 1
	
	if current_select == 0:
		eazy.toggle_mode = true
		eazy.button_pressed = true
		hard.toggle_mode = false
		hard.button_pressed = false
		normal.toggle_mode = false
		normal.button_pressed = false		
	elif current_select == 1:
		normal.toggle_mode = true
		normal.button_pressed = true
		eazy.toggle_mode = false
		eazy.button_pressed = false	
		hard.toggle_mode = false
		hard.button_pressed = false			
	elif current_select == 2:
		hard.toggle_mode = true
		hard.button_pressed = true
		normal.toggle_mode = false
		normal.button_pressed = false
		eazy.toggle_mode = false
		eazy.button_pressed = false	
	elif current_select == 3:
		back.emit_signal("mouse_entered")
		normal.toggle_mode = false
		normal.button_pressed = false
		eazy.toggle_mode = false
		eazy.button_pressed = false	
		hard.toggle_mode = false
		hard.button_pressed = false			
	if current_select != 3:
		back.emit_signal("mouse_exited")		
		
	if Input.is_action_just_pressed("shoot"):
		if current_select == 0:
			eazy.emit_signal("pressed")
			SoundManager.se_play("decide1")
		elif current_select == 1:
			normal.emit_signal("pressed")
			SoundManager.se_play("decide1")
		elif current_select == 2:
			hard.emit_signal("pressed")	
			SoundManager.se_play("decide1")
		elif current_select == 3:
			back.emit_signal("pressed")	
			SoundManager.se_play("decide1")	
			
	if Input.is_action_just_pressed("pause"):
		back.emit_signal("pressed")									
	pass


func _on_eazy_pressed():
	get_tree().paused = false
	Global_var.ene_apptime = 70
	Global_var.difficulty = 1
	TransManager.trans_in()
	await TransManager.transitioned_in
	TransManager.trans_imi_out(trans_path)	
	pass # Replace with function body.


func _on_normal_pressed():
	get_tree().paused = false
	Global_var.ene_apptime = 50
	Global_var.difficulty = 2
	TransManager.trans_in()
	await TransManager.transitioned_in
	TransManager.trans_imi_out(trans_path)	
	pass # Replace with function body.


func _on_hard_pressed():
	get_tree().paused = false
	Global_var.ene_apptime = 30
	Global_var.difficulty = 3
	TransManager.trans_in()
	await TransManager.transitioned_in
	TransManager.trans_imi_out(trans_path)	
	pass # Replace with function body.


func _on_back_pressed():
	var titles = get_tree().get_nodes_in_group("title")
	for title in titles:
		title.process = true
		title.dec_count = 2
	get_tree().paused = false	
	queue_free()
	pass # Replace with function body.


func _on_back_mouse_entered():
	back.modulate = Color(1,1,0)
	pass # Replace with function body.


func _on_back_mouse_exited():
	back.modulate = Color(1,1,1)
	pass # Replace with function body.
