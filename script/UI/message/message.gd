extends RichTextLabel

signal chr_time

var count = 0
var btnwait = false

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
			if Input.is_action_just_pressed("lmb") and btnwait == true:
				#var regex := RegEx.new()		#正規表現を使用するためのオブジェクト
				#regex.compile("[▼]")			#正規表現を使って「▼」を割り当てる
				#text = regex.sub(text, "\n")	#見つかったら「▼」を改行コードに置き換える		
				btnwait = false
				print(Global_var.lines)			
					
			if Global_var.lines < Global_var.mes.size() && btnwait == false:
				var order = Global_var.mes[Global_var.lines].split("@",true,0)
				#var order_skip = Global_var.mes4[Global_var.lines4].split("@")
				match order[0]:
					"#":
						text = ""
						count = 0
						Global_var.lines += 1
					"/":
						Global_var.mode = true #シーン移動時にfalseにする。
						Global_var.label = order[1] #/@から次の文字列をlabelに格納
					".":
						Global_var.lines = Global_var.mes.find("/@" + order[1])
						count = get_total_character_count()
						Global_var.mode = false
					"?":
						btnwait = true
						await get_tree().create_timer(4.0).timeout
						text = ""
						count = 0
						await get_tree().create_timer(1.0).timeout						
						text += order[1]
						#text += "。"
						Global_var.lines += 1
						btnwait = false									
						#timer.start(10.0)
					"??":
						btnwait = true
						await get_tree().create_timer(1.0).timeout
						text = ""
						count = 0
						await get_tree().create_timer(1.0).timeout						
						text += order[1]
						#text += "。"
						Global_var.lines += 1
						btnwait = false									
						#timer.start(10.0)						
					"~":
						btnwait = true
						await get_tree().create_timer(1.0).timeout
						text += "\n"
						text += order[1]
						#text += "。"
						Global_var.lines += 1
						btnwait = false									
						#timer.start(10.0)							
					_:												
						text += order[0]
						#text += "[wave amp=25 freq=25]▼[/wave]"
						#text += "。"
						Global_var.lines += 1
						btnwait = false	
				#match order_skip[0]:
					#_:
						#text += order_skip[0]		
					
		else:
			if TranslationServer.get_language_name("en"):count += 0.2
			else:count += 0.1	#テキストの速さ
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


#func _on_chr_time_timeout():
	#Global_var.lines += 1
	#if Global_var.lines < Global_var.mes.size():
		#text += Global_var.mes[Global_var.lines][index]
		#index += 1
		#$chr_time.start(10.0)
	pass # Replace with function body.
