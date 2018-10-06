extends KinematicBody2D

enum STATES {IDLE, WALKING}

export (int) var money_held = 10

var state
var speed = 100
var velocity = Vector2()

func _ready():
	change_state(IDLE)

func _process(delta):
	match state:
		IDLE:
			pass
		WALKING:
			pass

func _physics_process(delta):
	move_and_slide(velocity)

func change_state(new_state):
	state = new_state
	match new_state:
		WALKING:
			var direction = Vector2(randf()*2-1, randf()*2-1)
			look_at(direction + global_position)
			velocity = direction.normalized() * speed
		IDLE:
			velocity = Vector2()
		
	$change_state_timer.wait_time = randi()%5+1
	$change_state_timer.start()

func _on_change_state_timer_timeout():
	if state == IDLE:
		change_state(WALKING)
	elif state == WALKING:
		change_state(IDLE)
