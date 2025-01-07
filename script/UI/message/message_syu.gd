extends RichTextLabel

signal chr_time
signal mes_end
signal ending_mes
signal face

var count = 0
var btnwait = false

var wait_scene = false

var index = 0

@onready var timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().add_child(timer)
	timer.one_shot = true
	timer.start(50)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	
	if Global_var.mode == false:
		visible_characters = count
		if get_total_character_count() <= count:
			chr_time.emit()
			count = get_total_character_count()
			if (Input.is_action_just_pressed("lmb") or Input.is_action_just_pressed("shoot")) and wait_scene == false:
				if btnwait == true:
					#var regex := RegEx.new()		#正規表現を使用するためのオブジェクト
					#regex.compile("[▼]")			#正規表現を使って「▼」を割り当てる
					#text = regex.sub(text, "\n")	#見つかったら「▼」を改行コードに置き換える		
					Global_var.lines2 += 1
					btnwait = false
					print(Global_var.lines2)
					print("+")				
					
			elif Global_var.lines2 < Global_var.mes2.size() && btnwait == false:
				var order = Global_var.mes2[Global_var.lines2].split("@",true,0)
				match order[0]:
					"#":
						text = ""
						count = 0
						text += order[1]
						wait_scene = false
						btnwait = true
						face.emit()
						#Global_var.lines2 += 1
					"/":
						Global_var.mode = true #シーン移動時にfalseにする。
						Global_var.label = order[1] #/@から次の文字列をlabelに格納
						face.emit()
					".":
						Global_var.lines2 = Global_var.mes2.find("/@" + order[1])
						count = get_total_character_count()
						Global_var.mode = false
						face.emit()
					"?":
						btnwait = true
						await get_tree().create_timer(4.0).timeout
						text = ""
						count = 0
						await get_tree().create_timer(1.0).timeout						
						text += order[1]
						#text += "。"
						Global_var.lines2 += 1
						btnwait = false		
						face.emit()							
						#timer.start(10.0)
					"??":
						btnwait = true
						await get_tree().create_timer(1.0).timeout
						text = ""
						count = 0
						await get_tree().create_timer(1.0).timeout						
						text += order[1]
						#text += "。"
						Global_var.lines2 += 1
						btnwait = false	
						face.emit()								
						#timer.start(10.0)						
					"~":
						var mes_vam = get_tree().get_nodes_in_group("mes_vam")
						for mesvam in mes_vam:
							mesvam.wait_scene = false
						#wait_scene = true	
						#text += "\n"
						text += order[1]
						btnwait = true
						face.emit()
						#text += "。"								
						#timer.start(10.0)	
					"~~":
						var mes_vam = get_tree().get_nodes_in_group("mes_vam")
						for mesvam in mes_vam:
							mesvam.wait_scene = true
						#wait_scene = false	
						#text += "\n"
						text += order[1]
						btnwait = true
						face.emit()													
						#text += "[wave amp=25 freq=25]▼[/wave]"
					"~~~":
						mes_end.emit()
						btnwait = true
						
					"~~~~":
						ending_mes.emit()
						btnwait = true
						wait_scene = true	
							
					_:												
						text += order[0]
						#text += "[wave amp=25 freq=25]▼[/wave]"
						#text += "。"
						wait_scene = false
						btnwait = true	
						face.emit()		
					
		else:
			count += 0.5	#テキストの速さ
			if Input.is_action_just_pressed("lmb") or Input.is_action_just_pressed("shoot"):
				count = get_total_character_count()
				wait_scene = true
				if btnwait == true:
					Global_var.lines2 += 1
					btnwait = false
					print("++")
				#wait_scene = true
	pass

func start():
	visible = true
	process_mode = Node.PROCESS_MODE_INHERIT
	text = ""
	count = 0
	
func label_jump(lab):
	Global_var.lines = Global_var.mes.find("/@" + lab)	
	count = get_total_character_count()
	Global_var.mode = 0

func mes_out():
	#print(get_parent().get_child_count())
	$"../AnimationPlayer".play("dither_out")
	#$"../AnimationPlayer".play("mes_out")
	get_parent().remove_child(self)
	#text = ""
	##wait_scene = true
	#Global_var.mode = true
	#count = 0
	#self.visible = false
	#get_parent().remove_child($"../AnimationPlayer")
	
func mes_win_in():
	$"../".material.set_shader_parameter("intensity",0)
	self.material.set_shader_parameter("intensity",0)
	#get_parent().add_child(self)	
	
		

#func _on_chr_time_timeout():
	#Global_var.lines += 1
	#if Global_var.lines < Global_var.mes.size():
		#text += Global_var.mes[Global_var.lines][index]
		#index += 1
		#$chr_time.start(10.0)
	pass # Replace with function body.


func _on_face():
	var taties = get_tree().get_nodes_in_group("santa_tatie")
	for tatie in taties:
		if Global_var.scene == 1:	
			if Global_var.lines2 == 0:
				tatie.ang1()
			elif Global_var.lines2 == 1:
				tatie.silent()
			elif Global_var.lines2 == 2:
				tatie.com()
			elif Global_var.lines2 == 5:
				tatie.silent()
			elif Global_var.lines2 == 7:
				tatie.com()
			elif Global_var.lines2 == 8:
				tatie.silent()
			elif Global_var.lines2 == 9:
				tatie.com()
			elif Global_var.lines2 == 10:
				tatie.silent()
			elif Global_var.lines2 == 11:
				tatie.com()
		elif Global_var.scene == 2:
			if Global_var.lines2 == 0:
				tatie.silent()
			elif Global_var.lines2 == 1:
				tatie.ang1()
			elif Global_var.lines2 == 2:
				tatie.com()
			elif Global_var.lines2 == 3:
				tatie.silent()
			elif Global_var.lines2 == 4:
				tatie.com()
			elif Global_var.lines2 == 5:
				tatie.silent()
			elif Global_var.lines2 == 6:
				tatie.com()
			elif Global_var.lines2 == 7:
				tatie.silent()
			elif Global_var.lines2 == 7:
				tatie.confuse()
			elif Global_var.lines2 == 8:
				tatie.silent()											
	pass # Replace with function body.
