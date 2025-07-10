extends Node

@export var SELECTION_SIZE: int = 10
@export var NUM_PAIRINGS: int = 5
@export var MUTATION_DEVIATION: float = 0.8
@export var MUTATION_PROBABILITY: float = 0.25:
	get:
		return MUTATION_PROBABILITY
	set(value):
		MUTATION_PROBABILITY = clampf(value, 0.0, 1.0)
@export var MUTATION_DECAY: bool = true
@export var BIRD_INDEX: int = 0
