extends CanvasLayer

@onready var anim = $AnimationPlayer

signal transitioned_in
signal transitioned_out
# Called when the node enters the scene tree for the first time.

func transition_in():
	anim.play("trans_in")
func transition_out():
	anim.play("trans_out")
	
func trans_in():
	anim.play("trans_in")
	await transitioned_in
func trans_out(scene:String):
	get_tree().change_scene_to_file(scene)
	anim.play("trans_out")
	await transitioned_out	
	
func trans_imi_out(scene):
	get_tree().change_scene_to_file(scene)
	anim.play("trans_imi_out")
	await transitioned_out			
	
func transition_to(scene:String):
	transition_in()
	await transitioned_in
	#var new_scene = load(scene).instantiate()
	#var root = get_tree().get_root()
	#root.get_child(root.get_child_count() - 1).free()
	#root.add_child(new_scene)
	get_tree().change_scene_to_file(scene)
	
	transition_out()
	await transitioned_out		

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "trans_in":
		transitioned_in.emit()
	elif anim_name == "trans_out":
		transitioned_out.emit()	
	elif anim_name == "trans_imi_out":
		transitioned_out.emit()		
	pass # Replace with function body.
