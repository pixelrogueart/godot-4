extends GlobalTools


func load_data(file_name):
	var data = load_json("res://data/" + file_name + ".json")
	if data:
		return data
	return {}

func load_folder(folder: String):
	var dir = DirAccess.open("res://data/" + folder)
	var folder_data = {}
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				pass
			else:
				if file_name.ends_with(".json"):
					if file_name[0] != ".":
						var base_name = file_name.get_basename()
						folder_data[base_name] = load_data("%s/%s" % [folder, base_name])
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("An error occurred when trying to access the path.")
	return folder_data

func merge_dictionaries(base_dict: Dictionary, mod_dict: Dictionary) -> Dictionary:
	for key in mod_dict.keys():
		base_dict[key] = mod_dict[key]
	return base_dict
