extends Resource
class_name Quests

@export var name : String
@export var botch : bool = false
@export_enum("UNKOWN",
	"MENTION",
	"ACCEPTED",
	"ACHIEVED",
	"COMPLTED",
) var states: String
@export_multiline var Description : String

func set_state(State):
	pass
	
func get_state():
	pass

func set_botch(flag):
	pass


