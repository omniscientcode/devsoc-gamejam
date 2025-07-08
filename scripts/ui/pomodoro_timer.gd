extends Control

@onready var label: Label = $Label
@onready var timer: Timer = $Timer
@onready var start_pause_button: Button = $startPauseButton

const WORK_TIME = 25 * 60
const SHORT_BREAK = 5 * 60
const LONG_BREAK = 15 * 60
const CYCLES_BEFORE_LONG_BREAK = 4 

var time_remaining = WORK_TIME
var curr_cycles = 0
var is_running = false
var working = true

func _ready() -> void:
	start_pause_button.text = "Start"
	update_timer_label()

func _on_timer_timeout() -> void:
	time_remaining -= 1
	update_timer_label()
	if time_remaining <= 0:
		if working:
			curr_cycles += 1
			if curr_cycles % CYCLES_BEFORE_LONG_BREAK == 0:
				start_break(LONG_BREAK)
			else:
				start_break(SHORT_BREAK)
		else:
			start_work()

func update_timer_label() -> void:
	var minutes = time_remaining / 60
	var seconds = time_remaining % 60
	label.text = "%02d:%02d" % [minutes, seconds]

func start_break(duration: int) -> void:
	working = false
	time_remaining = duration
	update_timer_label()
	stop_timer()
	start_pause_button.text = "Start"

func start_work() -> void:
	working = true
	time_remaining = WORK_TIME
	update_timer_label()
	stop_timer()
	start_pause_button.text = "Start"

func start_timer() -> void:
	is_running = true
	timer.start()
	start_pause_button.text = "Pause"

func stop_timer() -> void:
	is_running = false
	if not timer.is_stopped():
		timer.stop()

func _on_start_pause_button_pressed() -> void:
	if is_running:
		stop_timer()
		start_pause_button.text = "Start"
	else:
		start_timer()
