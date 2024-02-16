extends Resource
class_name Stats

@export var health : int = 100
@export var mana : int = 100
@export var stamina : int = 100
@export var physical_damage : int = 0
@export var magical_damage : int = 0

@export var strength : int = 10
@export var intelligence : int = 10
@export var willpower : int = 10
@export var endurance : int = 10
#dex = evaison
@export var dexterity : int = 10
#luck = crit
@export var luck : int = 10

func _ready() -> void:
	physical_damage = strength * 2
	magical_damage = intelligence * 2
	mana = (intelligence + willpower) * 5
	stamina = (strength + endurance) * 5

func damage(value : int):
	health -= value
