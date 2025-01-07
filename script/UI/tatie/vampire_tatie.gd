extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _in():
	$AnimationPlayer.play("trans_vam_in")
func _out():
	$AnimationPlayer.play("trans_vam_out")	
func ang1():
	$AnimatedSprite2D.play("vampire_ang1")
func ang2():
	$AnimatedSprite2D.play("vampire_ang2")
func com():
	$AnimatedSprite2D.play("vampire_com")
func def():
	$AnimatedSprite2D.play("vampire_def")
func smile():
	$AnimatedSprite2D.play("vampire_smile")					

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
