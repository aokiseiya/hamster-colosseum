extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var p1 = get_node("P1")
onready var p2 = get_node("P2")
onready var stage = get_node("FinalCage")
onready var respawn_audio = get_node("RespawnSFX")
onready var death_audio = get_node("DeathSFX")
onready var ui = get_node("UI")
enum {LEFT, RIGHT}

func _ready():
	p1.lives = GAME_CONFIG.max_lives
	p2.lives = GAME_CONFIG.max_lives
	p1.spawn = stage.get_node("P1SpawnPos").position
	p2.spawn = stage.get_node("P2SpawnPos").position
	p2.dir_facing = Vector2(-1,0)
	p1.connect("death", self, "player_died")
	p2.connect("death", self, "player_died")

func _process(delta):
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

	ui.p1_update_health(p1.damage)	
	ui.p2_update_health(p2.damage)
	ui.p1_update_life(p1.lives)
	ui.p2_update_life(p2.lives)
	
	

func player_died(player):
	player.lives -= 1
	if (player.lives > 0):
		respawn_audio.play()
		player.respawn(player.spawn)
	else:
		death_audio.play()
		if(player.get_name() == "P1"):
			get_tree().change_scene("res://scenes/GameOverP1.tscn")
		else:
			get_tree().change_scene("res://scenes/GameOverP2.tscn")