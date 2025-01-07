extends Area2D

var dir = Vector2.ZERO
var angle
var speed = 200

var whole_round = false

func start(pos):
	position = pos
	
	#dir = Vector2(randi_range(Global_var.field_x,Global_var.field_lx),randi_range(Global_var.field_y,Global_var.field_ly))

func hit():
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	if !whole_round:
		angle = randi_range(30,140)
	else:
		angle = randi_range(0,360)	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += cos(deg_to_rad(angle)) * speed * delta
	position.y += sin(deg_to_rad(angle)) * speed * delta
	if Global_var.field_x > position.x or position.x > Global_var.field_lx or Global_var.field_y > position.y or Global_var.field_ly < position.y :
		queue_free()
	pass
		
