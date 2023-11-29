extends Resource
class_name Quests

enum Status {UNKNOWN, MENTIONED, ACCEPTED, ACHIEVED, COMPLETED}

@export var name : String
@export var botch : bool = false
@export var status: Status = Status.UNKNOWN
@export_multiline var description : String

func set_state(state: Status) -> void:
	status = state

func get_state() -> Status:
	return status

func set_botch(flag: bool) -> void:
	botch = flag
