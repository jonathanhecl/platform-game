extends CharacterBody2D

var dir = 0
var move_x = 0
var move_y = 0

var last_ground = Vector2()

func _ready():
	last_ground = position

func _physics_process(delta):
	is_out_map()
	
	move_y += 10
	
	dir = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))

	if dir == 1:
		move_x = 300
	elif dir == -1:
		move_x = -300
	else:
		move_x = 0
		
	if is_on_floor():
		move_y = 0
		
		if Input.is_action_pressed("ui_up"):
			last_ground = position
			move_y = -500

	velocity = Vector2(move_x, move_y)
	move_and_slide()

func is_out_map():
	if position.y > 800:
		position = last_ground
