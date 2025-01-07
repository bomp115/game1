extends Node2D

@onready var stage1 = $bgm/stage1
@onready var prologue = $bgm/prologue
@onready var boss1 = $bgm/boss1
@onready var barrier1 = $se/barrier1
@onready var beat1 = $se/beat1
@onready var beated1 = $se/beated1
@onready var clear_dis = $se/clear_dis
@onready var con_dis = $se/continue_num_dis
@onready var power1 = $se/power1
@onready var score_dis = $se/score_dis
@onready var shot1 = $se/shot1		
@onready var up1 = $se/up1
@onready var up2 = $se/up2
@onready var decide = $se/decide1
@onready var falling_att = $se/falling_att
@onready var reflect = $se/reflect1
@onready var select1 = $se/select1
@onready var reject = $se/reject
@onready var barrier_off = $se/barrier_off
@onready var approach = $se/approach
@onready var rogo_app = $se/rogo_app
@onready var rogo_imagefall = $se/rogo_imagefall
@onready var rogo_pikon = $se/rogo_pikon


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func bgm_play(name):
	if name == "stage1":
		stage1.play()
	if name == "prologue":
		prologue.play()
	if name == "boss1":
		boss1.play()				
# Called every frame. 'delta' is the elapsed time since the previous frame.

func se_play(name):
	if name == "barrier1":
		barrier1.play()
	if name == "beat1":
		beat1.play()
	if name == "beated1":
		beated1.play()
	if name == "clear_dis":
		clear_dis.play()	
	if name == "con_dis":
		con_dis.play()
	if name == "power1":
		power1.play()
	if name == "score_dis":
		score_dis.play()
	if name == "shot1":
		shot1.play()
	if name == "up1":
		up1.play()
	if name == "up2":
		up2.play()
	if name == "decide1":
		decide.play()
	if name == "falling_att":
		falling_att.play()
	if name == "reflect1":
		reflect.play()	
	if name == "select1":
		select1.play()
	if name == "reject":
		reject.play()
	if name == "barrier_off":
		barrier_off.play()
	if name == "approach":
		approach.play()	
	if name == "rogo_app":
		rogo_app.play()
	if name == "rogo_imagefall":
		rogo_imagefall.play()
	if name == "rogo_pikon":
		rogo_pikon.play()							
										

func bgm_stop():
	stage1.stop()
	prologue.stop()
	boss1.stop()

func _process(delta):
	

	
	pass
