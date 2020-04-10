extends Node2D

var TYPE = null
export(float) var DAMAGE = 0.5

var maxamount = 1 #how many of this item can exist for an entity
#eg. arrows 3 means only 3 arrows on screen from this entity

func _ready():
	TYPE = get_parent().TYPE
	$anim.connect("animation_finished",self,"destroy")
	$anim.play(str("swing",get_parent().spritedir))
	if get_parent().has_method("state_swing"):
		get_parent().state = "swing"
	
func destroy(_animation):
	if get_parent().has_method("state_swing"):
		get_parent().state = "default"
	queue_free() #delete itself so a new item can be spawned later
