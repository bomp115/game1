extends AnimatedSprite2D

var head

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	if area.is_in_group("shot"):
		if head:
			$"../../".HP -= area.damage
			#var mukades = get_tree().get_nodes_in_group("mukade_whole")
			#var mukades = get_tree().get_nodes_in_group("mukade" + str(mukade_num))
			#var stage1s = get_tree().get_nodes_in_group("main")
			#for stage1 in stage1s:
				#var mukade_num = stage1.mukade_num
				#print(mukade_num,"mukade")
				#var mukades = get_tree().get_nodes_in_group("mukade" + str(mukade_num))
				#for mukade in mukades:
			$"../../".damaging = true	
			if $"../../".HP < 0:
				$"../../".HP = 0
				#for mukade in mukades:
				$"../../".hit()
			area.queue_free()
		else:
			print(head)
			print("reflect")	
			if "angle" in area:
				area.angle = randf_range(10,170)
			elif "reflect" in area:
				area.reflect = true
				area.ang = randf_range(10,170)
	pass # Replace with function body.
