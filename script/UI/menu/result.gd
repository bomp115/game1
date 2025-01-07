class_name Result
extends Control

signal start
signal end

signal se_start

@onready var ani = $AnimationPlayer
@onready var score = $score
@onready var approach = $approach
@onready var con = $continue
@onready var total = $total
@onready var clear = $clear
@onready var difficulty = $difficulty
@onready var color1 = $ColorRect
@onready var color2 = $ColorRect2
@onready var color3 = $ColorRect3
@onready var color4 = $ColorRect4
@onready var color5 = $ColorRect5

@onready var score_v = $score/value
@onready var approach_v = $approach/value
@onready var con_v = $continue/value
@onready var total_v = $total/value

var s_value = 0
var a_value = 0
var c_value = 0
var t_value = 0

var cal_start
# Called when the node enters the scene tree for the first time.
func _ready():
	colorrect()
	difficulty_dis()
	pass # Replace with function body.

func _se_start():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if cal_start:
		if s_value < Global_var.score:
			s_value += 1
			SoundManager.se_play("score_dis")
		elif a_value < Global_var.approach_num and s_value == Global_var.score:
			SoundManager.se_play("score_dis")
			a_value += 1
		elif c_value < Global_var.continue_num and a_value == Global_var.approach_num:
			SoundManager.se_play("score_dis")
			c_value += 1
			if c_value == Global_var.continue_num:
				SoundManager.se_play("con_dis")
		elif t_value < s_value + a_value * 100 + c_value * -100 and c_value == Global_var.continue_num:
			SoundManager.se_play("score_dis")
			t_value += 1	
				
			
		label_value_dis()	
		
		if Input.is_action_just_pressed("shoot") or Input.is_action_just_pressed("lmb"):
			if s_value < Global_var.score:
				s_value = Global_var.score
			elif a_value < Global_var.approach_num and s_value == Global_var.score:
				a_value = Global_var.approach_num	
			elif c_value < Global_var.continue_num and a_value == Global_var.approach_num:
				c_value = Global_var.continue_num
				SoundManager.se_play("con_dis")
			elif t_value < s_value + a_value * 100 + c_value * -100 and c_value == Global_var.continue_num:
				t_value = s_value + a_value * 100 + c_value * -100 
				if t_value < 0:t_value = 0
			elif t_value == s_value + a_value * 100 + c_value * -100 or t_value <= 0:
				end.emit()				

		#if t_value == s_value + a_value * 100 + c_value * -100:
			#cal_start = false
		#elif !cal_start:
			#if Input.is_action_just_pressed("shoot") or Input.is_action_just_pressed("lmb"):
					
		pass
	

func tatie_in():
	ani.play("tatie_in")
	
func label_ani():
	tatie_in()
	#await get_tree().create_timer(1.0).timeout
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CIRC)
	tween.set_parallel()
	tween.tween_property(clear,"position",clear.position + Vector2.RIGHT * 360,0.8)
	tween.tween_property(score,"position",score.position + Vector2.RIGHT * 200,0.9)
	tween.tween_property(approach,"position",approach.position + Vector2.RIGHT * 200,1.0)
	tween.tween_property(con,"position",con.position + Vector2.RIGHT * 200,1.1)
	tween.tween_property(total,"position",total.position + Vector2.RIGHT * 200,1.2)
	
func label_value_dis():
	score_v.text = str(s_value)
	approach_v.text = str(a_value) + " × 100"
	con_v.text = str(c_value) + " × -100"
	total_v.text = str(t_value) 
		
			
func difficulty_dis():
	if Global_var.difficulty == 1:difficulty.text = "難易度：簡単"
	if Global_var.difficulty == 2:difficulty.text = "難易度：普通"
	if Global_var.difficulty == 3:difficulty.text = "難易度：難しい"

func stage_change(path):
	TransManager.transition_to(path)
	SoundManager.bgm_stop()	
	
func colorrect():
	color1.size.x = 640
	color1.size.y = 400	
	color2.size = Vector2(3,400)
	color2.position = Vector2(8,0)
	color3.size = Vector2(3,400)
	color3.position = Vector2(632,0)
	color4.size = Vector2(640,3)
	color4.position = Vector2(0,8)
	color5.size = Vector2(640,3)
	color5.position = Vector2(0,392)

func _on_start():
	label_ani()
	pass # Replace with function body.


func _on_se_start():
	await get_tree().create_timer(0.5).timeout
	SoundManager.se_play("clear_dis")
	pass # Replace with function body.
