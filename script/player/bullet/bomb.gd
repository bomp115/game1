extends Area2D

var vec = Vector2.UP
var speed = 100
var damage = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	beat_enemy()	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !Global_var.tutorial:
		if position.y < 40 or position.y > 380 or position.x < 100 or position.x > 320:
			queue_free()	
			pass
	else:
		if position.y < 60 or position.y > 235 or position.x < 55 or position.x > 250:
			queue_free()
	
	position += vec * speed * delta
	
	pass
	
func beat_enemy():
	var enemys = get_tree().get_nodes_in_group("enemy")
	for enemy in enemys:
		SoundManager.se_play("beat1")
		if "ghost" in enemy:
			for i in enemy.seg_size:
				if !enemy.bodysegment[i].col.disabled:
					enemy.hit(i)
					enemy.explosion(i)
					enemy.remove_child(enemy.bodysegment[i].area)
					enemy.remove_child(enemy.bodysegment[i].col)
					enemy.bodysegment[i].area.set_script(null)
					enemy.queue_free()
		else:
			enemy.hit()			
			
func start(pos):
	position = pos			


func _on_area_entered(area):
	if area.is_in_group("enemy"):
		area.hit()
		SoundManager.se_play("beat1")
		queue_free()
	pass # Replace with function body.
