extends Node2D

class_name _tonakai_bul

var speed:float = 400.0
var rotation_speed = 50
var texture:Texture2D

var damage = 10

var angle = -90

var isHoming_h = false

var vec = Vector2.UP
var distance

var sprite = Sprite2D.new()

#var bullet_lag = Timer.new()
var visible_fil = VisibleOnScreenNotifier2D.new()
var range_area = Area2D.new()

static var target:String = "HP"
var target_ene = null

@onready var bul_scene = load("res://script/player/bullet/bullet_scene.tscn")

@export var bullet_border = -185

func _ready():
	target = "HP"
	
	pass

		
func _process(delta:float):
	if isHoming_h:
		for child in $"../../".get_children():
			if target in child:
				angle = rad_to_deg(atan2(child.global_position.y - position.y,child.global_position.x - position.x))
				break
			else:		
				for grand in child.get_children():
					if target in grand:
						angle = rad_to_deg(atan2(grand.global_position.y - position.y,grand.global_position.x - position.x))
						break		
					
				
				
	position.x += cos(deg_to_rad(angle)) * speed * delta			
	position.y += sin(deg_to_rad(angle)) * speed * delta
	
	#position += vec * speed * delta
	
	
	if position.y < Global_var.field_y or position.y > Global_var.field_ly or position.x < Global_var.field_x or position.x > Global_var.field_lx:
		queue_free()	
	

	if position.x < 95 or  position.x > 320 or position.y < 30 or position.y > 370:
		self.modulate.a = 0
	else:
		self.modulate.a = 1		

	pass
	
func kakudo():
	for child in $"../../".get_children():
		if "HP" in child:
			angle = rad_to_deg(atan2(child.position.y - position.y,child.position.x - position.x))	
			break
	
func _on_body_exited(body:Node):
	print("d")
	queue_free()
	#self.visible = false
	pass		
			

func _on_screen_exited():
	queue_free()
	

func start(pos):
	position = pos	
	homing()
	#if get_tree().get_first_node_in_group("enemy") or get_tree().get_first_node_in_group("boss"):
		#distance = get_tree().get_first_node_in_group("enemy").global_position.distance_to(global_position)
		#vec = (get_tree().get_first_node_in_group("enemy").position - position).normalized()
		#if distance <= 250:
			#pass
		#else:
			#vec = Vector2.UP	
	

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

func find_target():
	var enemys = get_tree().get_nodes_in_group("enemy")
	if enemys.size() > 0:
		var nearest_enemy = null
		var min_distance = INF
		for enemy in enemys:
			if not enemy.is_inside_tree():
				continue
			var distance = global_position.distance_to(enemy.global_position)
			if distance < min_distance:
				min_distance = distance
				nearest_enemy = enemy
		target_ene = nearest_enemy	
		#target_ene = enemys.min_by(func(enemy):
			#return global_position.distance_to(enemy.global_position)
			#)
	else:
		target_ene = null
		#position += Vector2.UP * speed * delta
		
func fire_to_target():
	if target_ene:
		var direction = (target_ene.global_position - global_position).normalized()	
		rotation = lerp_angle(rotation,direction.angle(),rotation_speed)
		#position += Vector2.UP.rotated(rotation) * speed * delta
		return direction
	else:
		find_target()
		return Vector2.UP
		
func homing():
	for child in $"../../".get_children():
		if target in child:
			angle = rad_to_deg(atan2(child.global_position.y - position.y,child.global_position.x - position.x))
		else:		
			for grand in child.get_children():
				if target in grand:
					angle = rad_to_deg(atan2(grand.global_position.y - position.y,grand.global_position.x - position.x))
		
			
		
