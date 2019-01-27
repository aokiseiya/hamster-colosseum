extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var p1 = get_node("P1")
onready var p2 = get_node("P2")
onready var stage = get_node("FinalCage")
onready var p1_spawn_pos = stage.get_node("P1SpawnPos")
onready var p_spawn_pos = stage.get_node("P2SpawnPos")

func _ready():
	p1.lives = GAME_CONFIG.max_lives
	p2.lives = GAME_CONFIG.max_lives

func _physics_process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	# Get input
	p1.up_down = Input.is_action_pressed("p1_up")
	p1.down_down = Input.is_action_pressed("p1_down")
	p1.left_down = Input.is_action_pressed("p1_left")
	p1.right_down = Input.is_action_pressed("p1_right")
	p1.shift_down = Input.is_action_pressed("p1_shift")
	p1.attack_down = Input.is_action_pressed("p1_attack")
	p2.up_down = Input.is_action_pressed("p2_up")
	p2.down_down = Input.is_action_pressed("p2_down")
	p2.left_down = Input.is_action_pressed("p2_left")
	p2.right_down = Input.is_action_pressed("p2_right")
	p2.shift_down = Input.is_action_pressed("p2_shift")
	p2.attack_down = Input.is_action_pressed("p2_attack")

func player_died(player):
	if (player.lives > 0):
		player.respawn(player.spawn_pos)
	print(player.get_name() + " lost!")