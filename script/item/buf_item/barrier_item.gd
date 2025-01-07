extends Area2D


var vec = Vector2.DOWN
var speed = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start(pos):
	position = pos
	$AnimatedSprite2D.play("barrier_ani")
	vec = vec.normalized()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += vec * speed * delta
	if position.y > Global_var.field_ly:
		queue_free()
	pass
