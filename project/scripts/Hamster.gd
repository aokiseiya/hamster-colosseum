extends "res://scripts/Player.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var dash_speed = 0
var dash_timer
var dashCooldown_timer

func _ready():
	dash_timer = get_node("Dash")
	dash_timer.set_wait_time(0.5)
	dashCooldown_timer = get_node("DashCooldown")
	dashCooldown_timer.set_wait_time(1)	

func _physics_process(delta):
	velocity = get_normalized_velocity()
	if shift_down && dashCooldown_timer.is_stopped():
		dash_timer.start()
	if (!dash_timer.is_stopped()):
		velocity *= dash_speed
	else:
		velocity *= walk_speed
	move_and_slide(velocity)

func _on_Disabled_timeout():
    disabled_timer.stop()

func _on_Dash_timeout():
	dash_timer.stop()
	dashCooldown_timer.start()

func _on_DashCooldown_timeout():
	dashCooldown_timer.stop()
