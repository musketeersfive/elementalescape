class_name entity

extends KinematicBody2D

export(String) var TYPE = "ENEMY"
export(int) var SPEED = 70

var movedir = Vector2(0,0)
var knockdir = Vector2(0,0)
var spritedir = "down" #string on which way to face, default "down"

var hitstun = 0 #when positive the entity is stunned
var health = 1

func movement_loop():
	var motion
	if hitstun == 0:
		motion = movedir.normalized() * SPEED
	else:
		motion = knockdir.normalized() * SPEED * 1.5
	move_and_slide(motion, Vector2(0,0))
	
func spritedir_loop():
	match movedir: #switch statement
		Vector2(-1, 0):
			spritedir = "left"
		Vector2(1, 0):
			spritedir = "right"
		Vector2(0, -1):
			spritedir = "up"
		Vector2(0, 1):
			spritedir = "down"
	
func anim_switch(animation): #based on names of animations
	var newanim = str(animation, spritedir)
	if $anim.current_animation != newanim:
		$anim.play(newanim)

func damage_loop():
	if hitstun > 0:
		hitstun -= 1
	for area in $hitbox.get_overlapping_areas():
		var body = area.get_parent()
		if hitstun == 0 and body.get("DAMAGE") != null and body.get("TYPE") != TYPE:
			health -= body.get("DAMAGE")
			hitstun = 10
			knockdir = global_transform.origin - body.global_transform.origin

func use_item(item):
	var newitem = item.instance()
	newitem.add_to_group(str(item, self))
	add_child(newitem)
	if get_tree().get_nodes_in_group(str(newitem.get_name(), self)).size() > newitem.maxamount:
		newitem.queue_free() #if more than allowed then delete it
