extends Area2D

var speed = 50
var vec = Vector2.DOWN

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.x > Global_var.field_lx or position.x < Global_var.field_x or position.y > Global_var.field_ly or position.y < Global_var.field_y:
		queue_free()
		
	position += vec * speed * delta	
	pass
