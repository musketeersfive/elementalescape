class_name entity

extends KinematicBody2D

export(int) var SPEED = 70

var movedir = Vector2(0,0)
var spritedir = "down" #string on which way to face, default "down"

func movement_loop():
	var motion = movedir.normalized() * SPEED
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
	
func anim_switch(animation):
	var newanim = str(animation, spritedir)
	if $anim.current_animation != newanim:
		$anim.play(newanim)
