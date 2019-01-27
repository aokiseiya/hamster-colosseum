extends MarginContainer

onready var p1_HP_label = $HBoxContainer/Bars/P1HPBar/Count/Background/Number/
onready var p2_HP_label = $HBoxContainer/Bars/P2HPBar/Count/Background/Number/
onready var p1_life_label = $HBoxContainer/Bars/P1LifeBar/Count/Background/Number/
onready var p2_life_label = $HBoxContainer/Bars/P2LifeBar/Count/Background/Number/

#var initial_health = "0"
#var initial_life = GAME_CONFIG.max_lives

#func _ready():
#	p1_HP_label.text = initial_health
#	p2_HP_label.text = initial_health
#	p1_life_label.text = initial_life
#	p2_life_label.text = initial_life

#Testing
#func _process(delta):
#	p1_update_health(int(p1_HP_label.text) + 1)
#	p2_update_health(int(p2_HP_label.text) + 1)
#	p1_update_life(int(p1_life_label.text) - 1)
#	p2_update_life(int(p2_life_label.text) - 1)

func p1_update_health(new_value):
	p1_HP_label.text = str(new_value)

func p2_update_health(new_value):
	p2_HP_label.text = str(new_value)

func p1_update_life(new_value):
	p1_life_label.text = str(new_value)

func p2_update_life(new_value):
	p2_life_label.text = str(new_value)