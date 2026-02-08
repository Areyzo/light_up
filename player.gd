extends CharacterBody2D

var max_bounces = 10
var has_won = false  # Flag to prevent multiple popups

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
@onready var ray = $RayCast2D
@onready var line = $Body/Line2D

func _process(delta: float) -> void:
	line.clear_points()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		line.add_point(Vector2.ZERO)
		# define initial raycast
		ray.global_position = line.global_position
		ray.target_position = (get_global_mouse_position() - line.global_position).normalized() * 1000.0
		ray.force_raycast_update()
		
		var  prev = null
		var bounces = 0
		
		while true:
			if not ray.is_colliding():
				var pt = ray.global_position + ray.target_position
				line.add_point(line.to_local(pt))
				break
			var coll = ray.get_collider()
			var pt = ray.get_collision_point()
			line.add_point(line.to_local(pt))
			print("Ray hit: ", coll.name)  # Debug output
			if not coll.is_in_group("Mirrors"):
				# Check if light hit the goal
				if (coll.is_in_group("Goal") or coll.name == "goal") and not has_won:
					show_win_popup()
				break
			var normal = ray.get_collision_normal()
			if normal == Vector2.ZERO:
				break
			
			# update collisions
			if prev != null:
				prev.collision_mask = 3
				prev.collision_layer = 3
			prev = coll
			prev.collision_mask = 0
			prev.collision_layer = 0
			
			# update raycast
			ray.global_position = pt
			ray.target_position = ray.target_position.bounce(normal)
			ray.force_raycast_update()
			
			bounces +=1
			if bounces >= max_bounces:
				break
			
		if prev != null:
			prev.collision_mask = 3
			prev.collision_layer = 3

func show_win_popup() -> void:
	has_won = true
	get_tree().paused = true  # Pause the game
	
	var dialog = ConfirmationDialog.new()
	dialog.title = "You Win!"
	dialog.dialog_text = "You win!"
	dialog.ok_button_text = "Play Again"
	dialog.process_mode = Node.PROCESS_MODE_ALWAYS  # Allow dialog to process while paused
	
	add_child(dialog)
	
	dialog.confirmed.connect(func(): 
		get_tree().paused = false  # Unpause before reloading
		get_tree().reload_current_scene()
	)
	
	dialog.custom_action.connect(func(action: String):
		if action == "quit":
			get_tree().paused = false  # Unpause before quitting
			get_tree().quit()
	)
	
	dialog.add_button("Quit", false, "quit")
	dialog.get_cancel_button().hide()
	dialog.popup_centered_ratio(0.3)
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
const SPEED := 300.0
const JUMP_FORCE := -450.0

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)

	# flip sprite
	if input_dir.x > 0:
		$Body.scale.x = 1
	elif input_dir.x < 0:
		$Body.scale.x = -1

	# horizontal movement ONLY
	velocity.x = input_dir.x * SPEED

	# gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# jump using move_up
	if input_dir.y < 0 and is_on_floor():
		velocity.y = JUMP_FORCE

	move_and_slide()
