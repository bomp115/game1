extends Node2D

var speed:float = 400.0
var texture:Texture2D

var damage = 50
var angle = 270

var sprite = Sprite2D.new()

#var bullet_lag = Timer.new()
var visible_fil = VisibleOnScreenNotifier2D.new()
var range_area = Area2D.new()


@onready var bul_scene = load("res://script/player/bullet/bullet_scene.tscn")

@export var bullet_border = -185

func _ready():
	add_to_group("bullets")
	#self.area_entered.connect(Callable(self,"_on_area_entered"))
	if texture:
		sprite.texture = texture
		add_child(sprite)
		
		#var a = get_tree().get_root()
		#a.add_child(range_area)
		#print(a)
		
		var colorrect = ColorRect.new()
		sprite.add_child(colorrect)
		colorrect.size = Vector2(100,100)
		colorrect = Color(50,50,50)
		
		var collision_shape = CollisionShape2D.new()
		var shape = RectangleShape2D.new()
		shape.size = Vector2(100,300)
		collision_shape.shape = shape
		range_area.add_child(collision_shape)
		
		visible_fil.scale = Vector2(100,300)
		visible_fil.position = Vector2(200,200)
		
		add_child(range_area)


	#var bul = bul_scene.instantiate()
	#add_child(bul)
		#range_area.body_exited.connect(Callable(self,"_on_body_exited"))
		#visible_fil.screen_exited.connect(Callable(self,"_on_screen_exited"))
		
func _process(delta:float):
	if !Global_var.tutorial:
		if position.y < 40 or position.y > 380 or position.x < 100 or position.x > 320:
			queue_free()	
			pass
	else:
		if position.y < 60 or position.y > 235 or position.x < 55 or position.x > 250:
			queue_free()		
	#if is_in_group(&"bullet_col"):
		#print("l")	
	#position += Vector2.UP * speed * delta
	position.x += cos(deg_to_rad(angle)) * speed * delta
	position.y += sin(deg_to_rad(angle)) * speed * delta
	#bullet_lag.start(bullet_time)

	pass
	
func _on_body_exited(body:Node):
	print("d")
	queue_free()
	#self.visible = false
	pass		
			

func _on_screen_exited():
	queue_free()
	

func start(pos):
	position = pos

func _on_area_entered(area):
	#if area.is_in_group(&"bullet_col"):
		#print("m")
		#queue_free()
	if area.is_in_group("enemy1"):
		area.hit()
		queue_free()
	elif area.is_in_group("enemy2"):
		area.hit()
		queue_free()
	elif area.is_in_group("enemy3"):
		area.hit()
		queue_free()			
	elif area.is_in_group("enemy4"):
		area.hit()
		queue_free()	
	elif area.is_in_group("enemy"):
		area.hit()
		SoundManager.se_play("beat1")
		queue_free()

#↓他のシーンのノードのシグナル（グループ）を現在のノードのシグナルで発火させる。
#func _on_area_exited(area):
	#if area.is_in_group(&"bullet_col"):
		#print("k")
		#queue_free()
	#pass # Replace with function body.
