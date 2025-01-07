extends Control

var current_select = 0
var select_num = 5

var crt_select = 1
var language_select 

var slider_modulate_cal = true

@onready var back = $back
@onready var bgm_slider = $VBoxContainer3/bgm_slider
@onready var se_slider = $VBoxContainer3/se_slider
@onready var crt_on = $HBoxContainer/crt_on
@onready var crt_off = $HBoxContainer/crt_off
@onready var jp = $HBoxContainer2/jp
@onready var en = $HBoxContainer2/en
# Called when the node enters the scene tree for the first time.
func _ready():
	if Global_var.language == "en":language_select = 1
	else:language_select = 0
	var pause_ui = get_tree().get_nodes_in_group("pause")
	for pause in pause_ui:
		#print(pause.paused)	
		pause.paused = 0
	var bgm_vol = Global_var.bgm_vol
	var se_vol = Global_var.se_vol
	$VBoxContainer3/bgm_slider.value = bgm_vol
	$VBoxContainer3/se_slider.value = se_vol
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("bgm"),linear_to_db(bgm_vol))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("se"),linear_to_db(se_vol))
	pass # Replace with function body.



func crt_mode():
	$HBoxContainer/crt_on.toggle_mode = CrtFilter.on
	$HBoxContainer/crt_off.toggle_mode = CrtFilter.off
	$HBoxContainer/crt_on.button_pressed = CrtFilter.on
	$HBoxContainer/crt_off.button_pressed = CrtFilter.off	
	
func language_mode():
	if language_select == 0:
		jp.toggle_mode = true
		en.toggle_mode = false
		jp.button_pressed = true
		en.button_pressed = false
	elif language_select == 1:
		jp.toggle_mode = false
		en.toggle_mode = true
		jp.button_pressed = false
		en.button_pressed = true			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	emyu_left()
	crt_mode()
	language_mode()
	Engine.time_scale = 1
	if Input.is_action_just_pressed("pause"):
		var pause_ui = get_tree().get_nodes_in_group("pause")
		for pause in pause_ui:
			pause.paused = 1
			pass
		back.emit_signal("pressed")	
		#-------------------------------------------------
	if Input.is_action_just_pressed("down"):
		current_select = min(current_select + 1,select_num)
		SoundManager.se_play("select1")
		if current_select == select_num:
			current_select = 0
	if Input.is_action_just_pressed("up"):
		current_select = max(current_select - 1,-1)
		SoundManager.se_play("select1")
		if current_select == -1:
			current_select = select_num - 1			
		#-------------------------------------------------	
	if current_select == 0:
		$VBoxContainer3/se_slider.modulate.a = 1
		if $VBoxContainer3/bgm_slider.modulate.a <= 0.5:slider_modulate_cal = false
		elif $VBoxContainer3/bgm_slider.modulate.a >= 1:slider_modulate_cal = true
		if slider_modulate_cal:$VBoxContainer3/bgm_slider.modulate.a -= 0.01
		if !slider_modulate_cal:$VBoxContainer3/bgm_slider.modulate.a += 0.01
		if Input.is_action_pressed("left"):
			$VBoxContainer3/bgm_slider.value -= 0.5
			#print($VBoxContainer3/bgm_slider.value)
		if Input.is_action_pressed("right"):
			$VBoxContainer3/bgm_slider.value += 0.5
	elif current_select == 1:	
		$VBoxContainer3/bgm_slider.modulate.a = 1
		if $VBoxContainer3/se_slider.modulate.a <= 0.5:slider_modulate_cal = false
		elif $VBoxContainer3/se_slider.modulate.a >= 1:slider_modulate_cal = true
		if slider_modulate_cal:$VBoxContainer3/se_slider.modulate.a -= 0.01
		if !slider_modulate_cal:$VBoxContainer3/se_slider.modulate.a += 0.01
		if Input.is_action_pressed("left"):
			$VBoxContainer3/se_slider.value -= 0.5
		if Input.is_action_pressed("right"):
			$VBoxContainer3/se_slider.value += 0.5		
	else:
		bgm_slider.modulate.a = 1
		se_slider.modulate.a = 1
		
	if 	current_select == 2:
		if Input.is_action_just_pressed("left"):
			language_select += 1
			if language_select % 2 == 0:jp.emit_signal("pressed")
			if language_select % 2 == 1:en.emit_signal("pressed")
			if language_select >= 2:language_select = 0
		if Input.is_action_just_pressed("right"):
			language_select += 1
			if language_select % 2 == 0:jp.emit_signal("pressed")
			if language_select % 2 == 1:en.emit_signal("pressed")
			if language_select >= 2:language_select = 0
		if language_select % 2 == 0:
			jp.modulate = Color(1,1,0)
			en.modulate = Color(1,1,1)
		elif language_select % 2 == 1:
			jp.modulate = Color(1,1,1)													
			en.modulate = Color(1,1,0)
	else:
		jp.modulate = Color(1,1,1)
		en.modulate = Color(1,1,1)			
			
				
	if current_select == 3:
		if Input.is_action_just_pressed("left"):
			crt_select += 1
			if crt_select % 2 == 0:
				_on_crt_on_pressed()
			elif crt_select % 2 == 1:
				_on_crt_off_pressed()
		if Input.is_action_just_pressed("right"):
			crt_select += 1
			if crt_select % 2 == 0:
				_on_crt_on_pressed()
			elif crt_select % 2 == 1:
				_on_crt_off_pressed()	
		if crt_select % 2 == 0:
			crt_on.modulate = Color(1,1,0)
			crt_off.modulate = Color(1,1,1)
		elif crt_select % 2 == 1:
			crt_on.modulate = Color(1,1,1)													
			crt_off.modulate = Color(1,1,0)
	else:
		crt_on.modulate = Color(1,1,1)
		crt_off.modulate = Color(1,1,1)	
		
	if current_select == 4:
		back.modulate = Color(1,1,0)
		if Input.is_action_just_pressed("shoot"):
			back.emit_signal("pressed")	
	else:
		back.modulate = Color(1,1,1)											
	pass


