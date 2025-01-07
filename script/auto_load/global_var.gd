extends Node

var bullet_rect:Rect2
var bullet_pos_y:float
var bullet:Node2D
var bullet_texture:Texture2D

var collision_bullet:Area2D

var approach_num:int = 0

var bgm_vol = 1
var se_vol = 5

var player_pos

var life = 3

var tscn:String

var score:int = 0
var level:int

var field_y = 40
var field_ly = 380

var field_x = 100
var field_lx = 320

var bul_type1 = false
var bul_type_def = true

var player_move = true

var tutorial = false 

var playing = false

var difficulty = 1

var continue_num = 0

var barrier_num = 0

var bomb_num = 3

var ene_apptime = 50

var shoottime_lag = 20

var language = "ja"

var res : Result = null

var player = _player.new()
var translation_setting = _translation_setting.new()

var save_test = {
	test1 = 0,
	test2 = 0,
	test3 = 0
}

		

func _free():
	var bosses = get_tree().get_nodes_in_group("boss")
	for boss in bosses:
		boss.queue_free()
	var ene_shots = get_tree().get_nodes_in_group("ene_shot")
	for ene_shot in ene_shots:
		ene_shot.queue_free()
	var enemys = get_tree().get_nodes_in_group("enemy")
	for enemy in enemys:
		enemy.queue_free()
			
		
func lexp(a,b,c):
	return a + (b - a) * (1.0 - exp(-c))
	
func other_node(group:String):
	var nodes = get_tree().get_nodes_in_group(group)			
	if nodes == null:
		return null	
	for node in nodes:
		return node
		
func other_first_node(group:String):
	var nodes = get_tree().get_first_node_in_group(group)			
	if nodes == null:
		return null	
	return nodes		

var mode = false

var lines = 0
var label:String

var lines2 = 0
var lines3 = 0
#var lines4 = 0

var mes
var mes2
var mes3
var scene = 1

func _ready():
	if scene == 1:
		if language == "en":
			mes = ["Today is Christmas.",
			"?@There was one girl who worked to protect this holy night.",
			"?@Dear Mary! Oh my God!",
			"?@The order for secondment has been issued through the association.",
			"~@What? There's still plenty of time before Christmas.",
			"??@Vampires? I don't have a choice. Let's go!",
			"~@Yes, sir! Master!","?@"

			]
			
			mes2 = ["I found you. You're the one who started this whole thing.",
			"",
			"Well, I'm sure they're just like you",
			"#@Today is Christmas. It's the day we are recognized for what we stand for.",
			"You're also in the wrong place at the wrong time to bring trouble to the table like that.",
			"",
			"",
			"#@We are similar to you only in origin. \nIt's not us who are making assumptions, it's the people on the street.",
			"",
			"#@So, what are you going to do?\n If you back out here, I'll let you off the hook for today.",
			"",
			"#@I'm not going to listen to you. I can't help it. \nI need you to be quiet for the rest of the day. Let's go!",
			"~~~@",
			"~~~@",
			#"まだやるの？\nこれ以上はあんたを始末しなきゃなんないんだけど？",
			"",
			""

				
			]

			mes3 = ["",
				"That outfit...are you impersonating Santa Claus? \nCostume play?",
			"",
			"",
			"",
			"#@Christmas is the birthday of Christ, right?",
			"You're just making it your day at Santa's discretion.",
			"",
			"#@Well, I don't need you to lecture me on such obvious things!",
			"",
			"#@Hmmm...a unfinished business!\n I'm going to beat you and paint it Christmas Us Vampires Day!",
			"",
			"",
			"",
			"",
				
			]
		else:
			mes = ["今日はクリスマス",
			"?@この聖夜を守るために活動する少女が一人いた。",
			"?@メリー様！大変です！",
			"?@協会を通じて出向命令が出ております。",
			"~@なによ。まだクリスマスまで時間たっぷりだってのに",
			"??@吸血鬼？仕方ないわねえ。いくわよ！",
			"~@はい！ご主人様！","?@"

			]
				
			mes2 = ["みつけたわよ、あなたがこの怪異の発端ね。",
			"",
			"そうね、あなたと同じ類いの存在と思ってもらって問題ないわ",
			"#@今日はクリスマス。つまり私たちがその象徴として存在を認知される日よ。",
			"そんなタイミングで厄介事を持ち込んできたあなたも間が悪いわね",
			"",
			"",
			"#@出自だけでいえばあなたと似たような存在よ\n勝手に決めつけてるのはあたしたちじゃなく市井の人間たち",
			"",
			"#@それで、どうするの？\nここで身を引くなら今日に限っては見逃してあげるけど？",
			"",
			"#@聞く耳なし、か。しょうがないわね\n今日一日はおとなしくしてもらわなきゃ困るの。\nいくわよ！",
			"~~~@",
			"~~~@",
			#"まだやるの？\nこれ以上はあんたを始末しなきゃなんないんだけど？",
			"",
			""

				
			]

			mes3 = ["",
				"その恰好・・あなた、サンタの真似事でもしてるの？\nコスプレ？",
			"",
			"",
			"",
			"#@クリスマスって、キリストの誕生日でしょ？",
			"あんたたちサンタの一存で勝手に自分達の日って決めつけてるだけじゃない",
			"",
			"#@そ、そんな当たり前を講釈されなくたって分かるわよ！",
			"",
			"#@ふん、行き掛けの駄賃よ！\nあんたを倒してクリスマスのあたしたち吸血鬼の日に塗り替えてあげるわ！",
			"",
			"",
			"",
			"",
				
			]

#var mes2 = ["みつけたわよ、あなたがこの怪異の発端ね。",
#"",
#"そうね、あなたと同じ類いの存在と思ってもらって問題ないわ",
#"#@今日はクリスマス。つまり私たちがその象徴として存在を認知される日よ。",
#"そんなタイミングで厄介事を持ち込んできたあなたも間が悪いわね",
#"",
#"",
#"#@出自だけでいえばあなたと似たような存在よ\n勝手に決めつけてるのはあたしたちじゃなく市井の人間たち",
#"",
#"#@それで、どうするの？\nここで身を引くなら今日に限っては見逃してあげるけど？",
#"",
#"#@聞く耳なし、か。しょうがないわね\n今日一日はおとなしくしてもらわなきゃ困るの。\nいくわよ！",
#"~~~@",
#"~~~@",
##"まだやるの？\nこれ以上はあんたを始末しなきゃなんないんだけど？",
#"",
#""
#
	#
#]
#
#var mes3 = ["",
	#"その恰好・・あなた、サンタの真似事でもしてるの？\nコスプレ？",
#"",
#"",
#"",
#"#@クリスマスって、キリストの誕生日でしょ？",
#"あんたたちサンタの一存で勝手に自分達の日って決めつけてるだけじゃない",
#"",
#"#@そ、そんな当たり前を講釈されなくたって分かるわよ！",
#"",
#"#@ふん、行き掛けの駄賃よ！\nあんたを倒してクリスマスのあたしたち吸血鬼の日に塗り替えてあげるわ！",
#"",
#"",
#"",
#"",
	#
#]

#var mes4 = [""
#]
