extends Node
class_name QuestManager

var quests: Dictionary = {}

func _ready() -> void:
	# Add all quests to the QuestManager
	for quest in load_all_quests():
		add_quest(quest)

func load_all_quests() -> Array:
	var quests: Array = []
	var dir = DirAccess.open("res://")

	# Assuming your quests are stored in "res://scripts/Resource/Quest/"
	if dir.change_dir("scripts/Resource/Quests/Kid") == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir() and file_name.get_extension() == "tres":
				var quest_resource = load("res://scripts/Resource/Quests/Kid/" + file_name) as Quests
				quests.append(quest_resource)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the directory.")
		
	return quests



func add_quest(quest: Quests) -> void:
	quests[quest.name] = quest

func remove_quest(quest_name: String) -> void:
	quests.erase(quest_name)

func get_quest(quest_name: String) -> Quests:
	return quests[quest_name]

func get_active_quests() -> Array:
	var active_quests: Array = []
	for quest in quests.values():
		if quest.get_state() != Quests.Status.UNKNOWN:
			active_quests.append(quest)
	return active_quests
