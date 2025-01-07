extends Node

#func save():
	#print("saved_game")
	#var save_scene = self
	#var scene = PackedScene.new()
	#scene.pack(save_scene)
	#ResourceSaver.save(scene,"res://save_file/savedgame.tscn")
	#pass
var save_data = {
	player_position = Global_var.player_pos,
	life = Global_var.life,
	score = Global_var.score,
	tscn = ""
}	

func change_scene(path):
	get_tree().change_scene_to_file(path)	

func save_game():
	var save_data = {
		player_position = Global_var.player_pos,
		life = Global_var.life,
		score = Global_var.score,
		tscn = ""
	}
	var file = FileAccess.open("user://save_game.json",FileAccess.WRITE)
	if file:
		save_data.tscn = get_tree().current_scene.name
		var json_data = JSON.stringify(save_data)
		file.store_string(json_data)
		file.store_var(save_data)
		file.close()
	else:
		print("failed to open save file")
		#FileAccess.store_string(to_json(save_data))
		
func load_game():
	var file = FileAccess.open("user://save_game.json",FileAccess.READ)
	if file:
		var file_size = file.get_length()
		var buffer = file.get_buffer(file_size)
		#var json_data = file.get_var()
		var json_data = buffer.get_string_from_utf8()
		#var save_data = JSON.parse_string(json_data).result
		var result = JSON.parse_string(json_data)
		if result.error == OK:
			var save_data = result.result
			file.close()
			return save_data
		else:
			print("Failed to parse save data.")
			file.close()
			return {}	
		#save_data = file.get_var()
		#change_scene("res://main_ui.tscn")
		#print(save_data)
		#queue_free()
		#file.close()
		#return save_data		
	else:
		print("no save file found")
		return {}	
		
func apply_savedata(save_data:Dictionary):
	if save_data.size() > 0:
		var player = get_tree().get_nodes_in_group("player")
		for p in player:
			p.position = save_data["player_position"]
		Global_var.life = save_data["life"]
		Global_var.score = save_data["score"]			
