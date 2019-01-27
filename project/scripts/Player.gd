extends KinematicBody2D

# class member variables go here, for example:
signal death(player)
var damage = 0
onready var disabled_timer = get_node("Disabled")
var invul_timer
var lives = 0
var spawn = Vector2(0,0)
var knockback_remaining = 0

var dir_facing = Vector2(1,0)

func _ready():
	pass

export var walk_speed = 0

var up_down = false
var down_down = false
var left_down = false
var right_down = false
var shift_down = false
var is_attacking = false
var attack_down = false
var attack_damage = 10
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

func is_hit_box(area):
	for hitbox in get_tree().get_nodes_in_group("hit_box"):
		if area == hitbox:
			return true
	return false


#func _on_HitBox_area_entered(area):
#	if area.is_in_group("attacks") && !is_self_box(area):
#		damage(area.damage)
#		print(area.knockback)
#		knockedback(area.knockback, area.dir)

func make_invulnerable(time):
	invul_timer = get_node("Invul")
	invul_timer.set_wait_time(time)
	invul_timer.start()
	invulnerable = true
	
func init(pos):
	damage = 0
	dir_facing = Vector2(1,0)
	position = pos

func respawn(pos):
	init(pos)
	make_invulnerable(2)
	_ready()
	

func _on_Invul_timeout():
	invulnerable = false
	invul_timer.stop()

func killed():
	print("so gafgsrfv")
	emit_signal("death", self)
	
func knockedback(amount, dir):
	velocity = dir * GAME_CONFIG.knockback_speed
	knockback_remaining = amount
	print(knockback_remaining)

func _on_Disabled_timeout():
	print("stopped")
	disabled = false
	disabled_timer.stop()
	
