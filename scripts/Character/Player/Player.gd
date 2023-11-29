extends CharacterBody2D


@export var walk_speed = 4
@export var stats : Resource
@export var tile_size = 16
@onready var axis = Vector2.ZERO

var initial_position = Vector2(0,0)
var input_direction = Vector2(0,0)

var is_moving = false
var percent_moved_to_next_tile = 0.0
var target_position = Vector2.ZERO
@onready var animation_player = $AnimationPlayer


func _ready():
	initial_position = position


func _physics_process(delta):

	if is_moving == false:
		process_player_input()
	elif input_direction != Vector2.ZERO:
		move(delta)
	else:
		is_moving = false
	
	

func process_player_input():
	if input_direction.y == 0:
		input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	if input_direction.x == 0:
		input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	if input_direction != Vector2.ZERO:
		initial_position = position
		is_moving = true
		
func move(delta):
	percent_moved_to_next_tile += walk_speed * delta
	if percent_moved_to_next_tile >= 1.0:
		position = initial_position + (tile_size * input_direction)
		percent_moved_to_next_tile = 0.0
		is_moving = false
	else:
		position = initial_position + (tile_size * input_direction * percent_moved_to_next_tile)
	

# Save the player's stats
#var save_path = "res://saved_data/player_stats.tres"
#ResourceSaver.save(save_path, stats)

# Load the player's stats
#var loaded_stats : Stats = ResourceLoader.load(save_path) as Stats
