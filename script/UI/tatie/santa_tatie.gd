extends Node2D

signal santa_tatie_fin
signal santa_tatie_start

var boss1_stage_on = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _in():
	$AnimationPlayer.play("trans_santa_in")
	
func _out():
	$AnimationPlayer.play("trans_santa_out")
	
func ang1():
	$AnimatedSprite2D.play("santa_tatie_ang1")
func ang2():
	$AnimatedSprite2D.play("santa_tatie_ang2")
func com():
	$AnimatedSprite2D.play("santa_tatie_com")
func confuse():
	$AnimatedSprite2D.play("santa_tatie_confuse1")
func silent():
	$AnimatedSprite2D.play("santa_tatie_silent")
func sup():
	$AnimatedSprite2D.play("santa_tatie_sup")							

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "trans_santa_out":
		santa_tatie_fin.emit()
		await get_tree().create_timer(1.0).timeout
		boss1_stage_on = true
	if anim_name == "trans_santa_in":
		santa_tatie_start.emit()	
	pass # Replace with function body.