func _on_bgm_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("bgm"),linear_to_db(value))
	Global_var.bgm_vol = value
	pass # Replace with function body.


func _on_se_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("se"),linear_to_db(value))
	Global_var.se_vol = value
	pass # Replace with function body.
	

func linear_to_db(value):
	if value == 0:
		return -80
	return 10 * log(value)
	pass


func emyu_left():
	var event = InputEventMouseButton.new()
	event.button_index = MOUSE_BUTTON_LEFT
	event.pressed = true


func _on_crt_on_pressed():
	$HBoxContainer/crt_on.toggle_mode = true
	$HBoxContainer/crt_off.toggle_mode = false	
	$HBoxContainer/crt_on.button_pressed = true
	CrtFilter.on = true
	CrtFilter.off = false
	CrtFilter.crt_on()
	pass # Replace with function body.


func _on_crt_off_pressed():
	$HBoxContainer/crt_on.toggle_mode = false
	$HBoxContainer/crt_off.toggle_mode = true
	$HBoxContainer/crt_off.button_pressed = true
	CrtFilter.on = false
	CrtFilter.off = true
	CrtFilter.crt_off()	
	pass # Replace with function body.


func _on_crt_off_mouse_entered():
	$HBoxContainer/crt_off.toggle_mode = true
	pass # Replace with function body.


func _on_crt_on_mouse_entered():
	$HBoxContainer/crt_on.toggle_mode = true
	pass # Replace with function body.


func _on_back_pressed():
	if Global_var.playing:	
		get_tree().paused = true
		Engine.time_scale = 0
		var pauses = get_tree().get_nodes_in_group("pause")
		for pause in pauses:
			pause.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	else:
		var titles = get_tree().get_nodes_in_group("title")
		for title in titles:
			title.process = true
			title.dec_count = 2	
		get_tree().paused = false
		Engine.time_scale = 1 	
	#queue_free()
	SoundManager.se_play("reject")
	queue_free()
	
	pass # Replace with function body.


func _on_language_pressed(extra_arg_0):
	if extra_arg_0 == 0:
		Global_var.translation_setting.jp()
		jp.toggle_mode = true
		en.toggle_mode = false
		jp.button_pressed = true
		en.button_pressed = false
	elif extra_arg_0 == 1:
		Global_var.translation_setting.en()
		jp.toggle_mode = false
		en.toggle_mode = true
		jp.button_pressed = false
		en.button_pressed = true
	pass # Replace with function body.
