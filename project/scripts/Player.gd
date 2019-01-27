extends KinematicBody2D

# class member variables go here, for example:
signal death(player)
var damage = 0
onready var disabled_timer = get_node("Disabled")
onready var invul_blink_timer = get_node("InvulBlink")
var invul_timer
var lives = 0
var spawn = Vector2(0,0)
var knockback_remaining = 0
var is_translucent = false
var dir_facing = Vector2(1,0)

func _ready():
	pass

export var walk_speed = 0
var attacking = false
var attack_animation_played = false

var up_down = false
var down_down = false
var left_down = false
var right_down = false
var shift_down = false
var is_attacking = false
var attack_down = false
var velocity

var disabled = false
var invulnerable = false

func get_normalized_velocity():
#	get_input()
	velocity = Vector2()
	if !disabled:
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

func disable_for(amount):
	disabled_timer.wait_time = amount
	disabled_timer.start()
	disabled = true

func is_self_box(area):
	for box in get_node("CollisionBoxes").get_children():
		if area == box:
			return true
	return false

func make_invulnerable(time):
	invul_timer = get_node("Invul")
	invul_timer.set_wait_time(time)
	invul_timer.start()
	invulnerable = true
	
func init(pos):
	damage = 0
	dir_facing = Vector2(1,0)
	position = pos
	knockback_remaining = 0

func respawn(pos):
	init(pos)
	make_invulnerable(2)
	_ready()
	

func _on_Invul_timeout():
	invulnerable = false
	print("stopped")
	is_translucent = false
	invul_timer.stop()

func killed():
	emit_signal("death", self)
	
func knockedback(amount, dir):
	velocity = dir * GAME_CONFIG.knockback_speed
	print(float(damage) / 100)
	knockback_remaining = (amount * (float(damage) / 100.0)) + 20
	print(knockback_remaining)

func _on_Disabled_timeout():
	disabled = false
	disabled_timer.stop()
	


func _on_InvulBlink_timeout():
	if invulnerable:
		if is_translucent:
			is_translucent=false
		else:
			is_translucent = true
