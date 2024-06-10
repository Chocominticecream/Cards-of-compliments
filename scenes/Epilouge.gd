extends Node2D

@onready var score = $Score
@onready var blurb = $ResultsBlurb

# Called when the node enters the scene tree for the first time.
func _ready():
    $Score.text = "[center]" + str(Singleton.score) + "/" + str(Singleton.maxscore) + " words found!"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    checkScore()


func _on_texture_button_pressed():
    get_tree().change_scene_to_file("res://scenes/title_screen_group.tscn")

func checkScore():
    var resulttext
    if Singleton.score == Singleton.maxscore:
        resulttext = "[center]Wow you actually found all the words! I'm impressed! I feel like I should give a special prize for this but I have none, I'm too lazy to code it in"
    elif Singleton.score >= 15:
        resulttext = "[center]Wow you are a master word finder! Those guys will be really happy to receive your card! Bet you can't find all the words though!"
    elif Singleton.score >= 10:
        resulttext = "[center]You have done really well! You found many words! You have made some people happy today!"
    elif Singleton.score >= 5:
        resulttext = "[center]Nice work! you sure did compliment those guys well!"
    else:
        resulttext = "[center]You tried your best! Don't worry! It's the thought that counts!"
    
    blurb.text = resulttext
