extends RigidBody2D

@export var JUMP_VEL: int = 400
@export var BIRDS: Array[PackedScene]
@export var bird_index: int = 0

var get_closest_pipe_position: Callable
var weights: Array
var alive: bool = true
var last_time_alive: float = 0.0
signal agent_died

func _ready() -> void:
	set_bird(bird_index)
	
func _physics_process(delta: float) -> void:
	if not alive:
		return
		
	if should_flap(sense()):
		flap()

func initialize(init_weights) -> void:
	weights = init_weights
	
func should_flap(inputs: Array[float]) -> bool:
	var output = sigmoid(inputs[0] * weights[0] + inputs[1] * weights[1] + weights[2])
	return output > 0.5

func sigmoid(x: float) -> float:
	return 1.0 / (1.0 + exp(-x))

func sense() -> Array[float]:
	var h_distance_to_pipe = get_closest_pipe_position.call().x - global_position.x
	var height_difference_from_pipe = global_position.y - get_closest_pipe_position.call().y
	
	var max_h_distance = get_viewport_rect().size.x
	var max_v_distance = get_viewport_rect().size.y / 2
	
	return [h_distance_to_pipe / max_h_distance, height_difference_from_pipe / max_v_distance]

func flap() -> void:
	if linear_velocity.y > 0:
		linear_velocity = Vector2(0, -JUMP_VEL)

func _on_body_entered(body: Node) -> void:
	if not alive:
		return
		
	if body.is_in_group('obstacle'):
		alive = false
		last_time_alive = Time.get_ticks_msec()
		agent_died.emit()

func crown() -> void:
	%Crown.visible = true

func increase_z_index() -> void:
	z_index = 3
	
func set_bird(index: int = 0) -> void:
	var bird = BIRDS[index].instantiate()
	bird.name = "BirdSprite"
	bird.set_unique_name_in_owner(true)
	add_child(bird)

func set_bird_index(value: int) -> void:
	bird_index = clamp(value, 0, len(BIRDS) - 1)
