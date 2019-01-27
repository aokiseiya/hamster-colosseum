extends MarginContainer

onready var w2screen_label = $W2Screen/

func _ready():
	pass

#func display(winner):
#	if winner == 1:
#		w2screen_label.hide()

func _on_Restart_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
