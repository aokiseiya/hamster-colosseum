extends KinematicBody2D

# class member variables go here, for example:
var damage = 0
var disabled_timer

func _ready():
	disabled_timer = get_node("Disabled")
	disabled_timer.set_wait_time(1)

export var walk_speed = 0

var up_down = false
var down_down = false
var left_down = false
var right_down = false
var shift_down = false
var hit = false
var velocity

#func get_input():
#	up_down = false
#	down_down = false
#	left_down = false
#	right_down = false
#	shift_down = false
#	if Input.is_action_pressed("ui_left"):
#		left_down = true
#	if Input.is_action_pressed("ui_right"):
#		right_down = true
#	if Input.is_action_pressed("ui_up"):
#		up_down = true
#	if Input.is_action_pressed("ui_down"):
#		down_down = true
#	if Input.is_action_just_pressed("ui_tempshift"):
#		shift_down = true
#		print("down")
	

func get_normalized_velocity():
#	get_input()
	velocity = Vector2()
	if disabled_timer.is_stopped():
		if up_down:
			velocity.y -= 1
		if down_down:
			velocity.y += 1
		if left_down:
			velocity.x -= 1
		if right_down:
			velocity.x += 1
	return velocity.normalized()


func damage(amount):
	damage += amount

func killed():
	print("Ded")
