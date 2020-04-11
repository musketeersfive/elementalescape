class_name entity

extends KinematicBody2D

export(String) var TYPE = "ENEMY"
export(float) var MAXHEALTH = 2
export(int) var SPEED = 70
export(float) var health = MAXHEALTH

var movedir = Vector2(0,0)
var knockdir = Vector2(0,0)
var spritedir = "down" #string on which way to face, default "down"

var hitstun = 0 #when positive the entity is stunned
var texture_default = null
var texture_hurt = null

func _ready():
	health = MAXHEALTH
	if TYPE == "ENEMY":
		set_collision_mask_bit(1,1) #stop enemies from getting stuck outside camera dimensions (see mask and layer in StaticBody2d camera)
		set_physics_process(false)
	texture_default = $Sprite.texture
	texture_hurt = load($Sprite.texture.get_path().replace(".png","_hurt.png"))

func movement_loop():
	var motion
	if hitstun == 0:
		motion = movedir.normalized() * SPEED
	else:
		motion = knockdir.normalized() * 125
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
	health = min(MAXHEALTH, health)
	if hitstun > 0:
		hitstun -= 1
		$Sprite.texture = texture_hurt
	else:
		$Sprite.texture = texture_default
		if TYPE == "ENEMY" && health <= 0:
			var drop = randi() % 3 #0-3
			if drop == 0:
				instance_scene(preload("res://resources/objects/pickups/heart.tscn")) #25% chance
			instance_scene(preload("res://resources/objects/hazards/hazard_death.tscn"))
			queue_free() #enemy dies
	for area in $hitbox.get_overlapping_areas():
		var body = area.get_parent()
		if hitstun == 0 and body.get("DAMAGE") != null and body.get("TYPE") != TYPE:
			health -= body.get("DAMAGE")
			hitstun = 10
			knockdir = global_transform.origin - body.global_transform.origin
			
			#Play sound on hurt
			var audioPlayer = AudioStreamPlayer.new()
			self.add_child(audioPlayer)
			audioPlayer.stream = load("res://assets/sounds/sfx/ow.wav")
			audioPlayer.play()

func use_item(item):
	var newitem = item.instance()
	newitem.add_to_group(str(item, self))
	add_child(newitem)
	if get_tree().get_nodes_in_group(str(newitem.get_name(), self)).size() > newitem.maxamount:
		newitem.queue_free() #if more than allowed then delete it
		
func instance_scene(scene):
	var new_scene = scene.instance()
	new_scene.global_position = global_position
	get_parent().add_child(new_scene)
