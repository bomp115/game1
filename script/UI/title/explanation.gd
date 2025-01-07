extends Control

signal tutorial_start
# Called when the node enters the scene tree for the first time.
func _ready():
	$setumei/item/ColorRect.size = Vector2(2,106)
	$setumei/item/ColorRect.position = Vector2(473,281)
	$setumei/item/AnimatedSprite2D.play("def")
	$setumei/item/AnimatedSprite2D2.play("def")
	$setumei/item/AnimatedSprite2D3.play("def")
	$setumei/item/AnimatedSprite2D4.play("def")
	$setumei/item/AnimatedSprite2D5.play("def")
	$setumei/item/AnimatedSprite2D6.play("def")
	$image_model.play("def")
	$AnimationPlayer.play("sleep_icon")
	$AnimationPlayer2.play("back_label_modulate")
	var current_locale : String = TranslationServer.get_locale()
	#TranslationServer.set_locale("en")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		SoundManager.se_play("reject")
		self.visible = false
		Global_var.tutorial = false
		Global_var.player_move = false
		$"../".process = true
		$"../".dec_count = 2
		set_process(false)
		#$"../".process_mode = Node.PROCESS_MODE_PAUSABLE
	
	pass


func _on_tutorial_start():
	await get_tree().create_timer(0.1).timeout
	set_process(true)
	Global_var.tutorial = true
	Global_var.player_move = true
	
	pass # Replace with function body.
