extends Node2D

var on = false
var off = true

# Called when the node enters the scene tree for the first time.
func _ready():
	crt_off()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func crt_on():
	$ColorRect.use_parent_material = false
	pass
	
func crt_off():
	$ColorRect.use_parent_material = true
	pass	
