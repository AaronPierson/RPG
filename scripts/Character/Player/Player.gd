extends CharacterBody2D


@export var walk_speed = 5
@export var stats : Resource
@export var tile_size = 16
@onready var axis = Vector2.ZERO
@onready var ray_cast_2d = $RayCast2D

var initial_position = Vector2(0,0)
var input_direction = Vector2(0,0)

enum PlayerState{ IDLE, TURNING, WALKING}
enum FacingDirection{ UP, RIGHT, DOWN, LEFT}
var player_state = FacingDirection.LEFT
var facing_direction = FacingDirection.LEFT

var is_moving = false
var percent_moved_to_next_tile = 0.0
var target_position = Vector2.ZERO
@onready var animation_tree = $AnimationTree
@onready var anim_state = animation_tree.get("parameters/playback")


func _ready():
	initial_position = position
	animation_tree.active = true


func _physics_process(delta):

	if player_state == PlayerState.TURNING:
		return

	elif is_moving == false:
		process_player_input()
	elif input_direction != Vector2.ZERO:
		anim_state.travel("walk")
		move(delta)
	else:
		anim_state.travel("idle")
		is_moving = false
	
	

func process_player_input():
	if input_direction.y == 0:
		input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	if input_direction.x == 0:
		input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	if input_direction != Vector2.ZERO:
		animation_tree.set("parameters/idle/blend_position", input_direction)
		animation_tree.set("parameters/walk/blend_position", input_direction)
		animation_tree.set("parameters/turn/blend_position", input_direction)
		if need_to_turn():
			player_state = PlayerState.TURNING
			anim_state.travel("turn")
		else:	
			initial_position = position
			is_moving = true
	else:
		anim_state.travel("idle")
		
func move(delta):
	var desired_step: Vector2 = input_direction * tile_size / 2
	ray_cast_2d.target_position = desired_step
	ray_cast_2d.force_raycast_update()
	if !ray_cast_2d.is_colliding():
		percent_moved_to_next_tile += walk_speed * delta
		if percent_moved_to_next_tile >= 1.0:
			position = initial_position + (tile_size * input_direction)
			percent_moved_to_next_tile = 0.0
			is_moving = false
		else:
			position = initial_position + (tile_size * input_direction * percent_moved_to_next_tile)
	else:
		is_moving = false
	
func need_to_turn():
	var new_facing_direction
	if input_direction.x < 0:
		new_facing_direction = FacingDirection.LEFT
	elif input_direction.x > 0:
		new_facing_direction = FacingDirection.RIGHT
	elif input_direction.y < 0:
		new_facing_direction = FacingDirection.UP
	elif input_direction.y > 0:
		new_facing_direction = FacingDirection.DOWN	
	
	if facing_direction != new_facing_direction:
		facing_direction = new_facing_direction
		return true
	facing_direction = new_facing_direction
	return false
		

func finished_turning():
	player_state = PlayerState.IDLE
	

	
	
	
# Save the player's stats
#var save_path = "res://saved_data/player_stats.tres"
#ResourceSaver.save(save_path, stats)

# Load the player's stats
#var loaded_stats : Stats = ResourceLoader.load(save_path) as Stats
