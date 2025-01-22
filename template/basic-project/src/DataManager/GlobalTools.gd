class_name GlobalTools
extends Node

func load_json(_path:String):
	var file = FileAccess.open(_path, FileAccess.READ)
	if !file:
		print("No files at %s."%_path)
		return
	var content = file.get_as_text()
	var json = JSON.new()
	var error = json.parse(content)
	if error == OK:
		var dataReceived = json.data
		return dataReceived
	else:
		print(_path)
		print("JSON Parse Error")
		return null

func save_json(_path:String,content):
	var file = FileAccess.open(_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(content))

func retrieve_files_in_folder(path:String,extension:String):
	var files = {}
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				pass
			else:
				if file_name.ends_with("."+extension):
					var file = load(dir.get_current_dir() + "/" + file_name)
					files[file_name] = file
					pass
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return files

func find_all_classes_in_node(parent_node:Node, type):
	var nodes = []
	for child in parent_node.get_children():
		if is_instance_of(child, type):
			nodes.append(child)
		nodes.append_array(find_all_classes_in_node(child,type))
	return nodes
