extends "res://scripts/Player.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var dash_speed = 0
var dash_timer
var dashCooldown_timer
var isDashing
onready var sprite = get_node("Sprite/Anim")
onready var attack_timer = get_node("AttackTimer")
onready var attack_cd = get_node("AttackCooldown")
enum {LEFT, RIGHT}
var idling = true

onready var hit_box = get_node("CollisionBoxes/HitBox")

onready var up_hurt_box = get_node("CollisionBoxes/HamsterUp")
onready var left_hurt_box = get_node("CollisionBoxes/HamsterLeft")
onready var right_hurt_box = get_node("CollisionBoxes/HamsterRight")
onready var down_hurt_box = get_node("CollisionBoxes/HamsterDown")

var facing = RIGHT

func _ready():
	dash_timer = get_node("Dash")
	dash_timer.set_wait_time(0.5)
	dashCooldown_timer = get_node("DashCooldown")
	dashCooldown_timer.set_wait_time(1)	
	sprite.play("right-idle")
	toggle_hurtboxes(false)

func _physics_process(delta):
	if is_translucent:
		get_node("Sprite").modulate = Color(1,1,1,0.5)
	else:
		get_node("Sprite").modulate = Color(1,1,1,1)
	if knockback_remaining <= 0:
		knockback_remaining = 0
		normal_process(delta)
		move_and_slide(velocity)
		check_attacked()
	else:
		knockback_remaining -= velocity.length() * delta
		move_and_slide(velocity)
	

func check_attacked():
	for area in hit_box.get_overlapping_areas():
		if area.is_in_group("attacks") && !is_self_box(area) && knockback_remaining <= 0 && !invulnerable:
			damage(area.damage)
			print(area.damage)
			print(damage)
			knockedback(area.knockback, area.dir)

func normal_process(delta):
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
	if attack_down:
		attack()

func animate():
	if !attack_animation_played && attacking:
		if dir_facing == Vector2(-1,0):
			sprite.play("left-melee")
		elif dir_facing == Vector2(1,0):
			sprite.play("right-melee")
		elif dir_facing == Vector2(0,-1) && facing == LEFT:
			sprite.play("left-upattack")
		elif dir_facing == Vector2(0,-1) && facing == RIGHT:
			sprite.play("right-upattack")
		elif dir_facing == Vector2(0,1) && facing == LEFT:
			sprite.play("left-downattack")
		elif dir_facing == Vector2(0,1) && facing == RIGHT:
			sprite.play("right-downattack")
		attack_animation_played = true
	elif attacking:
		pass
	elif !disabled:
		animate_movement()
			
func animate_movement():
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
		
		
		
func attack():
	if !disabled && attack_timer.is_stopped() &&  attack_cd.is_stopped():
		disable_for(0.5)
		attacking = true
		match dir_facing:
			Vector2(1,0):
				right_hurt_box.monitoring = true
				right_hurt_box.monitorable = true
			Vector2(-1,0):
				left_hurt_box.monitoring = true
				left_hurt_box.monitorable = true
			Vector2(0,1):
				down_hurt_box.monitoring = true
				down_hurt_box.monitorable = true
			Vector2(0,-1):
				up_hurt_box.monitoring = true
				up_hurt_box.monitorable = true
		attack_timer.start()
				


func _on_Dash_timeout():
	dash_timer.stop()
	dashCooldown_timer.start()

func _on_DashCooldown_timeout():
	dashCooldown_timer.stop()

func toggle_hurtboxes(boo):
	right_hurt_box.monitoring = boo
	right_hurt_box.monitorable = boo
	left_hurt_box.monitoring = boo
	left_hurt_box.monitorable = boo
	up_hurt_box.monitoring = boo
	up_hurt_box.monitorable = boo
	down_hurt_box.monitoring = boo
	down_hurt_box.monitorable = boo

func _on_AttackTimer_timeout():
	attack_cd.start()
	attacking = false
	attack_animation_played = false
	attack_timer.stop()
	toggle_hurtboxes(false)

func _on_AttackCooldown_timeout():
	attack_cd.stop()
