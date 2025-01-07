extends Node2D

#var player = preload("res://player.tscn")
var bul = preload("res://script/player/bullet/tonakai_bul.tscn")
#var p = player.instantiate()
var bullet_time = Timer.new()
@export var bullet_lag = 0.1
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(bullet_time)
	bullet_time.one_shot = true	
	#position = p.position - Vector2(20,0)
	$sub_wep_ani.play("tonakai_ani")
	pass # Replace with function body.

func start(pos):

	position = pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("shoot") and Global_var.player_move:
		if position.x > 95 and position.x < 320:
			if bullet_time.is_stopped():
				bullet_time.start(bullet_lag)
				var b = bul.instantiate()
				get_parent().add_child(b)
				b.start(position)
				#b.kakudo()
	
	if position.x < 95 or  position.x > 320 or position.y < 30 or position.y > 370:
		self.modulate.a = 0
	else:
		self.modulate.a = 1			
	pass
