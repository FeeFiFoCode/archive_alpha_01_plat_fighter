extends Node

var itemData = {}
var data_file_path = "res://data/CharacterAttributes.json"

func _ready():
	itemData = load_json_file(data_file_path)

func load_json_file( filePath : String ):
	if FileAccess.file_exists(filePath):
		
		var dataFile = FileAccess.open(filePath, FileAccess.READ )
		var parsedResults = JSON.parse_string(dataFile.get_as_text())
		
		if parsedResults is Dictionary:
			return parsedResults
			
		else:
			print("Error reading file!")
		
		
		
	else:
		print("File does not exist!")
		
