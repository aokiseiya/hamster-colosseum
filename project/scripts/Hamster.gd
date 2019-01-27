extends "res://scripts/Player.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var dash_speed = 0
var dash_timer
var dashCooldown_timer
var isDashing
onready var sprite = get_node("Sprite/Anim")
enum {LEFT, RIGHT}
var idling = true

var facing = RIGHT

func _ready():
	dash_timer = get_node("Dash")
	dash_timer.set_wait_time(0.5)
	dashCooldown_timer = get_node("DashCooldown")
	dashCooldown_timer.set_wait_time(1)	
	sprite.play("right-idle")

func _physics_process(delta):
	isDashing = false
	velocity = get_normalized_velocity()
	if shift_down && dashCooldown_timer.is_stopped():
		dash_timer.start()
	if (!dash_timer.is_stopped()):
		velocity *= dash_speed
		isDashing = true
	else:
		velocity *= walk_speed
	animate()
	move_and_slide(velocity)

func animate():
	if disabled_timer.is_stopped():
		var initial_idle = idling
		var initial_facing = facing
		idling = false
		if left_down:
			dir_facing = Vector2(-1,0)
			facing = LEFT
		elif right_down:
			dir_facing = Vector2(1,0)
			facing = RIGHT
		elif up_down:
			dir_facing = Vector2(0,-1)
		elif down_down:
			dir_facing = Vector2(0,1)
		else:
			idling = true
		if idling && !initial_idle:
			if facing == LEFT:
				sprite.play("left-idle")
			elif facing == RIGHT:
				sprite.play("right-idle")
		elif !idling && initial_idle || initial_facing != facing:
			if facing == LEFT:
				sprite.play("left-walk")
			elif facing == RIGHT:
				sprite.play("right-walk")
		
		
		



func _on_Disabled_timeout():
    disabled_timer.stop()

func _on_Dash_timeout():
	dash_timer.stop()
	dashCooldown_timer.start()

func _on_DashCooldown_timeout():
	dashCooldown_timer.stop()
