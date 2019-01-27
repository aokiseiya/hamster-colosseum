extends "res://scripts/Player.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var dash_speed = 0
var dash_timer
var dashCooldown_timer
var isDashing
onready var sprite = get_node("Sprite/Anim")


func _ready():
	dash_timer = get_node("Dash")
	dash_timer.set_wait_time(0.5)
	dashCooldown_timer = get_node("DashCooldown")
	dashCooldown_timer.set_wait_time(1)	

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
		if (velocity.x == 0 && velocity.y == 0) && dir_facing != Vector2(0,0):
			dir_facing = Vector2(0,0)
			sprite.play("right-idle")
		elif left_down && dir_facing != Vector2(-1,0):
			dir_facing = Vector2(-1,0)
			sprite.play("left-walk")
		elif right_down && dir_facing != Vector2(1,0):
			dir_facing = Vector2(1,0)
			sprite.play("right-walk")
		



func _on_Disabled_timeout():
    disabled_timer.stop()

func _on_Dash_timeout():
	dash_timer.stop()
	dashCooldown_timer.start()

func _on_DashCooldown_timeout():
	dashCooldown_timer.stop()
