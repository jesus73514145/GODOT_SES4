extends CharacterBody3D

var move_speed : float = 4.0
var jump_force : float = 8.0
var gravity : float = 20.0

var facing_angle : float

var score : int

@onready var model : MeshInstance3D = get_node("Model")
@onready var score_text : Label = get_node("ScoreText")

func _physics_process(delta):
	# apply gravity if we're in the air
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_force
	
	# get keyboard input
	var input = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	# calculate move direction
	var dir = Vector3(input.x, 0, input.y)
	
	# assign that direction to velocity
	velocity.x = dir.x * move_speed
	velocity.z = dir.z * move_speed
	
	# apply velocity
	move_and_slide()
	
	# if we are moving, set facing direction
	if input.length() > 0:
		facing_angle = Vector2(input.y, input.x).angle()
	
	# rotate model to facing direction
	model.rotation.y = lerp_angle(model.rotation.y, facing_angle, 0.5)
	
	if global_position.y < -5:
		game_over()

# called when we fall off the level or get hit by an enemy
func game_over ():
	get_tree().reload_current_scene()

# called when we collect a coin
func add_score (amount):
	score += amount
	score_text.text = str("Score: ", score)
