extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$VBoxContainer/score.text = "   score\n     " +  str(Global_var.score)
	if Global_var.language == "en":$VBoxContainer/approach.text = "   Approach\n     " + str(Global_var.approach_num)
	else:$VBoxContainer/approach.text = "   接近\n     " + str(Global_var.approach_num) 
	if Global_var.language == "en":$VBoxContainer/continue.text = "　　Continue\n      " + str(Global_var.continue_num) 
	else:$VBoxContainer/continue.text = "コンティニュー\n      " + str(Global_var.continue_num)
	if Global_var.language == "en":$VBoxContainer/bomb_num.text = "　　Bomb\n      " + str(Global_var.bomb_num) 
	else:$VBoxContainer/bomb_num.text = "　　ボム\n      " + str(Global_var.bomb_num)
	pass
