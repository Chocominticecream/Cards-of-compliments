extends Control

@onready var countdown : Timer = $Timer
@onready var countdownlabel : RichTextLabel = $TimerLabel

# Called when the node enters the scene tree for the first time.
func _ready():
    EventsBus.connect("countdown", startCountDown)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    countdownlabel.text = "Time: " + "%02d" % time_left_to_live()

func time_left_to_live():
    var time_left = countdown.time_left
    var second = int(time_left) % 60
    return second

func startCountDown(time):
    countdown.wait_time = time
    countdown.start()
