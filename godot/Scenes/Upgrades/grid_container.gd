extends GridContainer

func _process(_delta: float) -> void:
	var children = get_children()
	var insert_index = 0
	for i in range(children.size()):
		if children[i].resource != children[i].placeholder:
			if i != insert_index:
				var temp = children[i].resource
				children[i].resource = children[i].placeholder
				children[insert_index].resource = temp
				children[i].update_self()
				children[insert_index].update_self()
			insert_index += 1
