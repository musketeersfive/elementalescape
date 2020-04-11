extends CanvasLayer

onready var player = get_node("../player")

const HEART_ROW_SIZE = 8 #hearts per row until next row
const HEART_OFFSET = 8 #how far apart hearts are
#note: hearts are 7x7

func _ready():
	var i = 0
	while i < player.MAXHEALTH:
		var new_heart = Sprite.new()
		new_heart.texture = $hearts.texture
		new_heart.hframes = $hearts.hframes
		$hearts.add_child(new_heart)
		i = i + 1
	
	for heart in $hearts.get_children():
		var index = heart.get_index()
		
		var x = (index % HEART_ROW_SIZE) * HEART_OFFSET
		var y = (index / HEART_ROW_SIZE) * HEART_OFFSET
		heart.position = Vector2(x,y)

func _process(delta):
	for heart in $hearts.get_children():
		var index = heart.get_index()
		
		var last_heart = floor(player.health)
		if index > last_heart:
			heart.frame = 0;
		if index == last_heart:
			heart.frame = (player.health - last_heart) * 4
		if index < last_heart:
			heart.frame = 4
	
	$keys.frame = player.keys
