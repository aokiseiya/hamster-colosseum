extends KinematicBody2D

# class member variables go here, for example:
var damage = 0
var disabled_timer

signal attacking(area, dmg, dir)
signal attacked(area)

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
var attack_damage = 10
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

func is_self_box(area):
	for box in get_node("CollisionBoxes").get_children():
		if area == box:
			return true
	return false

func onHit(area, dmg, dir):
	if !is_self_box(area) && is_hit_box(area):
		emit_signal("attacked", self)
		emit_signal ("attacking", area.get_parent().get_parent(), dmg, dir)
		print("collided")

func is_hit_box(area):
	for hitbox in get_tree().get_nodes_in_group("hit_box"):
		if area == hitbox:
			return true
	return false




#func _on_HurtBoxUp_area_entered(area):
#	onHit(area, attack_damage, Vector2(0,1))
#
#
#func _on_HurtBoxDown_area_entered(area):
#	onHit(area, attack_damage, Vector2(0,-1))
#
#
#func _on_HurtBoxRight_area_entered(area):
#	onHit(area, attack_damage, Vector2(-1,0))
#
#
#func _on_HurtBoxLeft_area_entered(area):
#	onHit(area, attack_damage, Vector2(1,0))
#
#
#func _on_Player_attacking(area, dmg, dir):
#	pass # replace with function body
#
#
#func _on_Player_attacked(area):
#	pass # replace with function body

#var is_attacking = false
#$HamsterUp.disabled = true
#$HamsterDown.disabled = true
#etc.
# 

func _on_HitBox_area_entered(area):
	if area.is_in_group("attacks") && !is_self_box(area):
		#$area.disabled = false
		print(area.dir)