extends Node

func save_data():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent": get_parent().get_path(),
		"lines1": Global_var.lines,
		"lines2":Global_var.lines2,
		"lines3":Global_var.lines3,
		"life":Global_var.life,
		"score":Global_var.score,
		"approach":Global_var.approach_num
	}

	#Global_var.lines = save_dict.lines1
	#Global_var.lines2 = save_dict.lines2
	#Global_var.lines3 = save_dict.lines3
	#Global_var.life = save_dict.life
	#Global_var.score = save_dict.score
	#Global_var.approach_num = save_dict.approach_num
		
	return save_dict

#----------------------------------------------

#func save():
	#print("saved_game")
	#var save_scene = self
	#var scene = PackedScene.new()
	#scene.pack(save_scene)
	#ResourceSaver.save(scene,"res://save_file/savedgame.tscn")
	#pass
	#
#func load_game():
	#print("load")
	#var new_scene = ResourceLoader.load("res://save_file/save_game.tscn")
	#get_tree().get_root().add_child(new_scene)
	#self.queue_free()	

#--------------------------------------------------------------
	
#func save(num:int):
	#var file = FileAccess.open_encrypted_with_pass("user://save_game" + str(num) + ".data",FileAccess.WRITE,"stg_angou")
	#if file.file_exists("user://save_game" + str(num) + ".data"):
		#print("save")
		#Global_var.tscn = get_tree().current_scene.name
		#await RenderingServer.frame_post_draw
		#file.store_var(Global_var.life)
		#file.store_var(Global_var.score)
		#file.store_var(Global_var.approach_num)
		#file.store_var(Global_var.save_test)
		#file.store_var(Global_var.mes2)
		#file.store_var(Global_var.mes3)
		#file.store_var(Global_var.lines)
		#file.store_var(Global_var.lines2)
		#file.store_var(Global_var.lines3)
		#file.close()
	#else:
		#print("not_save_data")	
	#pass	
	#
#func load_game(num:int):
	#var file = FileAccess.open_encrypted_with_pass("user://save_game" + str(num) + ".data",FileAccess.READ,"stg_angou")
	#if file != null && file.file_exists("user://save_game" + str(num) + ".data"):
		#print("load")
		#Global_var.life = file.get_var(Global_var.life)
		#Global_var.score = file.get_var(Global_var.score)
		#Global_var.approach_num = file.get_var(Global_var.approach_num)
		##Global_var.lines2 = file.get_var(Global_var.lines2)
		##Global_var.lines3 = file.get_var(Global_var.lines3)
		##Global_var.mes2 = file.get_var(Global_var.mes2)
		##Global_var.mes3 = file.get_var(Global_var.mes3)
		#Global_var.save_test = file.get_var()
		##print(Global_var.save_test)
		#file.close()
	#else:
		#print("not_load_data")	
		
#----------------------------------------------------
		
#func save(num:int):
	#var file = FileAccess.open("user://save_game" + str(num) + ".save",FileAccess.WRITE)
	#if file.file_exists("user://save_game" + str(num) + ".save"):
		##var save_node = get_tree().get_nodes_in_group("persist")
		#print("save")
		##for node in save_node:
			##if node.scene_file_path.is_empty():
				##print("persistent node '%s' is not an instanced scene, skipped" % node.name)
				##continue
##
			### Check the node has a save function.
			##if !node.has_method("save_data"):
				##print("persistent node '%s' is missing a save() function, skipped" % node.name)
				##continue			
		#var node_data = call("save_data")
		#var json_string = JSON.stringify(node_data)
		#file.store_line(json_string)
	#else:
		#print("not_save_data")	
	#pass	
	#
#func load_game(num:int):
	#var file = FileAccess.open("user://save_game" + str(num) + ".save",FileAccess.READ)
	#if file != null && file.file_exists("user://save_game" + str(num) + ".save"):
		#print("load")
		##var save_node = get_tree().get_nodes_in_group("persist")
		##print("load2")
		##for i in save_node:
			##i.queue_free()
		#while file.get_position() < file.get_length():	
			#var json_string = file.get_line()
			#var json = JSON.new()
			#var parse_result = json.parse(json_string)
			#if not parse_result == OK:
				#print("error",json.get_error_message(),"in",json_string,"at_line",json.get_error_line())
				#continue
			#var node_data = json.data
			##file.get_line()
			#
			##var new_object = load(node_data["filename"]).instantiate()
			#Global_var.life = node_data["life"]
			#Global_var.score = node_data["score"]
			#Global_var.approach_num = node_data["approach"]
			##get_node(node_data["parent"]).add_child(new_object)
			##for i in node_data.keys():
				##if i == "filename" or i == "parent":
					##continue
				##new_object.set(i,node_data[i])		
	#else:
		#print("not_load_data")		
		#
#-------------------------------------------------------

func save(num:int):
	var file = FileAccess.open("user://save_game" + str(num) + ".save",FileAccess.WRITE)
	if file.file_exists("user://save_game" + str(num) + ".save"):
		print("save")
		var save_data = {}
		#save_data.scene = get_parent().get_path()
		save_data.score = Global_var.score
		save_data.life = Global_var.life
		save_data.approach_num = Global_var.approach_num
		#save_data.lines1 = Global_var.lines
		save_data.lines2 = Global_var.lines2
		save_data.lines3 = Global_var.lines3
		
		save_data.mes2 = Global_var.mes2
		save_data.mes3 = Global_var.mes3
		save_data.bomb_num = Global_var.bomb_num
		#var players = get_tree().get_nodes_in_group("player")
		#for player in players:
			#save_data.pos_x = player.position.x
			
		
		var save = JSON.stringify(save_data)
		
		file.store_string(save)
		file.close()
	else:
		print("not_save_data")	
	pass	
	
func load_game(num:int):
	var file = FileAccess.open("user://save_game" + str(num) + ".save",FileAccess.READ)
	if file != null && file.file_exists("user://save_game" + str(num) + ".save"):
		print("load")
		var d = file.get_as_text()
		var data = str_to_var(d)
		#var json_conv = JSON.new()
		#json_conv.parse(d)
		#var parse = json_conv.get_data()
		#var data = parse.result
		
		#while file.get_position() < file.get_length():
		#var json_string = file.get_line()
		#var data = JSON.parse_string(json_string)
		#TransManager.transition_to("res://" + str(data.scene) + ".tscn")
		Global_var.score = data["score"]
		Global_var.life = data["life"]
		Global_var.approach_num = data["approach_num"]
		Global_var.lines2 = data.lines2
		Global_var.lines3 = data.lines3
		Global_var.mes2 = data.mes2
		Global_var.mes3 = data.mes3
		Global_var.bomb_num = data.bomb_num
		
		file.close()
	else:
		print("not_load_data")		
