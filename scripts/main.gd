extends Node

@export var PIPE_SCENE: PackedScene
@export var AGENT_SCENE: PackedScene
@export var INIT_POPULATION_SIZE: int = 10
var pipe_queue = []
var population = []
var agents = []
var score = 0
var high_score = 0
const PIPE_POOL_COUNT = 8
var dead_count = 0
var generation_start_time
var generation = 1
var point_awarded = false

func _ready() -> void:
	initialize_pipes()
	initialize_random_weights()
	initialize_generation()
	
func initialize_random_weights():
	for i in range(INIT_POPULATION_SIZE):
		population.append([[randf_range(-0.7, 0.7), randf_range(-0.7, 0.7), randf_range(-0.5, 0.5)], 0])
		
func initialize_pipes() -> void:
	for i in range(PIPE_POOL_COUNT):
		var pipe = PIPE_SCENE.instantiate()
		pipe.position = $PipeOrigin.position
		pipe.agent_crossed.connect(on_agent_crossed_pipe)
		pipe.body_entered.connect(on_agents_entered_pipe)
		add_child(pipe)
		pipe_queue.append(pipe)

func initialize_agents() -> void:
	for i in range(len(population)):
		var agent = AGENT_SCENE.instantiate()
		agent.position = $AgentOrigin.position
		agent.get_closest_pipe_position = get_closest_pipe_position
		agent.agent_died.connect(on_agent_died)
		agent.initialize(population[i][0])
		agents.append(agent)
		call_deferred("add_child", agent)
		
		if i == 0:
			agent.get_node('Sprite2D').modulate = Color.YELLOW
			agent.get_node('Sprite2D').z_index = 3

func on_agents_entered_pipe(agent):
	point_awarded = false
	
func _on_pipe_end_area_entered(area: Area2D) -> void:
	var pipe = area
	pipe.moving = false
	pipe.position = $PipeOrigin.position
	pipe_queue.append(pipe)

func _on_pipe_spawn_timer_timeout() -> void:
	$PipeSpawnTimer.wait_time = randf_range(1, 3)
	if len(pipe_queue) != 0:
		var pipe = pipe_queue.pop_front()
		pipe.moving = true
		var y_deviation = 50
		pipe.position.y += randi_range(-y_deviation, y_deviation)
		pipe.activated = false
	else:
		print_debug('Error: Attempted to spawn a pipe when pipe queue is empty. Consider increasing the pipe pool count')

func on_agent_crossed_pipe() -> void:
	if not point_awarded:
		score += 1
		%HUD.set_score(score)
		point_awarded = true

func get_closest_pipe_position() -> Vector2:
	var agent_position = $AgentOrigin.position.x
	var closest_pipe_distance = 10000
	var closest_pipe_global_pos = null
	
	for child in get_children():
		if not child.is_in_group('pipes'):
			continue
			
		var pipe_width = child.get_node('CollisionShape2D').shape.get_rect().size.x
		if child.position.x + (pipe_width / 2) < agent_position:
			continue
			
		var distance = child.position.x - agent_position
		if distance < closest_pipe_distance:
			closest_pipe_distance = distance
			closest_pipe_global_pos = child.global_position

	return closest_pipe_global_pos

func on_agent_died() -> void:
	dead_count += 1
	if dead_count == len(population):
		select_fittest(INIT_POPULATION_SIZE)
		reset_world()
		initialize_generation()

func breed() -> void:
	var parent_pairs = get_random_parent_pairs(INIT_POPULATION_SIZE)
	var offsprings = []
	for couple in parent_pairs:
		var parent_a = population[couple[0]][0]
		var parent_b = population[couple[1]][0]
		
		var offspring = crossover(parent_a, parent_b)
		offsprings.append([mutate(offspring, 0.8), generation])
		
	population.append_array(offsprings)
	print('Current pool:')
	for weight in population:
		print(weight[0])
	print()

func crossover(parent_a, parent_b) -> Array:
	var offspring = []
	for i in range(len(parent_a)):
		offspring.append((parent_a[i] + parent_b[i]) / 2.0)
			
	return offspring

func mutate(individual, deviation: float) -> Array:
	var mut_prob = float(1.0/6)
	deviation /= generation
	
	for i in range(len(individual)):
		if randf() < mut_prob:
			individual[i] = randfn(individual[i], deviation)
			individual[i] = clampf(individual[i], -2.5, 2.5)
			
	return individual
	
func get_random_parent_pairs(n_pairs: int) -> Array:
	var pairs = []
	for i in range(n_pairs):
		pairs.append(Vector2i(randi_range(0, len(population) - 1), randi_range(0, len(population) - 1)))
		
	return pairs

func select_fittest(n: int) -> void:
	var fitnesses = []
	for i in range(len(population)):
		var weights = population[i]
		var agent = agents[i]
		var fitness = agent.last_time_alive - generation_start_time
		fitnesses.append([fitness, weights])
	
	fitnesses.sort_custom(func(a, b): return a[0] > b[0])
	
	population.clear()
	agents.clear()
	for i in range(n):
		population.append(fitnesses[i][1])
	
	print('Generation ended. Best fit:')
	print('\t', fitnesses[0][1][0], ' Born in generation: ', fitnesses[0][1][1])
	print()
	print('New population pool:')
	for individual in population:
		print(individual[0])
	print('----------------------')

func reset_world() -> void:
	dead_count = 0
	if score > high_score:
		high_score = score
		%HUD.set_high_score(high_score)
	score = 0
	%HUD.set_score(score)
	pipe_queue.clear()
	for child in get_children():
		if child.is_in_group('pipes'):
			child.moving = false
			child.position = $PipeOrigin.position
			pipe_queue.append(child)
		elif child.is_in_group('agent'):
			child.queue_free()
	generation += 1
	%HUD.set_generation(generation)
	
func initialize_generation() -> void:
	print('Generation:', generation)
	generation_start_time = Time.get_ticks_msec()
	breed()
	initialize_agents()
