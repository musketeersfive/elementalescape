extends Area2D

export(bool) var disappears = false

func _ready(): 
	connect("body_entered",self,"body_entered")
	connect("area_entered",self,"area_entered")
	
func area_entered(area):
	var area_parent = area.get_parent() #eg. an item like "sword" has an area component and the parent is the sword overall
	if area_parent.name == "sword":
		body_entered(area_parent.get_parent())

func body_entered(body):
	pass
