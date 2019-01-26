extends KinematicBody2D

# class member variables go here, for example:
var damage = 0

onready var disabled_timer = get_node("Disabled")

export var walk_speed = 0
export var dash_speed = 0

var up_down = false
var down_down = false
var left_down = false
var right_down = false


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.

	
	pass

func damage(amount):
	damage += amount

