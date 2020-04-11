extends TileMap

#allows us to use the enemies tilemap to spawn enemies based on tileset and filename

var alive = false

func _ready():
	connect("visibility_changed",self,"visibility_changed")
	
func visibility_changed():
	if(alive):
		var size = get_cell_size()
		var offset = size / 2
		for tile in get_used_cells():
			var name = get_tileset().tile_get_name(get_cell(tile.x, tile.y))
			var node = load(str("res://enemies/",name,".tscn")).instance()
			node.global_position = tile * size + offset #vector2 values
			#get x and y, multiplied by size of each cell, plus half cell size (center of cell)		
			get_parent().call_deferred("add_child", node)
			#must use call_deferred in _ready function instead of add_child
		queue_free()
	elif(!alive):
		self.visible = false
