extends Node

enum CROSSOVER_SELECTION_METHODS { Random, Fitness_Based }
enum GENE_CROSSOVER_METHODS { Averaging, Gene_Wise }
enum MUTATION_DECAY_METHODS { None, Exponential, Inverse_Time, Quadratic }
@onready var RANDOM_SEED: int

@export var INITIAL_POPULATION_SIZE: int = 10
@export var SELECTION_SIZE: int = 10
@export var NUM_PAIRINGS: int = 5
@export var MUTATION_DEVIATION: float = 0.8
@export var MUTATION_PROBABILITY: float = 0.25:
	get:
		return MUTATION_PROBABILITY
	set(value):
		MUTATION_PROBABILITY = clampf(value, 0.0, 1.0)
@export var MUTATION_DECAY: MUTATION_DECAY_METHODS
@export var BIRD_INDEX: int = 0
@export var CROSSOVER_SELECTION_METHOD: CROSSOVER_SELECTION_METHODS
@export var GENE_CROSSOVER_METHOD: GENE_CROSSOVER_METHODS
@export var PLAY: bool = false

func _ready() -> void:
	RANDOM_SEED = randi_range(-99999, 99999)
