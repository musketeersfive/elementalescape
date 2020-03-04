extends entity

var state = "default"

func _physics_process(delta):
	match state: #start state machine
		"default":
			state_default()
		"swing":
			state_swing()

func state_default():
	controls_loop()
	movement_loop()
	spritedir_loop()
	damage_loop()
	
	if is_on_wall(): #push wall if walking into it
		if spritedir == "left" and test_move(transform, dir.left):
			anim_switch("push")
		if spritedir == "right" and test_move(transform, dir.right):
			anim_switch("push")
		if spritedir == "up" and test_move(transform, dir.up):
			anim_switch("push")
		if spritedir == "down" and test_move(transform, dir.down):
			anim_switch("push")
			
	elif movedir != dir.center: #if not standing still
		anim_switch("walk")
	else:
		anim_switch("idle")
		
	if Input.is_action_just_pressed("a"):
		use_item(preload("res://items/sword.tscn"))

func state_swing():
	anim_switch("idle")
	damage_loop()

func controls_loop():
	var LEFT     = Input.is_action_pressed("ui_left")
	var RIGHT    = Input.is_action_pressed("ui_right")
	var UP       = Input.is_action_pressed("ui_up")
	var DOWN     = Input.is_action_pressed("ui_down")
	
	#Add both IF statements below to allow diagonals, keep for pkmn-like movement
	#if movedir.y == 0:
	movedir.x = -int(LEFT) + int(RIGHT)
	#if movedir.x == 0:
	movedir.y = -int(UP) + int(DOWN)
	
