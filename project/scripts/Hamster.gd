extends "res://scripts/Player.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var dash_speed = 0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

	
func _physics_process(delta):
	velocity = get_normalized_velocity()
	if shift_down:
		velocity *= dash_speed
	else:
		velocity *= walk_speed
	move_and_slide(velocity)
#	pass
