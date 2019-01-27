extends MarginContainer

onready var w2screen_label = $W2Screen/

func _ready():
	pass

func display(winner):
	if winner == 1:
		w2screen_label.hide()
		
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
