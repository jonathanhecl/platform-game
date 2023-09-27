extends CharacterBody2D

var dir = 0
var move_x = 0
var move_y = 0

var last_ground = Vector2()

var has_won = false

func _ready():
	last_ground = position

func _physics_process(delta):
	if has_won:
		move_y += 10
		if is_on_floor():
			move_y = -500
			$AnimationPlayer.play("jump")
		velocity = Vector2(0, move_y)
		move_and_slide()
		return
	
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
			$AnimationPlayer.play("jump")

	velocity = Vector2(move_x, move_y)
	move_and_slide()

func is_out_map():
	if position.y > 800:
		position = last_ground
