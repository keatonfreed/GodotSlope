extends Label

var score = -1
func add_score():
	score += 1
	if score < 0:
		text = "0"
	else:
		text = str(score)
