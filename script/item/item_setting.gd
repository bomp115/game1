extends Node
class_name _item_setting

func app_multi(enemy,body,parent):
	randomize()
	var app_item:int = randf_range(1,50)
	var app_item_heart = randi_range(1,300)
	if app_item == 1:
		var tonakai = preload("res://script/item/buf_item/buf_item_1.tscn").instantiate()
		parent.add_child(tonakai)
		for i in body.size():
			if enemy == i:tonakai.position = body[i].pos
	elif app_item == 2:
		var b = preload("res://script/item/buf_item/barrier_item.tscn").instantiate()
		parent.add_child(b)
		for i in body.size():
			if enemy == i:b.position = body[i].pos
	elif app_item == 3 and Global_var.bul_type1 == false:
		var shoot_item1 = preload("res://script/item/buf_item/shoot_item_1.tscn").instantiate()
		parent.add_child(shoot_item1)
		for i in body.size():
			if enemy == i:shoot_item1.position = body[i].pos
	
	elif app_item == 4 and Global_var.bul_type_def == false:
		var shoot_item2 = preload("res://script/item/buf_item/shoot_item_def.tscn").instantiate()
		parent.add_child(shoot_item2)
		for i in body.size():
			if enemy == i:shoot_item2.position = body[i].pos	
	elif app_item == 5:
		var curry = preload("res://script/item/score_item/curry.tscn").instantiate()
		parent.add_child(curry)
		for i in body.size():
			if enemy == i:curry.position = body[i].pos
	elif app_item == 6:
		var ice = preload("res://script/item/score_item/ice.tscn").instantiate()
		parent.add_child(ice)
		for i in body.size():
			if enemy == i:ice.position = body[i].pos
	elif app_item == 7:
		var water = preload("res://script/item/score_item/water.tscn").instantiate()
		parent.add_child(water)
		for i in body.size():
			if enemy == i:water.position = body[i].pos
	elif app_item == 8:
		var takoyaki = preload("res://script/item/score_item/takoyaki.tscn").instantiate()
		parent.add_child(takoyaki)
		for i in body.size():
			if enemy == i:takoyaki.position = body[i].pos
	elif app_item == 9:
		var cake = preload("res://script/item/score_item/cake.tscn").instantiate()
		parent.add_child(cake)
		for i in body.size():
			if enemy == i:cake.position = body[i].pos
	elif app_item_heart == 10:
		var heart = preload("res://script/item/buf_item/heart.tscn").instantiate()
		parent.add_child(heart)
		for i in body.size():
			if enemy == i:heart.position = body[i].pos		

func app_solo(body,parent):
	randomize()
	var app_item:int = randf_range(1,50)
	var app_item_heart:int = randi_range(1,300)
	if app_item == 1:
		var tonakai = preload("res://script/item/buf_item/buf_item_1.tscn").instantiate()
		parent.add_child(tonakai)
		tonakai.position = body.position
	elif app_item == 2:
		var b = preload("res://script/item/buf_item/barrier_item.tscn").instantiate()
		parent.add_child(b)
		b.position = body.position
	elif app_item == 3 and Global_var.bul_type1 == false:
		var shoot_item1 = preload("res://script/item/buf_item/shoot_item_1.tscn").instantiate()
		parent.add_child(shoot_item1)
		shoot_item1.position = body.position
	
	elif app_item == 4 and Global_var.bul_type_def == false:
		var shoot_item2 = preload("res://script/item/buf_item/shoot_item_def.tscn").instantiate()
		parent.add_child(shoot_item2)
		shoot_item2.position = body.position	
	elif app_item == 5:
		var curry = preload("res://script/item/score_item/curry.tscn").instantiate()
		parent.add_child(curry)
		curry.position = body.position
	elif app_item == 6:
		var ice = preload("res://script/item/score_item/ice.tscn").instantiate()
		parent.add_child(ice)
		ice.position = body.position
	elif app_item == 7:
		var water = preload("res://script/item/score_item/water.tscn").instantiate()
		parent.add_child(water)
		water.position = body.position
	elif app_item == 8:
		var takoyaki = preload("res://script/item/score_item/takoyaki.tscn").instantiate()
		parent.add_child(takoyaki)
		takoyaki.position = body.position
	elif app_item == 9:
		var cake = preload("res://script/item/score_item/cake.tscn").instantiate()
		parent.add_child(cake)
		cake.position = body.position
	elif app_item_heart == 10:
		var heart = preload("res://script/item/buf_item/heart.tscn").instantiate()
		parent.add_child(heart)
		heart.position = body.position	
