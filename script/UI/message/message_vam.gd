extends RichTextLabel

signal chr_time
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
			if (Input.is_action_just_pressed("lmb") or Input.is_action_just_pressed("shoot")) and btnwait == true and wait_scene == false:
				#var regex := RegEx.new()		#正規表現を使用するためのオブジェクト
				#regex.compile("[▼]")			#正規表現を使って「▼」を割り当てる
				#text = regex.sub(text, "\n")	#見つかったら「▼」を改行コードに置き換える		
				Global_var.lines3 += 1
				btnwait = false
				print(Global_var.lines3)			
					
			elif Global_var.lines3 < Global_var.mes3.size() && btnwait == false:
				var order = Global_var.mes3[Global_var.lines3].split("@",true,0)
				match order[0]:
					"#":
						text = ""
						text += order[1]
						count = 0
						wait_scene = false
						btnwait = true
						face.emit()
						#Global_var.lines3 += 1
					"/":
						Global_var.mode = true #シーン移動時にfalseにする。
						Global_var.label = order[1] #/@から次の文字列をlabelに格納
						face.emit()
					".":
						Global_var.lines3 = Global_var.mes3.find("/@" + order[1])
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
						Global_var.lines3 += 1
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
						Global_var.lines3 += 1
						btnwait = false
						face.emit()									
						#timer.start(10.0)						
					"~":
						var mes_syu = get_tree().get_nodes_in_group("mes_syu")
						for messyu in mes_syu:
							messyu.wait_scene = false
						#wait_scene = true	
						text += order[1]
						btnwait = true
						face.emit()
					"~~":
						var mes_syu = get_tree().get_nodes_in_group("mes_syu")
						for messyu in mes_syu:
							messyu.wait_scene = true
							
						#wait_scene = false	
																		
						text += order[1]					
						btnwait = true	
						face.emit()	
					"~~~~":
						btnwait = true
						wait_scene = true
						face.emit()	
					_:												
						text += order[0]
						#text += "[wave amp=25 freq=25]▼[/wave]"
						#text += "。"
						#Global_var.lines += 1
						wait_scene = false
						btnwait = true	
						face.emit()
					
		else:
			count += 0.5	#テキストの速さ
			if Input.is_action_just_pressed("lmb") or Input.is_action_just_pressed("shoot"):
				count = get_total_character_count()	
				wait_scene = true
				if btnwait == true:
					Global_var.lines3 += 1		
					btnwait = false
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
	$"../AnimationPlayer".play("dither_out")
	#$"../AnimationPlayer".play("mes_out")
	get_parent().remove_child(self)
	#text = ""
	#wait_scene = true
	#text = "くそ・・こんなところで・・"
	#Global_var.mode = true
	#count = 0
	#self.visible = false
	#get_parent().remove_child($"../AnimationPlayer")
	pass
	
func mes_win_in():
	$"../".material.set_shader_parameter("intensity",0)
	self.material.set_shader_parameter("intensity",0)
		
	
		

#func _on_chr_time_timeout():
	#Global_var.lines += 1
	#if Global_var.lines < Global_var.mes.size():
		#text += Global_var.mes[Global_var.lines][index]
		#index += 1
		#$chr_time.start(10.0)
	pass # Replace with function body.


func _on_face():
	var taties = get_tree().get_nodes_in_group("vampire_tatie")
	for tatie in taties:
		if Global_var.scene == 1:
			if Global_var.lines3 == 0:
				tatie.def()
			elif Global_var.lines3 == 1:
				tatie.com()
			elif Global_var.lines3 == 2:
				tatie.def()
			elif Global_var.lines3 == 5:
				tatie.ang1()
			elif Global_var.lines3 == 7:
				tatie.def()
			elif Global_var.lines3 == 8:
				tatie.ang1()
			elif Global_var.lines3 == 9:
				tatie.ang2()
			elif Global_var.lines3 == 10:
				tatie.ang1()	
		if Global_var.scene == 2:
			if Global_var.lines3 == 0:
				tatie.ang1()
			elif Global_var.lines3 == 2:
				tatie.def()
			elif Global_var.lines3 == 3:
				tatie.ang1()
			elif Global_var.lines3 == 4:
				tatie.def()
			elif Global_var.lines3 == 5:
				tatie.ang1()
			elif Global_var.lines3 == 6:
				tatie.def()
			elif Global_var.lines3 == 8:
				tatie.com()								
	pass # Replace with function body.
