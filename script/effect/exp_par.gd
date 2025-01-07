extends Node2D

@onready var exp = $explosion
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start(pos):
	position = pos
	
func ani_num(num1:bool,num2:bool):
	if 	num1:
		$explosion.play("exp1")
	elif num2:
		$explosion.play("exp2")

		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_explosion_animation_finished():
	
	#print("o")
	queue_free()
	pass # Replace with function body.
