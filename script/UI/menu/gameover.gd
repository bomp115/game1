extends Control


@onready var retry = $VBoxContainer/retry
@onready var quit = $VBoxContainer/quit

var current_select = 0
var select_num = 2

var trans_path = "res://script/UI/title/title.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("down"):
		current_select = min(current_select + 1,select_num)
		if current_select == select_num:
			current_select = 0
	if Input.is_action_just_pressed("up"):
		current_select = max(current_select - 1,-1)
		if current_select == -1:
			current_select = select_num - 1
	pass
	
	if Input.is_action_just_pressed("shoot"):
		if current_select == 0:
			retry.emit_signal("pressed")
		elif current_select == 1:
			quit.emit_signal("pressed")	
	
	if current_select == 0:
		retry.emit_signal("mouse_entered")
		quit.emit_signal("mouse_exited")
	elif current_select == 1:
		quit.emit_signal("mouse_entered")			
		retry.emit_signal("mouse_exited")





func _on_mouse_entered(extra_arg_0):
	#0=retry 1=quit
	if extra_arg_0 == 0:
		retry.modulate = Color(1,1,1)
	if extra_arg_0 == 1:
		quit.modulate = Color(1,1,1)	
	pass # Replace with function body.

func _on_retry_mouse_exited():
	retry.modulate = Color(0,0,0)
	pass # Replace with function body.
func _on_quit_mouse_exited():
	quit.modulate = Color(0,0,0)
	pass # Replace with function body.


func _on_retry_pressed():
	SaveLoad.load_game(1)
	#queue_free()
	#get_tree().reload_current_scene()
	get_tree().paused = false
	Engine.time_scale = 1
	Global_var.continue_num += 1
	get_parent().remove_child(self)
	pass # Replace with function body.

func _on_quit_pressed():
	get_tree().paused = false
	Engine.time_scale = 1
	SaveLoad.load_game(1)
	Global_var.continue_num = 0
	Global_var._free()
	get_parent().remove_child(self)
	SoundManager.bgm_stop()
	TransManager.transition_to(trans_path)	
	pass # Replace with function body.
