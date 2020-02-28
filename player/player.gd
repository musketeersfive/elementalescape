extends entity

func _physics_process(delta):
	controls_loop()
	movement_loop()
	spritedir_loop()
	
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
	
	#print(spritedir)
	
	#interactions_listener
	

func controls_loop():
	var LEFT     = Input.is_action_pressed("ui_left")
	var RIGHT    = Input.is_action_pressed("ui_right")
	var UP       = Input.is_action_pressed("ui_up")
	var DOWN     = Input.is_action_pressed("ui_down")
	
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)
	

