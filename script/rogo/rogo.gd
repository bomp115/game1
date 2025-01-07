extends Node2D

@onready var ani = $AnimatedSprite2D

var end = false

var trans_path = "res://script/UI/title/title.tscn"
signal wait
signal ani_end
# Called when the node enters the scene tree for the first time.
func _ready():
	if !end:
		ani_end.connect(_ani_end)
		
		SoundManager.se_play("rogo_app")
		ani.play("rogo1")
		await wait
		await get_tree().create_timer(1.2).timeout
		ani.play("rogo2")
		SoundManager.se_play("rogo_imagefall")
		await get_tree().create_timer(0.7).timeout
		SoundManager.se_play("rogo_imagefall")	
		await wait
		await get_tree().create_timer(1.0).timeout
		ani.play("rogo3")
		#await get_tree().create_timer(1.0).timeout
		await wait
		SoundManager.se_play("rogo_pikon")
		await get_tree().create_timer(2.0).timeout
		end = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if end:
		ani.modulate.a -= 0.05
		if ani.modulate.a <= 0:
			ani.modulate.a = 0
			ani_end.emit()
	
	if Input.is_action_just_pressed("shoot") or Input.is_action_just_pressed("lmb"):
		end = true	
	pass


func _on_animated_sprite_2d_animation_finished():
	wait.emit()
	pass # Replace with function body.
	
func _ani_end():
	TransManager.transition_to(trans_path)
	pass
		
