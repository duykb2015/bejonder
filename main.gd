extends Node

var score = 0

func add_score(score_to_add:float) -> float:
	score += score_to_add
	print(score)

	return score

func _input(event: InputEvent) -> void:
	pass
	# if event is InputEventMouseMotion:
	# 	print(event.relative)
	# if event is InputEventKey:
	# 	print(event.as_text())

func process_time_event(event) -> void:
	var timer := Timer.new()
	timer.wait_time = 1.0
	timer.autostart = true
	timer.timeout.connect(event)
	add_child(timer)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_time_event(func(): add_score(1))

	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
