extends AudioStreamPlayer

const music = preload("res://assets/audio/+v¦¦(Daystar)-Cozy Cafe-[AudioTrimmer.com].mp3")

#audio credits
# https://www.youtube.com/watch?v=jg_kYYy-LfU


func _play_music(music: AudioStream, volume = 1.0):
    if stream == music:
       return 
    
    stream = music
    volume_db = volume
    play()

func playmusic():
    _play_music(music)

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass
