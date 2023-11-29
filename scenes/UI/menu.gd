extends Control
enum menuLoaded{
	NOTHING,
	MAIN,
	PARTY,
	BAG,
	SAVE,
	LOAD
}

var loaded = menuLoaded.NOTHING

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func _unhandled_input(event):
	match menuLoaded:
		menuLoaded.NOTHING:
			if event.is_action_pressed("menu"):
				visible = true
				loaded = menuLoaded.MAIN
				
		menuLoaded.MAIN:
			if event.is_action_pressed("menu") or event.is_action_pressed("ui_cancel"):
				visible = false
				loaded = menuLoaded.NOTHING
	
	
