extends Node2D

@onready var ani = $AnimationPlayer

@onready var serif = $message

@export var pic_lag = 2.0

var trans_path = "res://script/stage/stage1/main_ui.tscn"

var anim_ceed = 0
var anim_ceed2 = 0

signal pic1_in
signal pic1_out
signal pic5_in
signal pic5_out
signal pic2_in
signal pic2_out
signal pic3_in
signal pic3_out
signal pic4_in
signal pic4_out
signal pic7_in
signal pic7_out

signal mes



# Called when the node enters the scene tree for the first time.
func _ready():
	SoundManager.bgm_play("prologue")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if anim_ceed == 0:
		ani.play("pic1_in")
		await pic1_in
		anim_ceed = 0.5
	if anim_ceed == 0.5:
		await mes
		#serif.text = ""
		anim_ceed = 1	
		#serif.text += Global_var.mes[Global_var.lines]
	if anim_ceed == 1:	
		anim_ceed = 1.25
		await get_tree().create_timer(3).timeout
		ani.play("pic1_out")
		await pic1_out
		anim_ceed = 1.5
	if anim_ceed == 1.5:
		#await mes
		anim_ceed = 2	
	if anim_ceed == 2:
		ani.play("pic5_in")
		$pic5.play("pic5_ani")
		await pic5_in
		anim_ceed = 2.5
	if anim_ceed == 2.5:
		await mes
		anim_ceed = 3	
	if anim_ceed == 3:
		anim_ceed = 3.5
		await get_tree().create_timer(3).timeout	
		ani.play("pic5_out")
		await pic5_out	
		anim_ceed = 4	
	if anim_ceed == 4:	
		ani.play("pic2_in")
		$pic2.play("pic2_ani")
		await pic2_in
		anim_ceed = 5
	if anim_ceed == 5:
		await mes	
		await get_tree().create_timer(pic_lag).timeout
		ani.play("pic2_out")
		await pic2_out
		anim_ceed = 6
	if anim_ceed == 6:	
		ani.play("pic3_in")
		await pic3_in
		anim_ceed = 7
	if anim_ceed == 7:
		await mes	
		await get_tree().create_timer(pic_lag).timeout
		ani.play("pic3_out")
		await pic3_out
		anim_ceed = 8
	if anim_ceed == 8:	
		ani.play("pic4_in")
		await pic4_in
		anim_ceed = 9
	if anim_ceed == 9:	
		anim_ceed = 9.5
		await mes
		await get_tree().create_timer(pic_lag).timeout
		ani.play("pic4_out")
		anim_ceed = 10
	if anim_ceed == 10:	
		await pic4_out
		anim_ceed = 10.5
		$Santa20240807.visible = true
		await get_tree().create_timer(1.0).timeout
		anim_ceed = 11
	if anim_ceed == 11:	
		anim_ceed = 11.5
		$Santa20240807.visible = false
		await get_tree().create_timer(0.5).timeout
		anim_ceed = 12
	if anim_ceed == 12:	
		anim_ceed = 12.5
		$Santa202408152.visible = true
		await get_tree().create_timer(1.0).timeout
		anim_ceed = 13
	if anim_ceed == 13:	
		anim_ceed = 13.5
		$Santa202408152.visible = false
		await get_tree().create_timer(0.5).timeout
		anim_ceed = 14
	if anim_ceed == 14:	
		
		$Santa202408172.visible = true
		anim_ceed = 14.5
		await get_tree().create_timer(2.0).timeout
		anim_ceed = 15
	if anim_ceed == 15:	
		ani.play("pic7_out")
		SoundManager.bgm_stop()
		anim_ceed = 15.5
		await pic7_out
		$Santa20240807.visible = false
		$Santa202408152.visible = false
		$Santa202408172.visible = false
		anim_ceed = 16
	if anim_ceed == 16:
		#get_tree().change_scene_to_file.bind("res://main_ui.tscn").call_deferred()	
		queue_free()
		TransManager.trans_out(trans_path)
	
	
	if Input.is_action_just_pressed("shoot") or Input.is_action_just_pressed("lmb"):
		if anim_ceed2 == 0:
			#anim_ceed2 = 1
			$message.btnwait = false
			$message.text = "ちょっと待ってね"
			#Global_var.mes4[Global_var.lines4] = "ちょっと待ってね"
			await get_tree().create_timer(2.0).timeout
			SoundManager.bgm_stop()
			TransManager.trans_out(trans_path)
	
	pass


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "pic1_in":
		pic1_in.emit()
	if anim_name == "pic1_out":
		pic1_out.emit()	
	if anim_name == "pic5_in":
		pic5_in.emit()	
	if anim_name == "pic5_out":
		pic5_out.emit()	
	if anim_name == "pic2_in":
		pic2_in.emit()	
	if anim_name == "pic2_out":
		pic2_out.emit()
	if anim_name == "pic3_in":
		pic3_in.emit()	
	if anim_name == "pic3_out":
		pic3_out.emit()
	if anim_name == "pic4_in":
		pic4_in.emit()	
	if anim_name == "pic4_out":
		pic4_out.emit()	
	if anim_name == "pic7_out":
		pic7_out.emit()													
	pass # Replace with function body.


func _on_message_chr_time():
	mes.emit()
	pass # Replace with function body.
