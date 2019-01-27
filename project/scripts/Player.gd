extends KinematicBody2D

# class member variables go here, for example:
signal death(player)
var damage = 0
var disabled_timer
var invul_timer
var lives = 0
var spawn = Vector2(0,0)

var dir_facing = Vector2(1,0)

func _ready():
	disabled_timer = get_node("Disabled")
	disabled_timer.set_wait_time(1)

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

var invulnerable = false

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


func _on_HitBox_area_entered(area):
	if area.is_in_group("attacks") && !is_self_box(area):
		#$area.disabled = false
		print(area.dir)

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
	
