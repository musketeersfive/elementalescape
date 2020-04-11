extends "res://resources/objects/pickups/pickup.gd"

#func _ready():
	#connect("body_entered",self,"body_entered")
	
func body_entered(body):
	if body.name == "player" && body.get("keys") < 9: #max 9 keys, can't show more in numbers yet
		body.keys += 1
		queue_free()
