extends Control

func set_score(value: int) -> void:
	%ScoreLabel.text = 'S: ' + str(value)
	
func set_high_score(value: int) -> void:
	%HighScoreLabel.text = 'H: ' + str(value)
	
func set_generation(value: int) -> void:
	%GenerationLabel.text = 'Gen: ' + str(value)
