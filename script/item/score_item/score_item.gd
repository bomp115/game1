extends Area2D

var dir = -2
var dirtarget = 1
var angle
var speed = 50
var close_speed = 10

var player = _player.new()
var vec = Vector2.ZERO

var item_close = false

# Called when the node enters the scene tree for the first time.
func _ready():
	angle = randi_range(20,150)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.x > Global_var.field_lx or position.x < Global_var.field_x or position.y > Global_var.field_ly:
		queue_free()
	if position.y < Global_var.field_y:
		self.modulate.a = 0
	else:
		self.modulate.a = 1		
	
	if dirtarget == 1:
		dir += 3.0 * delta
	
	if !item_close:	
		position.x += cos(deg_to_rad(angle)) * speed * delta	
		position.y += dir * sin(deg_to_rad(angle)) * speed * delta
	else:
		if get_tree().get_first_node_in_group("player"):
			vec = get_tree().get_first_node_in_group("player").position - position
		position += vec * close_speed * delta	
		
	pass


func _on_item_close_area_entered(area):
	if area.is_in_group("player"):
		item_close = true
	pass # Replace with function body.


func _on_area_entered(area):
	if area.is_in_group("player"):
		Global_var.score += 1000
		SoundManager.se_play("power1")
		queue_free()
	pass # Replace with function body.


func _on_water_area_entered(area):
	if area.is_in_group("player"):
		Global_var.score += 100
		SoundManager.se_play("power1")
		queue_free()
	pass # Replace with function body.


func _on_ice_area_entered(area):
	if area.is_in_group("player"):
		Global_var.score += 500
		SoundManager.se_play("power1")
		queue_free()
	pass # Replace with function body.


func _on_curry_area_entered(area):
	if area.is_in_group("player"):
		Global_var.score += 600
		SoundManager.se_play("power1")
		queue_free()
	pass # Replace with function body.


func _on_takoyaki_area_entered(area):
	if area.is_in_group("player"):
		Global_var.score += 800
		SoundManager.se_play("power1")
		queue_free()
	pass # Replace with function body.
