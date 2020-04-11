extends "res://pickups/pickup.gd"

func body_entered(body):
	if body.name == "player":
		body.items.append("fire_wand")
		queue_free()
		get_node("../ui_text").text = "Yay fire wand! Burn!!!!"
		
		#Add timer here to make the ui-text disappear after 5 seconds?
		
		get_node("../hazards").alive = true
		get_node("../hazards").visible = true
